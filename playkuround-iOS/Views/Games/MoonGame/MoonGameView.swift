//
//  MoonGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/31/24.
//

import SwiftUI

struct MoonGameView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Image(.moonBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                Text(StringLiterals.Game.Moon.description)
                    .font(.pretendard15R)
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
                
                Text("100")
                    .font(.neo50)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .overlay {
                Image(.moon1)
                    .padding(.bottom, 50)
            }
            .padding(.top, 100)
            .customNavigationBar(centerView: {
                Text(StringLiterals.Game.Moon.title)
                    .font(.neo22)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
            }, rightView: {
                Button(action: {
                    // TODO: 일시정지
                }, label: {
                    Image(.yellowPauseButton)
                })
            }, height: 67)
        }
    }
}

#Preview {
    MoonGameView()
}
