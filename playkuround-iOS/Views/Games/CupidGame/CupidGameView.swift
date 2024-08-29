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
                
                /// 타임바
                TimerBarView(progress: $viewModel.progress, color: .black)
                    .padding(.bottom, shouldImagePadding ? 580 : 490)
                    .onReceive(viewModel.timer) { _ in
                        viewModel.updateTimer()
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
                
                /// 덕쿠
                ForEach(Array(zip(viewModel.whiteDucksPositions.indices, viewModel.whiteDucksPositions)), id: \.0) { index, position in
                    HStack {
                        Image(.cupidDuckkuWhite)
                            .offset(x: position)
                        
                        Image(.cupidDuckkuBlack)
                            .offset(x: viewModel.blackDucksPositions[index])
                    }
                }
                .padding(.top, shouldImagePadding ? 50 : 25)
                
                /// 백그라운드 홍예교
                Image(.cupidBackgroundBridge)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                /// 결과 뷰
                VStack {
                    if viewModel.result == .perfect {
                        VStack {
                            Image(.cupidHeart)
                            Image(.cupidPerfect)
                        }
                        .padding(.top, shouldImagePadding ? 150 : 130)
                    }
                    else if viewModel.result == .good {
                        Image(.cupidGood)
                            .padding(.top, shouldImagePadding ? 190 : 160)
                    }
                    else if viewModel.result == .bad {
                        VStack {
                            Image(.cupidHeartBroken)
                            Image(.cupidBad)
                        }
                        .padding(.top, shouldImagePadding ? 150 : 130)
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
                
                VStack {}
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
                        .onAppear {
                            viewModel.stopDuckAnimation()
                            viewModel.stopDuckSpawn()
                        }
                        .onDisappear {
                            viewModel.startDuckAnimation()
                            viewModel.startDuckSpawn()
                        }
                } else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                        .onAppear {
                            viewModel.stopDuckAnimation()
                        }
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
