//
//  AuthenticationCodeView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/18/24.
//

import SwiftUI

struct AuthenticationCodeView: View {
    @ObservedObject var viewModel: RootViewModel
    
    //건국대학교 이메일 바로가기
    private let mailSystemURL = URL(string: NSLocalizedString("Login.MailSystemURL", comment: ""))
    
    // 인증코드
    @State private var authCode: String = ""
    @State private var authButtonClicked: Bool = false
    
    @State private var isAuthCodeWrong: Bool = false
    
    @State private var isEmailValid: Bool = false
    @State private var isEmailSuccess: Bool = false
    @State private var isCountVisible: Bool = false
    
    @Binding var userSendingCount: Int?
    @Binding var isTimerFinished: Bool
    
    // 유저 이메일 받아오는 값
    let userEmail: String
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Login.GoEmail")
                .font(.pretendard12R)
                .foregroundStyle(.kuDarkBlue).underline()
                .padding(.top, 6)
                .onTapGesture {
                    if let mailSystemURL = mailSystemURL {
                        UIApplication.shared.open(mailSystemURL)
                    }
                    else {
                        print("url error")
                    }
                }
            
            Image(.longButtonWhite)
                .overlay {
                    TextField(NSLocalizedString("Login.AuthenticationCode", comment: ""), text: $authCode)
                        .font(.pretendard15R)
                        .kerning(-0.41)
                        .padding(.leading, 20)
                        .keyboardType(.numberPad)
                        .onChange(of: authCode) { newValue in
                            authCode = String(newValue.filter { "0123456789".contains($0) }.prefix(6))
                        }
                    
                    AuthenticationTimer(isTimerFinished: $isTimerFinished, authButtonClicked: $authButtonClicked)
                        .padding(.leading, 250)
                }
                .padding(.top, 46)
            
            Button(action: {
                authButtonClicked = true
                soundManager.playSound(sound: .buttonClicked
                )
                if !authCode.isEmpty && authButtonClicked {
                    callGETAPIemails(code: authCode, email: userEmail)
                }
            }, label: {
                Image(authCode.isEmpty ? .longButtonGray : .longButtonBlue)
                    .overlay {
                        Text("Login.Authentication")
                            .font(.neo15)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                    }
            })
            .disabled(authCode.isEmpty)
            
            // 유저의 남은 인증 횟수 확인
            if let temp = userSendingCount {
                let calculatedValue = 5 - temp
                
                Text(String(format: NSLocalizedString("Login.AuthRemained", comment: ""), "\(calculatedValue)"))
                    .font(.pretendard12R)
                    .foregroundStyle(.kuGray2)
                    .padding(.top, 7)
            }
            
            // 잘못된 인증코드를 입력 했을 때
            if isAuthCodeWrong {
                Text("Login.AuthIncorrect")
                    .font(.pretendard12R)
                    .foregroundStyle(.kuRed)
                    .padding(.top, 7)
            }
        }
    }
    
    private func callGETAPIemails(code: String, email: String) {
        // 심사용 계정 예외 처리
        for account in adminAccountInfo {
            if email == account.email && code == account.password {
                APIManager.shared.changeServerType(to: .dev) // 개발 서버로 전환
                UserDefaults.standard.setValue(true, forKey: "IS_ADMIN")
            }
        }
        
        APIManager.shared.callGETAPI(endpoint: .emails,
                              querys: ["code" : code, "email" : email]) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                
                if let apiResponse = data as? APIResponse {
                    if apiResponse.isSuccess {
                        // 회원가입뷰로 전환
                        isAuthCodeWrong = false
                        // TODO: 만약 AuthVerifyToken이 오면 회원가입 화면으로 전환
                        // TODO: refreshToken과 accessToken이 오면 TokenManager에 저장 후 로그인
                        if let response = apiResponse.response {
                            // AuthVerifyToken이 발급된 경우
                            // 저장 후 회원가입 뷰로 이동
                            if let authVerifyToken = response.authVerifyToken {
                                print("AuthVerifyToken: \(authVerifyToken)")
                                
                                TokenManager.setToken(tokenType: .authVerify, token: authVerifyToken)
                                
                                // 회원가입 프로세스 시작 이벤트
                                GAManager.shared.logEvent(.REGISTER_START)
                                
                                // 뷰 전환
                                viewModel.transition(to: .registerTerms)
                            }
                            
                            // refresh, access token이 발급된 경우 홈으로 이동
                            else if let refreshToken = response.refreshToken, let accessToken = response.accessToken {
                                TokenManager.setToken(tokenType: .refresh, token: refreshToken)
                                TokenManager.setToken(tokenType: .access, token: accessToken)
                                
                                // 저장한 이메일 제거
                                UserDefaults.standard.removeObject(forKey: "email")
                                
                                // 로그인 성공
                                GAManager.shared.logEvent(.LOGIN_SUCCESS)
                                
                                // 뷰 전환
                                viewModel.transition(to: .home)
                            }
                        }
                    }
                    else {
                        // 잘못된 인증코드를 입력했을 때
                        if apiResponse.errorResponse?.code == "E005" {
                            isAuthCodeWrong = true
                            authButtonClicked = false
                        }
                    }
                }
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
    }
}
