//
//  AuthenticationCodeView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/18/24.
//

import SwiftUI

struct AuthenticationCodeView: View {
    //건국대학교 이메일 바로가기
    private let mailSystemURL = URL(string: StringLiterals.Login.mailSystemURL)
    
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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(StringLiterals.Login.goEmail)
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
                    TextField(StringLiterals.Login.authenticationCode, text: $authCode)
                        .font(.pretendard15R)
                        .kerning(-0.41)
                        .padding(.leading, 20)
                    
                    AuthenticationTimer(isTimerFinished: $isTimerFinished, authButtonClicked: $authButtonClicked)
                        .padding(.leading, 250)
                }
                .padding(.top, 46)
            
            Button(action: {
                authButtonClicked.toggle()
                
                if !authCode.isEmpty && authButtonClicked {
                    callGETAPIemails(code: authCode, email: userEmail)
                }
            }, label: {
                Image(authCode.isEmpty ? .longButtonGray : .longButtonBlue)
                    .overlay {
                        Text(StringLiterals.Login.authentication)
                            .font(.neo15)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                    }
            })
            .disabled(authCode.isEmpty)
            
            // 유저의 남은 인증 횟수 확인
            if let temp = userSendingCount {
                let calculatedValue = 5 - temp
                
                Text("오늘 인증 요청 횟수가 \(calculatedValue)회 남았습니다.")
                    .font(.pretendard12R)
                    .foregroundStyle(.kuGray2)
                    .padding(.top, 7)
            }
            
            // 잘못된 인증코드를 입력 했을 때
            if isAuthCodeWrong {
                Text(StringLiterals.Login.authIncorrect)
                    .font(.pretendard12R)
                    .foregroundStyle(.kuRed)
                    .padding(.top, 7)
            }
        }
    }
    
    private func callGETAPIemails(code: String, email: String) {
        APIManager.callGETAPI(endpoint: .emails,
                              querys: ["code" : code, "email" : email]) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                
                if let response = data as? APIResponse {
                    if response.isSuccess {
                        // 회원가입뷰로 전환
                        isAuthCodeWrong = false
                    }
                    else {
                        // 잘못된 인증코드를 입력했을 때
                        if response.errorResponse?.code == "E005" {
                            isAuthCodeWrong = true
                        }
                    }
                }
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
    }
}
