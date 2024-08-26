//
//  CheckLogoutView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct CheckLogoutView: View {
    @ObservedObject var viewModel: RootViewModel
    @Binding var isLogoutPresented: Bool
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.66)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isLogoutPresented = false
                }
            
            VStack {
                Text("MyPage.Logout.Message")
                    .font(.neo20)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
                    .padding(.bottom, 15)
                
                Button(action: {
                    isLogoutPresented = false
                    viewModel.logout()
                    soundManager.playSound(sound: .buttonClicked)
                }, label: {
                    Image(.shortButtonBlue)
                        .overlay {
                            Text("MyPage.Logout.Ok")
                                .font(.neo20)
                                .kerning(-0.41)
                                .foregroundStyle(.black)
                        }
                        .padding(.bottom, 7)
                })
                
                Button(action: {
                    isLogoutPresented = false
                    soundManager.playSound(sound: .buttonClicked)
                }, label: {
                    Image(.shortButtonGray)
                        .overlay {
                            Text("MyPage.Logout.No")
                                .font(.neo20)
                                .kerning(-0.41)
                                .foregroundStyle(.black)
                        }
                })
            }
        }
    }
}
