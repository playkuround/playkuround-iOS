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
    
    @State private var mailButtonName = StringLiterals.Login.requestCode
    @State private var mailButtonClicked = false
    
    @State private var isShowingBottomSheet = false
    
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
                
                Image(userId.isEmpty ? "longButtonGray" : "longButtonBlue")
                    .onTapGesture {
                        mailButtonClicked.toggle()
                        
                        if mailButtonClicked {
                            mailButtonName = StringLiterals.Login.reRequestCode
                        }
                        else {
                            mailButtonName = StringLiterals.Login.requestCode
                        }
                    }
                    .overlay {
                        Text(mailButtonName)
                            .font(.neo15)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                    }
                
                if mailButtonClicked {
                    AuthenticationCodeView()
                }
                
                Spacer()
            }
            .padding(.top, 80)
            
            LoginBottomSheetView(isShowing: $isShowingBottomSheet)
        }
    }
}

#Preview {
    LoginView()
}
