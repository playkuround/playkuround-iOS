//
//  RootViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/27/24.
//

import Foundation
import SwiftUI

final class RootViewModel: ObservableObject {
    // current presenting view type
    @Published var currentView: ViewType = .main
    
    // loading
    @Published var isLoading: Bool
    
    // Network Manager Instance
    @Published var networkManager: NetworkManager
    
    // Story View
    @Published var showStory: Bool
    @Published var currentStoryIndex: Int
    @Published var newlyUnlockedStoryIndex: Int?
    
    // New Badge View
    @Published var newBadgeViewShowing: Bool
    @Published var newBadgeList: [Badge]
    
    // Toast Message View
    @Published var toastMessageShowing: Bool
    @Published var toastMessage: String?
    
    // User Alarm Message
    @Published var alarmMessageShowing: Bool
    @Published var alarmMessage: String?
    
    // 서버 점검 중
    @Published var serverError: Bool
    
    // 서버 체크
    @Published var serverHealthy: Bool
    
    // 앱 업데이트 안내
    @Published var appUpdateAlarm: Bool
    
    var openedGameTypes: [String]
    var stories: [Story]
    
    init() {
        self.currentView = .main
        self.isLoading = false
        self.networkManager = NetworkManager()
        self.showStory = false
        self.currentStoryIndex = 0
        self.newlyUnlockedStoryIndex = nil
        self.newBadgeViewShowing = false
        self.newBadgeList = []
        self.toastMessageShowing = false
        self.toastMessage = nil
        self.alarmMessageShowing = false
        self.alarmMessage = nil
        self.serverError = false
        self.serverHealthy = false
        self.appUpdateAlarm = false
        self.openedGameTypes = UserDefaults.standard.stringArray(forKey: "openedGameTypes") ?? []
        
        let currentLanguage = Locale.current.language.languageCode?.identifier
                
        switch currentLanguage {
        case "ko":
            self.stories = storyListKorean
        case "en":
            self.stories = storyListEnglish
        case "zh":
            self.stories = storyListChinese
        default:
            self.stories = storyListKorean
        }
    }
    
    let soundManager = SoundManager()
    
    func previousStory() {
        if currentStoryIndex > 0 {
            currentStoryIndex -= 1
        }
    }
    
    func nextStory() {
        if currentStoryIndex < stories.count - 1 {
            currentStoryIndex += 1
        }
    }
    
    func saveOpenedGameType(_ gameType: GameType) {
        if !openedGameTypes.contains(gameType.rawValue) {
            openedGameTypes.append(gameType.rawValue)
            
            UserDefaults.standard.set(openedGameTypes, forKey: "openedGameTypes")
            
            unlockStoriesBasedOnGameTypes()
            
            if let index = findNewlyUnlockedStoryIndex() {
                DispatchQueue.main.async {
                    self.newlyUnlockedStoryIndex = index
                    self.currentStoryIndex = index
                    self.showStory = true
                    for i in self.stories.indices {
                        if i == index {
                            self.stories[i].isNew = true
                        }
                        else {
                            self.stories[i].isNew = false
                        }
                    }
                }
            }
        }
        else {
            DispatchQueue.main.async {
                self.showStory = false
            }
        }
    }
    
    func loadOpenedGameTypes() -> [GameType] {
        guard let savedGameTypes = UserDefaults.standard.stringArray(forKey: "openedGameTypes") else {
            return []
        }
        
        return savedGameTypes.compactMap { GameType(rawValue: $0) }
    }
    
    // 게임 종류의 수에 따라 스토리를 잠금 해제하는 함수
    func unlockStoriesBasedOnGameTypes() {
        for i in 0..<openedGameTypes.count {
            if i < stories.count {
                stories[i].isLocked = false
            }
        }
        
        // 모든 스토리를 다 봤을 때 오리의 꿈 api 호출
        if stories.allSatisfy({ !$0.isLocked }) {
            APIManager.shared.callPOSTAPI(endpoint: .dreamOfDuck) { result in
                switch result {
                case .success(let data as BoolResponse):
                    print("Data received in View: \(data)")
                    
                    // 오리의 꿈 뱃지 띄우기
                    // 만약 이미 받았다면 response가 false 임
                    if (data.response) {
                        self.openNewBadgeView(badgeNames: ["THE_DREAM_OF_DUCK"])
                    }
                case .failure(let error):
                    print("Error in View: \(error)")
                case .success(_):
                    // BoolResponse로 파싱 실패 시 예외 처리
                    print("cannot parse to BoolResponse")
                }
            }
        }
    }
    
    private func findNewlyUnlockedStoryIndex() -> Int? {
        for i in 0..<stories.count {
            if !stories[i].isLocked && openedGameTypes.count - 1 == i {
                return i
            }
        }
        return nil
    }
    
    // 현재 앱의 version 정보를 반환
    func currentAppVersion() -> String {
        if let info: [String: Any] = Bundle.main.infoDictionary,
           let currentVersion: String = info["CFBundleShortVersionString"] as? String {
            return currentVersion
        }
        return ""
    }
    
    // View Transition
    func transition(to viewType: ViewType) {
        // Main Thread에서 실행 보장
        DispatchQueue.main.async {
            withAnimation(.spring(duration: 0.2, bounce: 0.3)) {
                self.currentView = viewType
            }
        }
    }
    
