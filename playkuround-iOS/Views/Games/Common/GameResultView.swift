//
//  GameResultView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/31/24.
//

import SwiftUI

struct GameResultView: View {
    @ObservedObject var rootViewModel: RootViewModel
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            Image(.resultBackground)
                .overlay {
                    VStack {
                        // TODO: GameViewModel 연결 시 수정
                        Text("GAME_TITLE")
                            .font(.neo24)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                        
                        Image(.scoreBackground)
                            .overlay {
                                VStack(alignment: .center) {
                                    // 게임 점수
                                    Text("\(gameViewModel.score) " + StringLiterals.Game.Result.score)
                                        .font(.neo56)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                        .padding(.bottom, 2)
                                    
                                    // 최고 점수 받아와 표시
                                    Text(StringLiterals.Game.Result.bestScore
                                         + " \(gameViewModel.bestScore) "
                                         + StringLiterals.Game.Result.score)
                                        .font(.neo18)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                }
                                .padding(.top, 48)
                            }
                        
                        // 모험 점수 받아와 표시
                        Text(StringLiterals.Game.Result.adventureScore 
                             + " \(gameViewModel.adventureScore) "
                             + StringLiterals.Game.Result.score)
                            .font(.neo24)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.vertical, 20)
                        
                        Button {
                            // 홈으로 이동
                            rootViewModel.transition(to: .home)
                        } label: {
                            Image(.shortButtonBlue)
                                .overlay {
                                    Text(StringLiterals.Game.Result.out)
                                        .font(.neo18)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                }
                        }
                    }
                    .padding(.top, 40)
                }
        }
    }
}
