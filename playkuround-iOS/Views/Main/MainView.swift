//
//  MainView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/16/24.
//

import SwiftUI

struct MainView: View {
    @Binding var currentView: ViewType
    
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
                    
                    NavigationLink(
                        destination: LoginView()
                            .navigationBarBackButtonHidden()) {
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
    MainView(currentView: .constant(.main))
}
