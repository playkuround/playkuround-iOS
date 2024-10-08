//
//  MainView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/16/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: RootViewModel
    @ObservedObject var mapViewModel: MapViewModel
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                AnimationCustomView(
                    imageArray: mainBackgroundImage.allCases.map { $0.rawValue },
                    delayTime: 0.7)
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
                
                VStack {
                    Text("Main.Introduction")
                        .font(.neo20)
                        .foregroundStyle(.kuText)
                        .kerning(-0.41)
                        .padding(.top, 80)
                    
                    Image(.mainLogo)
                        .padding(.top, 18)
                    
                    Spacer()
                    
                    Button {
                        viewModel.openLoadingView()
                        
                        viewModel.checkSystemAvailable()
                        
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 메인 화면 시작 버튼 클릭 이벤트
                        GAManager.shared.logEvent(.START_BUTTON_CLICK)
                        
                        // 위치 권한 허가 요청
                        mapViewModel.requestLocationAuthorization()
                        
                        // 토큰이 없는 경우
                        if TokenManager.token(tokenType: .refresh).isEmpty || TokenManager.token(tokenType: .access).isEmpty {
                            // 로그인 화면으로 이동
                            print("token is empty, transition to login view")
                            viewModel.transition(to: .login)
                        }
                        // 토큰이 존재하는 경우 valid한지 검사
                        else {
                            let refreshToken = TokenManager.token(tokenType: .refresh)
                            
                            // reissue API 호출
                            reissueToken(token: refreshToken)
                        }
                    } label: {
                        Image(.shortButtonBlue)
                            .overlay {
                                Text("Main.Login")
                                    .font(.neo20)
                                    .foregroundStyle(.kuText)
                                    .kerning(-0.41)
                            }
                    }
                    .padding(.bottom, 98)
                }
            }
            .onAppear {
                GAManager.shared.logScreenEvent(.MainView)
            }
        }
    }
    
    // 토큰 재발급 및 검사 함수
    private func reissueToken(token: String) {
        // reissue API 호출
        APIManager.shared.callPOSTAPI(endpoint: .reissue, parameters: ["refreshToken": token]) { result in
            switch result {
            case .success(let data):
                // 재발급 완료된 경우 refresh token 만료 전이므로 자동 로그인
                print(data)
                if let apiResponse = data as? APIResponse {
                    if let response = apiResponse.response {
                        if let refreshToken = response.refreshToken, let accessToken = response.accessToken {
                            // 발급받은 토큰 저장
                            TokenManager.setToken(tokenType: .access, token: accessToken)
                            TokenManager.setToken(tokenType: .refresh, token: refreshToken)
                            
                            // 자동 로그인 성공 이벤트
                            GAManager.shared.logEvent(.AUTO_LOGIN)
                            
                            // 뷰 전환
                            viewModel.transition(to: .home)
                        } else {
                            // 오류 발생 시 로그인으로 이동
                            // 뷰 전환
                            viewModel.transition(to: .login)
                        }
                    } else {
                        // 오류 발생 시 로그인으로 이동
                        viewModel.transition(to: .login)
                    }
                }
            case .failure(let error):
                // 재발급 거부된 경우 이메일 인증 통해 refresh token 재발급 필요
                print("stored refresh token is fired. transition to login view")
                print(error)
                // 오류 발생 시 로그인으로 이동
                // 뷰 전환
                viewModel.transition(to: .login)
            }
        }
    }
}

#Preview {
    MainView(viewModel: RootViewModel(), mapViewModel: MapViewModel(rootViewModel: RootViewModel()))
}
