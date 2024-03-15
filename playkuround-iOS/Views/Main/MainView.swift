//
//  MainView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/16/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Image(.mainBackground)
                .resizable()
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

#Preview {
    MainView()
}
