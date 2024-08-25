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
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            Image(.resultBackground)
                .overlay {
                    VStack {
                        Text(GameTypeToString(gameViewModel.gameType))
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
                            soundManager.playSound(sound: .buttonClicked)
                            // 홈으로 이동
                            rootViewModel.transition(to: .home)
                            rootViewModel.saveOpenedGameType(gameViewModel.gameType)
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
        .onAppear {
            GAManager.shared.logScreenEvent(.GameResultView)
        }
    }
    
    private func GameTypeToString(_ type: GameType) -> String {
        switch type {
        case .time:
            return "10초를 맞춰봐"
        case .moon:
            return "문을 점령해"
        case .quiz:
            return "건쏠지식"
        case .catchDucku:
            return "덕쿠를 잡아라!"
        case .allClear:
            return "수강신청 ALL클릭"
        case .cupid:
            return "덕큐피트"
        case .book:
            return "책 뒤집기"
        case .survive:
            return "일감호에서 살아남기"
        }
    }
}
