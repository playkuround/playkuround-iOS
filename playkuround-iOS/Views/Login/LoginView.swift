//
//  LoginView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/15/24.
//

import SwiftUI

struct LoginView: View {
    @State private var userId: String = ""
    @FocusState private var focusField: Bool
    
    @State private var requestButtonName = StringLiterals.Login.requestCode
    @State private var isButtonClicked = false
    
    @State private var userRequestCode: String = ""
    
    var body: some View {
        ZStack {
            Color.kuBackground.ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text(StringLiterals.Login.hello)
                    .font(.neo24)
                    .foregroundStyle(.kuText)
                    .kerning(-0.41)
                    .padding(.bottom, 10)
                
                Text(StringLiterals.Login.description)
                    .font(.pretendard15R)
                    .foregroundStyle(.kuText)
                    .padding(.bottom, 48)
                
                Image(.longButtonWhite)
                    .overlay {
                        TextField(StringLiterals.Login.placeHolder, text: $userId)
                            .font(.pretendard15R)
                            .kerning(-0.41)
                            .focused($focusField)
                            .padding(.leading, 20)
                            .overlay(
                                Text(StringLiterals.Login.email)
                                    .font(.pretendard15R)
                                    .foregroundStyle(.gray)
                                    .opacity(userId.isEmpty && !focusField ? 0 : 1)
                                    .padding(.leading, 190)
                            )
                    }
                
                
                Image(isButtonClicked || userId.isEmpty ? "longButtonGray" : "longButtonBlue")
                    .onTapGesture {
                        isButtonClicked.toggle()
                        if isButtonClicked {
                            // 클릭되었을 때, 텍스트와 이미지 변경
                            requestButtonName = StringLiterals.Login.reRequestCode
                        } else {
                            // 클릭 해제되었을 때, 원래 텍스트로 변경
                            requestButtonName = StringLiterals.Login.requestCode
                        }
                    }
                    .overlay {
                        Text(requestButtonName)
                            .font(.neo15)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                    }
                
                Text(StringLiterals.Login.goEmail)
                    .font(.pretendard12R)
                    .foregroundStyle(.kuDarkBlue).underline()
                    .padding(.top, 6)
                
                Image(.longButtonWhite)
                    .overlay {
                        TextField(StringLiterals.Login.code, text: $userRequestCode)
                            .font(.pretendard15R)
                            .kerning(-0.41)
                            .padding(.leading, 20)
                    }
                    .padding(.top, 46)
                
                Image(.longButtonGray)
                    .overlay {
                        Text(StringLiterals.Login.certification)
                            .font(.neo15)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                    }
                
                Spacer()
            }
            .padding(.top, 80)
        }
    }
}

#Preview {
    LoginView()
}
