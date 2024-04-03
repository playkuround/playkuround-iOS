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
                    Button("책 뒤집기") {
                        viewModel.transition(to: .cardGame)
                    }
                }
                .onAppear {
                    mapViewModel.startUpdatingLocation()
                }
                .onDisappear {
                    // 홈 뷰에서 벗어날 때 위치 업데이트 중지
                    mapViewModel.stopUpdatingLocation()
                }
            case .myPage:
                MyPageView(viewModel: viewModel)
            case .cardGame:
                CardGameView(viewModel: CardGameViewModel(.book, rootViewModel: self.viewModel, mapViewModel: self.mapViewModel, timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
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
