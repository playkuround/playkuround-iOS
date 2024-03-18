//
//  MainView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/16/24.
//

import SwiftUI

enum mainBackgroundImage: String, CaseIterable {
    case mainBackground1
    case mainBackground2
    case mainBackground3
    case mainBackground4
}

struct MainView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                AnimationCustomView(
                    imageArray: mainBackgroundImage.allCases.map { $0.rawValue },
                    delayTime: 0.7)
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
                
                VStack {
                    Text(StringLiterals.Main.introduction)
                        .font(.neo20)
                        .foregroundStyle(.kuText)
                        .kerning(-0.41)
                        .padding(.top, 80)
                    
                    Image(.mainLogo)
                        .padding(.top, 18)
                    
                    Spacer()
                    
                    NavigationLink(destination: LoginView()) {
                        Image(.shortButtonBlue)
                            .overlay {
                                Text(StringLiterals.Main.login)
                                    .font(.neo20)
                                    .foregroundStyle(.kuText)
                                    .kerning(-0.41)
                            }
                            .padding(.bottom, 98)
                    }
                }
            }
            .onAppear {
                SoundManager.shared.playSound(sound: .backgroundMusic, loop: true)
            }
            .onDisappear {
                SoundManager.shared.stopSound()
            }
        }
    }
}

#Preview {
    MainView()
}
