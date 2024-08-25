//
//  GamePauseView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/29/24.
//

import SwiftUI

struct GamePauseView: View {
    @ObservedObject var viewModel: GameViewModel
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.66).ignoresSafeArea()
            
            VStack {
                Image(.shortButtonBlue)
                    .overlay {
                        Text(StringLiterals.Game.play)
                            .font(.neo20)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                    }
                    .padding(.bottom, 12)
                    .onTapGesture {
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 게임 이어서 이벤트
                        GAManager.shared.logEvent(.GAME_RESUME,
                                                  parameters: ["GameType": viewModel.gameType.rawValue])
                        
                        // GamePauseView 닫고 게임 계속 진행
                        viewModel.togglePauseView()
                    }
                
                Image(.shortButtonGray)
                    .overlay {
                        Text(StringLiterals.Game.home)
                            .font(.neo20)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                    }
                    .onTapGesture {
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 게임 중단 이벤트
                        GAManager.shared.logEvent(.GAME_QUIT,
                                                  parameters: ["GameType": viewModel.gameType.rawValue])
                        
                        // 홈 뷰로 이동
                        viewModel.stopGame()
                    }
            }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.GamePauseView)
        }
    }
}
