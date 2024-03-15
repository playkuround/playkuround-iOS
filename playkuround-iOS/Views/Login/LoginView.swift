//
//  LoginView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/15/24.
//

import SwiftUI

struct LoginView: View {
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
