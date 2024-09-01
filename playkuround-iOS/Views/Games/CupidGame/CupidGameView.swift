//
//  CupidGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/26/24.
//

import SwiftUI

struct CupidGameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var viewModel: CupidGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.cupidBackGround)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                let shouldImagePadding = geometry.size.height >= 700
                
                TimerBarView(progress: $viewModel.progress, color: .black)
                    .padding(.bottom, shouldImagePadding ? 580 : 490)
                    .onReceive(viewModel.timer) { _ in
                        viewModel.updateTimer()
                        
                        if viewModel.isTimerUpdating {
                            if Int(viewModel.timeRemaining * 100) % 50 == 0 && Int(viewModel.timeRemaining * 100) > 50 {
                                viewModel.spawnDuckkus()
                            }
                            
                            if Int(viewModel.timeRemaining * 100) % 4 == 0 {
                                viewModel.updateEntityPos()
                            }
                        }
                    }
                HStack {
                    Text("SCORE \(viewModel.score)")
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.kuText)
                        .padding(.bottom, shouldImagePadding ? 470 : 380)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        
                        Spacer().frame(height: 40)
                        
                        HStack {
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 84)
                        .onAppear {
                            viewModel.setFrameWidth(geometry.size.width)
                        }
                        .overlay {
                            ZStack {
                                // black
                                ForEach(Array(viewModel.duckkuList.enumerated()), id: \.offset) { index, duckku in
                                    if !duckku.died {
                                        Image(.cupidDuckkuBlack)
                                            .offset(x: duckku.posBlack)
                                    }
                                }
                                
                                // white
                                ForEach(Array(viewModel.duckkuList.enumerated()), id: \.offset) { index, duckku in
                                    if !duckku.died {
                                        Image(.cupidDuckkuWhite)
                                            .offset(x: duckku.posWhite)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
                
                Image(.cupidBackgroundBridge)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                VStack {
                    if viewModel.isResultTitleShowing {
                        switch viewModel.resultType {
                        case .perfect:
                            VStack {
                                Image(.cupidHeart)
                                Image(.cupidPerfect)
                            }
                            .padding(.top, shouldImagePadding ? 150 : 130)
                        case .good:
                            Image(.cupidGood)
                                .padding(.top, shouldImagePadding ? 190 : 160)
                        case .bad:
                            VStack {
                                Image(.cupidHeartBroken)
                                Image(.cupidBad)
                            }
                            .padding(.top, shouldImagePadding ? 150 : 130)
                        }
                    }
                    
                    Spacer()
                    
                    /// 정지버튼
                    Button(action: {
                        viewModel.stopButtonTapped()
                    }, label: {
                        Image(.cupidStop)
                            .padding(.bottom, 60)
                    })
                }
                
                EmptyView()
                    .customNavigationBar(centerView: {
                        Text("Game.Cupid.Title")
                            .font(.neo22)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }, rightView: {
                        Button(action: {
                            viewModel.soundManager.playSound(sound: .buttonClicked)
                            
                            // 게임 일시정지 이벤트
                            GAManager.shared.logEvent(.GAME_PAUSE,
                                                      parameters: ["GameType": self.viewModel.gameType.rawValue])
                            
                            viewModel.togglePauseView()
                        }, label: {
                            Image(.brownPauseButton)
                        })
                    }, height: 67)
                    .padding(.top, -10)
                
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
                GAManager.shared.logScreenEvent(.CupidGame)
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
    CupidGameView(viewModel: CupidGameViewModel(.cupid, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(rootViewModel: RootViewModel()), timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
