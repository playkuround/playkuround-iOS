//
//  AuthenticationCodeView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/18/24.
//

import SwiftUI

struct AuthenticationCodeView: View {
    private let mailSystemURL = URL(string: StringLiterals.Login.mailSystemURL)
    
    @State private var certificationCode: String = ""
    @State private var certificationButtonClicked = false
    
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
                    TextField(StringLiterals.Login.authenticationCode, text: $certificationCode)
                        .font(.pretendard15R)
                        .kerning(-0.41)
                        .padding(.leading, 20)
                    
                    AuthenticationTimerView()
                        .padding(.leading, 250)
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
    
    
}



#Preview {
    AuthenticationCodeView()
}
