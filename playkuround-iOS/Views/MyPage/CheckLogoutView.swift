//
//  CheckLogoutView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct CheckLogoutView: View {
    @Binding var isLogoutPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.66)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isLogoutPresented = false
                }
            
            VStack {
                Text(StringLiterals.MyPage.Logout.message)
                    .font(.neo20)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
                    .padding(.bottom, 15)
                
                
                Button(action: {
                    // 로그아웃 서버 API 연결
                    isLogoutPresented = false
                }, label: {
                    Image(.shortButtonBlue)
                        .overlay {
                            Text(StringLiterals.MyPage.Logout.ok)
                                .font(.neo20)
                                .kerning(-0.41)
                                .foregroundStyle(.black)
                            
                        }
                        .padding(.bottom, 7)
                })
                
                Button(action: {
                    isLogoutPresented = false
                }, label: {
                    Image(.shortButtonGray)
                        .overlay {
                            Text(StringLiterals.MyPage.Logout.no)
                                .font(.neo20)
                                .kerning(-0.41)
                                .foregroundStyle(.black)
                        }
                })
            }
        }
    }
}
