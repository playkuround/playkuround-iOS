//
//  CheckLogoutView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct CheckDeleteAccountView: View {
    @ObservedObject var viewModel: RootViewModel
    @Binding var isDeleteAccountPresented: Bool
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.66)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isDeleteAccountPresented = false
                }
            
            VStack {
                let message = NSLocalizedString("MyPage.DeleteAccount.Message", comment: "")
                    .replacingOccurrences(of: "<br>", with: "\n")
                
                Text(message)
                    .font(.neo20)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
                    .padding(.bottom, 15)
                
                Button(action: {
                    isDeleteAccountPresented = false
                    viewModel.deleteAccount()
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
                    isDeleteAccountPresented = false
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
