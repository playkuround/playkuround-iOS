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
                    Button("출석체크") {
                        viewModel.transition(to: .attendance)
                    }
                    Button("Logout") {
                        viewModel.logout()
                    }
                    Button("myPage") {
                        viewModel.transition(to: .myPage)
                    }
                    Button("책 뒤집기") {
                        viewModel.transition(to: .cardGame)
                    }
                    Button("10초를 맞춰봐") {
                        viewModel.transition(to: .timeGame)
                    }
                    Button("MOON을 점령해") {
                        viewModel.transition(to: .moonGame)
                    }
                    Button("건쏠지식") {
                        viewModel.transition(to: .quizGame)
                    }
                    Button("덕큐피트") {
                        viewModel.transition(to: .cupidGame)
                    }
                    Button("수강신청 ALL 클릭") {
                        viewModel.transition(to: .allClickGame)
                    }
                    Button("일감호에서 살아남기") {
                        viewModel.transition(to: .surviveGame)
                    }
                    Button("덕쿠를 잡아라!") {
                        viewModel.transition(to: .catchGame)
                    }
                }
                .onAppear {
                    mapViewModel.startUpdatingLocation()
                }
                .onDisappear {
                    // 홈 뷰에서 벗어날 때 위치 업데이트 중지
                    mapViewModel.stopUpdatingLocation()
                }
                
            case .attendance:
                AttendanceView(rootViewModel: viewModel)
                
            case .myPage:
                MyPageView(viewModel: viewModel)
            case .cardGame:
                CardGameView(viewModel: CardGameViewModel(.book, rootViewModel: self.viewModel, mapViewModel: self.mapViewModel, timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
            case .timeGame:
                TimerGameView(viewModel: TimerGameViewModel(.time, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 0.0, timeEnd: .infinity, timeInterval: 0.01))
            case .moonGame:
                MoonGameView(viewModel: MoonGameViewModel(.moon, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 0.0, timeEnd: .infinity, timeInterval: 0.01), rootViewModel: viewModel)
            case .quizGame:
                QuizGameView(viewModel: QuizGameViewModel(.quiz, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 15.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
            case .cupidGame:
                CupidGameView(viewModel: CupidGameViewModel(.cupid, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
            case .allClickGame:
                AllClickGameView(viewModel: AllClickGameViewModel(.allClear, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 15.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
            case .surviveGame:
                SurviveGameView(viewModel: SurviveGameViewModel(rootViewModel: viewModel, mapViewModel: mapViewModel), rootViewModel: viewModel)
            case .catchGame:
                CatchGameView(viewModel: CatchGameViewModel(.catchDucku, rootViewModel: viewModel, mapViewModel: mapViewModel, timeStart: 60.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: viewModel)
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
