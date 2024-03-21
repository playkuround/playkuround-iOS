//
//  AuthenticationCodeView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/18/24.
//

import SwiftUI

struct AuthenticationCodeView: View {
    private let mailSystemURL = URL(string: StringLiterals.Login.mailSystemURL)
    
    @State private var authCode: String = ""
    @State private var authButtonClicked = false
    @State private var authCodeIncorrect = false
    
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
            
            Image(authCode.isEmpty ? .longButtonGray : .longButtonBlue )
                .onTapGesture {
                    authButtonClicked.toggle()
                    
                    if authButtonClicked {
                        // 인증코드 확인 서버 통신 코드가 들어갑니다.
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
