//
//  MainView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/16/24.
//

import SwiftUI

// enum으로 배경 이미지 관리
enum mainBackgroundImage: String, CaseIterable {
    case mainBackground1
    case mainBackground2
    case mainBackground3
    case mainBackground4
}

struct MainView: View {
    private let backgroundImages = mainBackgroundImage.allCases
    private let timer = Timer.publish(every: 0.7, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(backgroundImages[currentIndex].rawValue)
                    .ignoresSafeArea(.all)
                    .onReceive(timer) { _ in
                        self.currentIndex = (self.currentIndex + 1) % self.backgroundImages.count
                    }
                
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
        }
    }
}

#Preview {
    MainView()
}
