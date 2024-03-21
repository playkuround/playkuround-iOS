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
    @State private var authButtonClicked = false
    @State private var authCodeIncorrect = false
    
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
                    
                    AuthenticationTimerView()
                        .padding(.leading, 250)
                }
                .padding(.top, 46)
            
            Image(authCode.isEmpty ? .longButtonGray : .longButtonBlue)
                .onTapGesture {
                    authButtonClicked.toggle()
                    
                    if !authCode.isEmpty && authButtonClicked {
                        callGETAPIemails(code: authCode, email: userEmail)
                    }
                }
                .overlay {
                    Text(StringLiterals.Login.authentication)
                        .font(.neo15)
                        .foregroundStyle(.kuText)
                        .kerning(-0.41)
                }
            
            if authCodeIncorrect {
                Text(StringLiterals.Login.authIncorrect)
                    .font(.pretendard12R)
                    .foregroundStyle(.kuRed)
                    .padding(.top, 7)
            }
        }
    }
}

private func callGETAPIemails(code: String, email: String) {
    APIManager.callGETAPI(endpoint: .emails,
                          querys: ["code" : code, "email" : email]) { result in
        switch result {
        case .success(let data):
            print("Data received in View: \(data)")
            // 회원가입뷰로 전환
        case .failure(let error):
            print("Error in View: \(error)")
            // 인증 횟수 몇번 남았습니다.
            // 인증 메일 전송 횟수를 초과하였습니다.
        }
    }
}
