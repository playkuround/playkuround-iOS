//
//  HomeViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/31/24.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    // User Profile
    @Published var userData: UserEntity = UserEntity(nickname: "", major: "", myRank: MyRank(score: 0, ranking: 0), highestScore: 0, highestRank: "")
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
                            self.userData.myRank = myRank
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
}

enum HomeViewType {
    case home
    case attendance // AttendanceView
    case badge // 뱃지
    case ranking // 랭킹
    case myPage // MyPageView
    
    case landmark // LandmarkView
}
