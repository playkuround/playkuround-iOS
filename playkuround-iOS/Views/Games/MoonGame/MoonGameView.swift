//
//  MoonGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/31/24.
//

import SwiftUI

struct MoonGameView: View {
    var body: some View {
        ZStack {
            Image(.moonBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            
            VStack {
                Text(StringLiterals.Game.Moon.description)
                    .font(.pretendard15R)
                    .foregroundStyle(.white)
            }
            
            Spacer()
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
                }, height: 130)
        }
    }
}

#Preview {
    MoonGameView()
}
