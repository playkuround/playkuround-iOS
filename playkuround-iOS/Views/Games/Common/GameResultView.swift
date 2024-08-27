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
                                    Text("\(gameViewModel.score) " + NSLocalizedString("Game.Result.Score", comment: ""))
                                        .font(.neo56)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                        .padding(.bottom, 2)
                                    
                                    // 최고 점수 받아와 표시
                                    Text(NSLocalizedString("Game.Result.BestScore", comment: "")
                                         + " \(gameViewModel.bestScore) "
                                         + NSLocalizedString("Game.Result.Score", comment: ""))
                                        .font(.neo18)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                }
                                .padding(.top, 48)
                            }
                        
                        // 모험 점수 받아와 표시
                        Text(NSLocalizedString("Game.Result.AdventureScore", comment: "")
                             + " \(gameViewModel.adventureScore) "
                             + NSLocalizedString("Game.Result.Score", comment: ""))
                            .font(.neo24)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.vertical, 20)
                        
                        Button {
                            soundManager.playSound(sound: .buttonClicked)
                            
                            // 게임 완료 이벤트
                            GAManager.shared.logEvent(.GAME_FINISH)
                            
                            // 홈으로 이동
                            rootViewModel.transition(to: .home)
                            rootViewModel.saveOpenedGameType(gameViewModel.gameType)
                            
                            // 혹시 받았던 뱃지가 있다면
                            DispatchQueue.main.async {
                                rootViewModel.openNewBadgeView(badgeNames: [])
                            }
                        } label: {
                            Image(.shortButtonBlue)
                                .overlay {
                                    Text("Game.Result.Out")
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
            return NSLocalizedString("Game.Time.Title", comment: "")
        case .moon:
            return NSLocalizedString("Game.Moon.Title", comment: "")
        case .quiz:
            return NSLocalizedString("Game.Quiz.Title", comment: "")
        case .catchDucku:
            return NSLocalizedString("Game.Catch", comment: "")
        case .allClear:
            return NSLocalizedString("Game.AllClick.Title", comment: "")
        case .cupid:
            return NSLocalizedString("Game.Cupid.Title", comment: "")
        case .book:
            return NSLocalizedString("Game.Card.Title", comment: "")
        case .survive:
            return NSLocalizedString("Game.Survive.Title", comment: "")
        }
    }
}
