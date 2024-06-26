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
