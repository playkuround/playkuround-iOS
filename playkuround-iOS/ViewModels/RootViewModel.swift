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
        withAnimation(.spring(duration: 0.2, bounce: 0.3)) {
            currentView = viewType
        }
    }
}

enum ViewType {
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
    
    // my page
    case myPage
}
