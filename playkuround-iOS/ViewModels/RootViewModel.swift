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
    @Published var isLoading: Bool = true
    
    // Network Manager Instance
    @Published var networkManager = NetworkManager()
    
    // Story View
    @Published var showStory: Bool = false
    @Published var currentStoryIndex: Int = 0
    @Published var newlyUnlockedStoryIndex: Int?
    
    // New Badge View
    @Published var newBadgeViewShowing: Bool = false
    @Published var newBadgeList: [Badge] = []
    
    // Toast Message View
    @Published var toastMessageShowing: Bool = false
    @Published var toastMessage: String? = nil
    
    // 서버 점검 중
    @Published var serverError: Bool = false
    
    var openedGameTypes = UserDefaults.standard.stringArray(forKey: "openedGameTypes") ?? []
    var stories: [Story] = storyList
    
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
            APIManager.callPOSTAPI(endpoint: .dreamOfDuck) { result in
                switch result {
                case .success(let data as BoolResponse):
                    print("Data received in View: \(data)")
                    
                    // 오리의 꿈 뱃지 띄우기
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
        APIManager.callPOSTAPI(endpoint: .logout) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                // 토큰 삭제
                TokenManager.reset()
                // 메인 뷰로 전환
                self.transition(to: .main)
                
            case .failure(let error):
                print("로그아웃 실패")
                print("Error in View: \(error)")
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
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.newBadgeViewShowing = true
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