    // 로그아웃
    func logout() {
        // Logout API 요청
        APIManager.shared.callPOSTAPI(endpoint: .logout) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                // 토큰 삭제
                TokenManager.reset()
                UserDefaults.standard.removeObject(forKey: "IS_ADMIN")
                // 메인 뷰로 전환
                self.transition(to: .main)
                self.openToastMessageView(message: NSLocalizedString("MyPage.Logout.Done", comment: ""))
            case .failure(let error):
                print("로그아웃 실패")
                self.openToastMessageView(message:
                                            NSLocalizedString("Network.ServerError", comment: ""))
            }
        }
    }
    
    // 회원 탈퇴
    func deleteAccount() {
        APIManager.shared.callGETAPI(endpoint: .users, delete: true) { result in
            switch result {
            case .success(let data):
                TokenManager.reset()
                UserDefaults.standard.removeObject(forKey: "IS_ADMIN")
                // 메인 뷰로 전환
                self.transition(to: .main)
                let message = NSLocalizedString("MyPage.DeleteAccount.AfterMessage", comment: "")
                self.openToastMessageView(message: message)
            case .failure(let error):
                print("계정 삭제 실패")
                self.openToastMessageView(message:
                                            NSLocalizedString("Network.ServerError", comment: ""))
            }
        }
    }
    
    // 새 뱃지 뷰
    func openNewBadgeView(badgeNames: [String], openNow: Bool = true) {
        DispatchQueue.main.async {
            for badge in badgeNames {
                let newBadge = Badge(rawValue: badge)
                
                if let newBadge = newBadge {
                    self.newBadgeList.append(newBadge)
                }
            }
            
            // 바로 열기
            if openNow {
                if !self.newBadgeList.isEmpty {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.newBadgeViewShowing = true
                    }
                }
            }
        }
    }
    
    func closeNewBadgeView() {
        DispatchQueue.main.async {
            if self.newBadgeList.count == 1 {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.newBadgeViewShowing = false
                }
            }
            
            self.newBadgeList.removeFirst()
        }
    }
    
    // 토스트 메시지 3초
    func openToastMessageView(message: String) {
        DispatchQueue.main.async {
            self.toastMessage = message
                .replacingOccurrences(of: "<br>", with: "\n")
            withAnimation(.easeInOut(duration: 0.3)) {
                self.toastMessageShowing = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.toastMessage = nil
            withAnimation(.easeInOut(duration: 0.3)) {
                self.toastMessageShowing = false
            }
        }
    }
    
    // 설정 열기
    func openSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    // 유저 알람 열기
    func openAlarmMessageView(message: String) {
        DispatchQueue.main.async {
            self.alarmMessage = message
            withAnimation(.easeInOut(duration: 0.3)) {
                self.alarmMessageShowing = true
            }
        }
    }
    
    // 유저 알람 닫기
    func closeAlarmMessageView() {
        DispatchQueue.main.async {
            self.alarmMessage = nil
            withAnimation(.easeInOut(duration: 0.3)) {
                self.alarmMessageShowing = false
            }
        }
    }
    
    // 시스템 검사
    func checkSystemAvailable() {
        APIManager.shared.callGETAPI(endpoint: .systemAvailable) { result in
            switch result {
            case .success(let data):
                if let response = data as? APIResponse {
                    if let systemAvailable = response.response?.systemAvailable {
                        if systemAvailable {
                            print("system is available")
                        } else {
                            DispatchQueue.main.async {
                                self.serverError = true
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.serverError = true
                        }
                    }
                    
                    // 메인 뷰에서는 앱 버전 체크하지 않음
                    /* if let supportAppVersions = response.response?.supportAppVersionList {
                        for version in supportAppVersions {
                            if version.os == "IOS" {
                                let appVersion = self.currentAppVersion()
                                
                                if !version.version.contains(appVersion) {
                                    let updateMessage = NSLocalizedString("Home.ToastMessage.UnsupportVersion", comment: "")
                                        .replacingOccurrences(of: "<br>", with: "\n")
                                    
                                    DispatchQueue.main.async {
                                        self.openAlarmMessageView(message: updateMessage)
                                    }
                                    break
                                }
                            }
                        }
                    }*/
                } else {
                    DispatchQueue.main.async {
                        self.serverError = true
                    }
                }
            case .failure(let error):
                print(error)
                // 서버 응답 없음
                DispatchQueue.main.async {
                    self.serverError = true
                }
            }
        }
    }
    
    // 앱 업데이트 알림 뷰 열기
    func openAppUpdateAlarm() {
        DispatchQueue.main.async {
            self.appUpdateAlarm = true
        }
    }
}

enum ViewType: String {
    // main
    case main
    
    // login
    case login
    
    // register
    case registerTerms
    case registerMajor
    case registerNickname
    
    // home
    case home
    
    // Games
    case cardGame = "책 뒤집기"
    case timeGame = "10초를 맞춰봐"
    case moonGame = "문을 점령해"
    case quizGame = "건쏠지식"
    case cupidGame = "덕큐피트"
    case allClickGame = "수강신청 All 클릭"
    case surviveGame = "일감호에서 살아남기"
    case catchGame = "덕쿠를 잡아라"
}
