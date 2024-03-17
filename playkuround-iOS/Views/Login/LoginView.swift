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
    
    @State private var certificationCode: String = ""
    @State private var certificationButtonClicked = false
    
    @State private var isShowingBottomSheet = false
    
    private let mailSystemURL = URL(string: StringLiterals.Login.mailSystemURL)
    
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
                        isShowingBottomSheet.toggle()
                        
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
                                TextField(StringLiterals.Login.authenticationCode, text: $certificationCode)
                                    .font(.pretendard15R)
                                    .kerning(-0.41)
                                    .padding(.leading, 20)
                            }
                            .padding(.top, 46)
                        
                        Image(certificationCode.isEmpty ? "longButtonGray" : "longButtonBlue")
                            .onTapGesture {
                                certificationButtonClicked.toggle()
                                
                                if certificationButtonClicked {
                                    
                                }
                                else {
                                    
                                }
                            }
                            .overlay {
                                Text(StringLiterals.Login.authentication)
                                    .font(.neo15)
                                    .foregroundStyle(.kuText)
                                    .kerning(-0.41)
                            }
                    }
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
