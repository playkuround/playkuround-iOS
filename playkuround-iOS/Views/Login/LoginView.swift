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
                        TextField("", text: $userId)
                            .focused($focusField)
                            .padding(.leading, 20)
                            .overlay(
                                Text(StringLiterals.Login.email)
                                    .font(.pretendard15R)
                                    .foregroundStyle(.gray)
                                    .opacity(userId.isEmpty && !focusField ? 0 : 1)
                                    .padding(.leading, 190)  // 눈대중값
                            )
                    }
                
                Image(.longButtonGray)
                    .overlay {
                        Text(StringLiterals.Login.requestCode)
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
