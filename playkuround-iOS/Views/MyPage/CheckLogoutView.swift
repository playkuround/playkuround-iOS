//
//  CheckLogoutView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct CheckLogoutView: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.66)
                .ignoresSafeArea(.all)
            
            VStack {
                Text(StringLiterals.MyPage.Logout.message)
                    .font(.neo20)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
                    .padding(.bottom, 15)
                
                
                Button(action: {
                    print("예스예스")
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
                    print("노노노노")
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

#Preview {
    CheckLogoutView()
}
