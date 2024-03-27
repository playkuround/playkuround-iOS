//
//  RootView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/27/24.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel = RootViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.currentView {
            case .main:
                MainView(viewModel: viewModel)
            case .login:
                LoginView(viewModel: viewModel)
            case .registerTerms:
                RegisterTermsView(viewModel: viewModel)
            case .registerMajor:
                RegisterView(viewModel: viewModel)
            case .registerNickname:
                RegisterNickname(viewModel: viewModel)
            case .home:
                // 임시 구현
                Text("Home")
            case .myPage:
                // 임시 구현
                Text("My Page")
            }
            
            // network error
            if !viewModel.networkManager.isConnected {
                NetworkErrorView(loadingColor: .white)
            }
            // loading
            else if viewModel.isLoading {
                LoadingView(loadingColor: .white)
            }
        }
        .onAppear {
            // 확인 작업
            viewModel.isLoading = false
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

#Preview {
    RootView()
}
