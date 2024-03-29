//
//  RootView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/27/24.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel = RootViewModel()
    @ObservedObject var mapViewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.currentView {
            case .main:
                MainView(viewModel: viewModel, mapViewModel: mapViewModel)
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
                VStack {
                    Text("Home")
                    Button("Logout") {
                        viewModel.logout()
                    }
                    Button("myPage") {
                        viewModel.transition(to: .myPage)
                    }
                }
            case .myPage:
                MyPageView(viewModel: viewModel)
            }
            
            // network error
            if !viewModel.networkManager.isConnected {
                NetworkErrorView(loadingColor: .white)
            }
            // loading
            else if viewModel.isLoading {
                LoadingView(loadingColor: .white)
            }
            // Location Permission Request View
            else if viewModel.currentView == .home
                        && !(mapViewModel.isAuthorized == .authorizedAlways
                             || mapViewModel.isAuthorized == .authorizedWhenInUse) {
                RequestPermissionView(mapViewModel: mapViewModel)
            }
        }
        .onAppear {
            // 확인 작업
            viewModel.isLoading = false
        }
    }
}

#Preview {
    RootView()
}
