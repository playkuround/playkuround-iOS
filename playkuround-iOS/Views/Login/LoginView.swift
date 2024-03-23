//
//  LoginView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/15/24.
//

import SwiftUI

struct LoginView: View {
    // 포탈 아이디
    @State private var userId: String = ""
    @FocusState private var focusField: Bool
    
    // 인증코드 요청
    @State private var mailButtonTitle = StringLiterals.Login.requestCode
    @State private var mailButtonClicked: Bool = false
    
    // 인증시간 초과 바텀시트
    @State private var isBottomSheetPresented: Bool = false
    
    @State private var isMaximumCount: Bool = false
    @State private var userSendingCount: Int?
    
    @State private var isAuthCodeViewVisible: Bool = false
    
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

                Button(action: {
                    mailButtonClicked.toggle()
                    
                    if mailButtonClicked {
                        mailButtonTitle = userId.isEmpty ? StringLiterals.Login.requestCode : StringLiterals.Login.reRequestCode
                    }
                    
                    self.isAuthCodeViewVisible = true
                    
                    callPOSTAPIemails(target: userId + StringLiterals.Login.email)
                    
                }, label: {
                    Image(userId.isEmpty ? .longButtonGray : .longButtonBlue)
                        .overlay {
                            Text(mailButtonTitle)
                                .font(.neo15)
                                .foregroundStyle(.kuText)
                                .kerning(-0.41)
                        }
                    
                })
                .disabled(userId.isEmpty)
                
                if isAuthCodeViewVisible {
                    AuthenticationCodeView(userSendingCount: $userSendingCount, userEmail: userId + StringLiterals.Login.email)
                }
                
                Spacer()
            }
            .padding(.top, 80)
            
            
            LoginBottomSheetView(isPresented: $isBottomSheetPresented)
        }
    }
    
    private func callPOSTAPIemails(target: String) {
        APIManager.callPOSTAPI(endpoint: .emails,
                               parameters: ["target" : target]) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                
                if let response = data as? APIResponse {
                    if response.isSuccess {
                        if let count = response.response?.sendingCount {
                            userSendingCount = count
                            print("🧡🧡\(count)번 시도했습니다.🧡🧡")
                        }
                    }
                    else {
                        if response.errorResponse?.code == "E004" {
                            isMaximumCount = true
                        }
                    }
                }
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
    }
}



#Preview {
    LoginView()
}
