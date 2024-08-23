//
//  RootView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/27/24.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    init() {
        let rootViewModel = RootViewModel()
        self.viewModel = rootViewModel
        self.mapViewModel = MapViewModel(rootViewModel: rootViewModel)
        self.homeViewModel = HomeViewModel(rootViewModel: rootViewModel)
    }
    
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
                HomeView(viewModel: viewModel, homeViewModel: homeViewModel, mapViewModel: mapViewModel)
            case .cardGame:
                CardGameView(viewModel: CardGameViewModel(.book, rootViewModel: self.viewModel, mapViewModel: self.mapViewModel, timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
            case .timeGame:
                TimerGameView(viewModel: TimerGameViewModel(.time, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 0.0, timeEnd: .infinity, timeInterval: 0.01))
            case .moonGame:
                MoonGameView(viewModel: MoonGameViewModel(.moon, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
            case .quizGame:
                QuizGameView(viewModel: QuizGameViewModel(.quiz, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 15.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
            case .cupidGame:
                CupidGameView(viewModel: CupidGameViewModel(.cupid, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
            case .allClickGame:
                AllClickGameView(viewModel: AllClickGameViewModel(.allClear, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 0.0, timeEnd: .infinity, timeInterval: 0.01), rootViewModel: viewModel)
            case .surviveGame:
                SurviveGameView(viewModel: SurviveGameViewModel(rootViewModel: viewModel, mapViewModel: mapViewModel), rootViewModel: viewModel)
            case .catchGame:
                CatchGameView(viewModel: CatchGameViewModel(.catchDucku, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 60.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
            }
            
            //storyView
            if viewModel.showStory {
                withAnimation {
                    StoryView(rootViewModel: viewModel, showStoryView: $viewModel.showStory)
                }
            }
            
            // 새 뱃지
            if viewModel.newBadgeViewShowing {
                if let newBadge = viewModel.newBadge {
                    NewBadgeView(rootViewModel: viewModel, badge: newBadge)
                }
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
            
            // 토스트 메시지 (최상단)
            if viewModel.toastMessageShowing {
                if let message = viewModel.toastMessage {
                    ToastAlertView(alertText: message)
                }
            }
        }
        .onAppear {
            // 확인 작업
            viewModel.isLoading = false
            viewModel.unlockStoriesBasedOnGameTypes()
        }
    }
}

#Preview {
    RootView()
}
