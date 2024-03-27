//
//  RootView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/27/24.
//

import SwiftUI

struct RootView: View {
    // current presenting view type
    @State private var currentView: ViewType = .main
    
    // loading
    @State private var isLoading: Bool = true
    
    // Network Manager Instance
    @StateObject private var networkManager = NetworkManager()
    @ObservedObject var viewModel: RootViewModel = RootViewModel()
    
    var body: some View {
        ZStack {
            switch currentView {
            case .main:
                MainView(currentView: $currentView)
            case .login:
                LoginView(currentView: $currentView)
            case .registerTerms:
                RegisterTermsView(currentView: $currentView)
            case .registerMajor:
                RegisterView(currentView: $currentView)
            case .registerNickname:
                RegisterNickname(currentView: $currentView)
            case .home:
                // 임시 구현
                Text("Home")
            }
            
            // network error
            if !networkManager.isConnected {
                NetworkErrorView(loadingColor: .white)
            }
            // loading
            else if isLoading {
                LoadingView(loadingColor: .white)
            }
        }
        .onAppear {
            // 확인 작업
            isLoading = false
        }
    }
    
    /// 현재 앱의 version 정보를 반환
    private func currentAppVersion() -> String {
        if let info: [String: Any] = Bundle.main.infoDictionary, let currentVersion: String = info["CFBundleShortVersionString"] as? String {
            return currentVersion
        }
        return ""
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
}

#Preview {
    RootView()
}
