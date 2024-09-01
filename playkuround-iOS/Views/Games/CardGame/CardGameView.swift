//
//  CardGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/1/24.
//

import SwiftUI

struct CardGameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var viewModel: CardGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(.cardBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                // 뷰의 사이즈에 따라 Image의 padding값 조절
                let shouldImagePadding = geometry.size.height >= 700
                
                VStack {
                    TimerBarView(progress: $viewModel.progress, color: .white)
                        .padding(.bottom, shouldImagePadding ? 44 : 20)
                        .onReceive(viewModel.timer) { _ in
                            viewModel.updateTimer()
                        }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                        ForEach(Array(viewModel.cardList.enumerated()), id: \.offset) { index, card in
                            VStack {
                                switch card.cardState {
                                case .cover:
                                    Image("frontCard")
                                case .side:
                                    Image("sideCard")
                                case .drawing:
                                    Image(card.cardType.rawValue)
                                case .hidden:
                                    Spacer()
                                }
                            }
                            .frame(width: 66, height: 98)
                            .onTapGesture {
                                if !viewModel.isFlipping && card.cardState == .cover && (viewModel.flippedCardIndex1 == -1 || viewModel.flippedCardIndex2 == -1) {
                                    viewModel.coverToDrawing(index: index)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .customNavigationBar(centerView: {
                    Text("Game.Card.Title")
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                }, rightView: {
                    Button(action: {
                        viewModel.soundManager.playSound(sound: .buttonClicked)
                        
                        // 게임 일시정지 이벤트
                        GAManager.shared.logEvent(.GAME_PAUSE,
                                                  parameters: ["GameType": self.viewModel.gameType.rawValue])
                        
                        viewModel.togglePauseView()
                    }, label: {
                        Image(.bronzePauseButton)
                    })
                }, height: 67)
                
                if viewModel.isCountdownViewPresented {
                    CountdownView(countdown: $viewModel.countdown)
                } else if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                } else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                } else if viewModel.isWaitingViewPresented {
                    GameWaitingView(second: $viewModel.countdown)
                }
            }
            .onAppear {
                viewModel.startCountdown()
                GAManager.shared.logScreenEvent(.CardGame)
            }
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .active:
                    break
                case .background, .inactive:
                    if viewModel.gameState == .playing {
                        viewModel.togglePauseView()
                    }
                @unknown default:
                    break
                }
            }
        }
    }
}

#Preview {
    CardGameView(viewModel: CardGameViewModel(.book, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(rootViewModel: RootViewModel()), timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
