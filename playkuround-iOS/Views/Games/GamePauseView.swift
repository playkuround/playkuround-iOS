//
//  GamePauseView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/29/24.
//

import SwiftUI

struct GamePauseView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.66).ignoresSafeArea()
            
            VStack {
                Image(.shortButtonBlue)
                    .overlay {
                        Text(StringLiterals.Game.play)
                            .font(.neo20)
                            .foregroundStyle(.black)
                            .kerning(-0.41)
                    }
                    .padding(.bottom, 12)
                    .onTapGesture {
                        // TODO: GamePauseView 닫고 게임 계속 진행
                    }
                
                Image(.shortButtonGray)
                    .overlay {
                        Text(StringLiterals.Game.home)
                            .font(.neo20)
                            .foregroundStyle(.black)
                            .kerning(-0.41)
                    }
                    .onTapGesture {
                        // TODO: 게임 종료 기능 추가
                        // TODO: 홈 뷰로 이동
                    }
            }
        }
    }
}

#Preview {
    GamePauseView()
}
