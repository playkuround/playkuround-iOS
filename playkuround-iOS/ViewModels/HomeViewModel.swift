//
//  HomeViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/31/24.
//

import Combine
import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    // User Profile
    @Published var userData: UserEntity = UserEntity(nickname: "", major: "",
                                                     myRank: MyRank(score: 0, ranking: 0, profileBadge: "NONE"),
                                                     landmarkRank: MyRank(score: 0, ranking: 0, profileBadge: "NONE"),
                                                     highestScore: 0, highestRank: "")
    @Published var badgeList: [BadgeResponse] = []
    @Published var attendanceList: [String] = []
    
    let landmarkDescriptions: [LandmarkDescription] = load("LandmarkDescription.json")
    
    // Landmark
    @Published var selectedLandmarkID: Int = 0
    
    // Ranking
    @Published var landmarkRank: [Ranking] = []
    @Published var totalRank: [Ranking] = []
    
    // 화면 전환용
    @Published var viewStatus: HomeViewType = .home
    
    // Adventure
    @Published var gameName: String = ""
    @Published var isStartButtonEnabled: Bool = false
    
    private let gameNames = ["책 뒤집기", "덕쿠를 잡아라", "수강신청 All 클릭", "덕큐피트", "문을 점령해", "일감호에서 살아남기", "건쏠지식", "10초를 맞춰봐"]
    private var currentIndex = 0
    private var delayMillis: TimeInterval = 0.05
    private var speedUpInterval: TimeInterval = 0.25
    private var isSpeedingUp = true
    private var lastIndex = -1
    private var timer: AnyCancellable? = nil
    @Published var isGameNameShowing: Bool = true

    // MARK: - User Profile Data
    // 유저 프로필 데이터 불러오는 함수
    func loadUserData() {
        APIManager.callGETAPI(endpoint: .users) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                
                if let response = data as? APIResponse {
                    if response.isSuccess {
                        DispatchQueue.main.async {
                            self.userData.nickname = response.response?.nickname ?? "-"
                            self.userData.major = response.response?.major ?? "-"
                            self.userData.highestScore = response.response?.highestScore ?? 0
                            self.userData.highestRank = response.response?.highestRank ?? "-"
                        }
                    }
                }
                
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
        
        APIManager.callGETAPI(endpoint: .scoresRank) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                
                if let response = data as? APIResponse {
                    if response.isSuccess {
                        DispatchQueue.main.async {
                            self.userData.myRank.score = response.response?.myRank?.score ?? 0
                            self.userData.myRank.ranking = response.response?.myRank?.ranking ?? 0
                        }
                    }
                }
                
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
    }
    
    // MARK: - Badge List
    // 유저 뱃지 목록 불러오는 함수
    func loadBadge() {
        APIManager.callGETAPI(endpoint: .badges) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                
                if let response = data as? BadgeListResponse {
                    if let badgeList = response.response as [BadgeResponse]? {
                        DispatchQueue.main.async {
                            self.badgeList = badgeList
                            print(self.badgeList.count)
                        }
                    }
                }
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
    }
    
    // MARK: - Attendance
    // 유저 출석 불러오는 함수
    func loadAttendance() {
        APIManager.callGETAPI(endpoint: .attendances) { result in
            switch result {
            case .success(let data):
                print("Attendance GET: \(data)")
                
                if let response = data as? APIResponse {
                    if let attendances = response.response?.attendances {
                        DispatchQueue.main.async {
                            self.attendanceList = attendances
                            print(self.attendanceList)
                        }
                    }
                }
                
            case .failure(let error):
                print("Error in View: \(error)")
                
            }
        }
    }
    
    func attendance(latitude: Double, longitude: Double) {
        APIManager.callPOSTAPI(endpoint: .attendances, parameters: ["latitude": latitude, "longitude": longitude]) { result in
            switch result {
            case .success(_):
                self.loadAttendance()
                self.loadUserData()
                self.loadBadge()
            case .failure(let error):
                // TODO: 건국대학교 범위 외 혹은 다른 이유로 출석 실패 시 예외 처리 필요 (추후 APIManager 작업 시 구현)
                print("Error in View: \(error)")
            }
        }
    }
    
    // MARK: - Total Ranking
    func loadTotalRanking() {
        APIManager.callGETAPI(endpoint: .scoresRank) { result in
            switch result {
            case .success(let data):
                print("loadTotalRanking(): \(data)")
                
                if let response = data as? APIResponse {
                    if let myRank = response.response?.myRank {
                        DispatchQueue.main.async {
                            self.userData.myRank = myRank
                            print(self.userData)
                        }
                    }
                    
                    if let rank = response.response?.rank {
                        DispatchQueue.main.async {
                            self.totalRank = rank
                            print(self.totalRank)
                        }
                    }
                }
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
    }
    
    // MARK: - Landmark Ranking
    func loadLandmarkRanking(landmarkID: Int) {
        APIManager.callGETAPI(endpoint: .scoresRankLandmark, landmarkID: landmarkID) { result in
            switch result {
            case .success(let data):
                print("loadLandmarkRanking(): \(data)")
                
                if let response = data as? APIResponse {
                    if let myRank = response.response?.myRank {
                        DispatchQueue.main.async {
                            self.userData.landmarkRank = myRank
                            print(self.userData)
                        }
                    }
                    
                    if let rank = response.response?.rank {
                        DispatchQueue.main.async {
                            self.landmarkRank = rank
                            print(self.landmarkRank)
                        }
                    }
                }
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
    }
    
    // MARK: - User Notification
    func loadUserNotification() {
        // TODO: 백엔드와 협의하여 version checking 도입 여부 결정 필요
        APIManager.callGETAPI(endpoint: .notification, querys: ["version": "1.0.0"]) { result in
            switch result {
            case .success(let data):
                print("loadUserNotifiation(): \(data)")
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
    }
    
    // MARK: - Landmark View
    func openLandmarkView(landmarkID: Int) {
        if landmarkID < 1 || landmarkID > landmarkList.count {
            print("index out of range \(landmarkID)")
            return
        }
        
        self.loadLandmarkRanking(landmarkID: landmarkID)
        
        DispatchQueue.main.async {
            self.selectedLandmarkID = landmarkID
            self.transition(to: .landmark)
        }
    }
    
    func getSelectedLandmark() -> Landmark {
        return landmarkList[self.selectedLandmarkID]
    }
    
    // MARK: - Transition among Home-Sub-View
    func transition(to: HomeViewType) {
        DispatchQueue.main.async {
            withAnimation(.spring(duration: 0.2, bounce: 0.3)) {
                self.viewStatus = to
            }
        }
    }
    
    // MARK: - Adventure
    func adventure(latitude: Double, longitude: Double) {
        print("latitude: \(latitude), longitude: \(longitude)")
        APIManager.callGETAPI(endpoint: .landmarks, querys: ["latitude": latitude, "longitude": longitude]) { result in
            switch result {
            case .success(let data):
                print("Nearest Landmark: \(data)")
                
                var nearestID = 0
                
                if let apiResponse = data as? APIResponse {
                    if let response = apiResponse.response {
                        if let id = response.landmarkId {
                            nearestID = id
                        }
                    }
                }
                
                // 성공적으로 반환
                if nearestID > 0 {
                    DispatchQueue.main.async {
                        self.selectedLandmarkID = nearestID
                    }
                    self.selectRandomGame()
                }
                // 가까운 랜드마크가 없음
                else {
                    // TODO: 예외 처리
                    print("가까운 랜드마크 없음")
                }
                
            case .failure(let error):
                print("Nearest Landmark Error: \(error)")
            }
        }
    }
    
    private func selectRandomGame() {
        self.transition(to: .adventure)
        print("가까운 랜드마크 ID: \(self.selectedLandmarkID)")
        
        // reset
        DispatchQueue.main.async {
            self.isStartButtonEnabled = false
            self.currentIndex = 0
            self.delayMillis = 0.05
            self.speedUpInterval = 0.25
            self.isSpeedingUp = true
            self.lastIndex = -1
        }
        
        startChangingText()
    }
    
    private func blinkText() {
        withAnimation(.easeInOut(duration: 0.2).repeatCount(3, autoreverses: true)) {
            isGameNameShowing.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.isGameNameShowing = true
            self.isStartButtonEnabled = true
        }
    }
    
    private func startChangingText() {
        DispatchQueue.main.async {
            self.gameName = self.gameNames[self.currentIndex]
            self.currentIndex += 1
        }
        
        if currentIndex >= self.gameName.count {
            if self.isSpeedingUp {
                self.delayMillis += 0.04
                print("delayMills: \(self.delayMillis)")
                
                if self.delayMillis >= self.speedUpInterval {
                    self.isSpeedingUp = false
                    self.timer?.cancel()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.lastIndex = Int.random(in: 0..<self.gameNames.count)
                        self.gameName = self.gameNames[self.lastIndex]
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.blinkText()
                        }
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                self.currentIndex = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.delayMillis) {
            self.startChangingText()
        }
    }
    
    private func stopChangingText() {
        self.timer?.cancel()
    }
    
    func getSelectedGameStatus() -> ViewType? {
        return ViewType(rawValue: self.gameName)
    }
}

enum HomeViewType {
    case home
    case attendance // AttendanceView
    case badge // 뱃지
    case ranking // 랭킹
    case myPage // MyPageView
    
    case landmark // LandmarkView
    case adventure
    
    case badgeProfile // 뱃지 프로필 변경
}
