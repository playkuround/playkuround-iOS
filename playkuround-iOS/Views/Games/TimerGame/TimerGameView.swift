//
//  TimerGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/29/24.
//

import SwiftUI

struct TimerGameView: View {
    @ObservedObject var viewModel: TimerGameViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.kuLightYellowBackground.ignoresSafeArea()
            
            GeometryReader { geometry in
                
                VStack {
                    Spacer()
                    
                    Text(StringLiterals.Game.Time.description)
                        .font(.pretendard15R)
                        .foregroundStyle(.kuText)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width)
                .frame(height: geometry.size.height > 700 ? 90 : 60)
                .customNavigationBar(
                    centerView: {
                        Text(StringLiterals.Game.Time.title)
                            .font(.neo22)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    },
                    rightView: {
                        Button {
                            viewModel.togglePauseView()
                        } label: {
                            Image(.bluePauseButton)
                        }
                        
                    },
                    height: 67)
                .ignoresSafeArea(edges: .bottom)
                .overlay {
                    Image(.timeBackground)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .offset(y: 100)
                        .overlay {
                            VStack(spacing: 0) {
                                // 타이머
                                Text("\(viewModel.second):\(viewModel.milliSecond)")
                                    .font(.neo70)
                                    .kerning(-0.41)
                                    .foregroundStyle(viewModel.timerState == .failed ? .kuRed : (viewModel.timerState == .success || viewModel.timerState == .perfect) ? .kuGreen : .kuText)
                                    .onReceive(viewModel.timer) { _ in
                                        if viewModel.timerState == .running {
                                            viewModel.updateTimer()
                                            viewModel.updateMilliSecondString()
                                        }
                                    }
                                
                                // 텍스트
                                HStack {
                                    if viewModel.timerState == .success || viewModel.timerState == .perfect {
                                        Text(viewModel.timerState == .failed ? StringLiterals.Game.Time.failure :  StringLiterals.Game.Time.success)
                                            .font(.pretendard15R)
                                            .foregroundStyle(viewModel.timerState == .failed ? .kuRed : .kuGreen)
                                    } else if viewModel.timerState == .failed {
                                        Text(viewModel.timerState == .failed ? StringLiterals.Game.Time.failure :  StringLiterals.Game.Time.success)
                                            .font(.pretendard15R)
                                            .foregroundStyle(viewModel.timerState == .failed ? .kuRed : .kuGreen)
                                    } else {
                                        // Spacer()
                                    }
                                }
                                .frame(height: 20)
                                .padding(.vertical, 0)
                                
                                // 버튼
                                if viewModel.timerState == .perfect || viewModel.timerState == .success {
                                    AnimationCustomView(
                                        imageArray: gameSuccessImage.allCases.map { $0.rawValue },
                                        delayTime: 0.2)
                                    .scaledToFit()
                                    .frame(height: 140)
                                } else if viewModel.timerState == .failed {
                                    Button {
                                        viewModel.timeButtonClick()
                                    } label: {
                                        Image(.timeRestartButton)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .padding(.top, 20)
                                    }
                                } else if viewModel.timerState == .running {
                                    Button {
                                        viewModel.timeButtonClick()
                                    } label: {
                                        Image(.timeStopButton)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .padding(.top, 20)
                                    }
                                } else if viewModel.timerState == .ready {
                                    Button {
                                        viewModel.timeButtonClick()
                                    } label: {
                                        Image(.timePlayButton)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .padding(.top, 20)
                                    }
                                }
                            }
                            .offset(y: 110)
                        }
                }
                
                if viewModel.isCountdownViewPresented {
                    CountdownView(countdown: $viewModel.countdown)
                } else if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                } else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: viewModel.rootViewModel, gameViewModel: viewModel)
                }
            }
        }
        .onAppear {
            viewModel.startCountdown()
        }
    }
}

#Preview {
    TimerGameView(viewModel: TimerGameViewModel(.time, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 0, timeEnd: .infinity, timeInterval: 0.01))
}
