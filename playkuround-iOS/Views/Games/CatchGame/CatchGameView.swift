//
//  CatchGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/23/24.
//

import SwiftUI

struct CatchGameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var viewModel: CatchGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Color.kuSky.ignoresSafeArea()
                
                Image(.catchClearBackgroundBottom)
                    .resizable()
                    .frame(width: geometry.size.width)
                    .scaledToFit()
                
                Image(.catchClearBackgroundTop)
                    .resizable()
                    .frame(width: geometry.size.width)
                    .scaledToFit()
                    .offset(y: -466)
                
                VStack {
                    ForEach(0..<4) { rowIndex in
                        HStack(spacing: 0) {
                            windowView(for: WindowComponent(windowState: .dummyLeft))
                            Spacer()
                            
                            ForEach(0..<4) { columnIndex in
                                let index = rowIndex * 4 + columnIndex
                                windowView(for: viewModel.windowList[index])
                                    .onTapGesture {
                                        viewModel.checkWindow(index: index)
                                    }
                                Spacer()
                            }
                            
                            windowView(for: WindowComponent(windowState: .dummyRight))
                        }
                        Spacer()
                    }
                    
                    HStack(spacing: 0) {
                        windowView(for: WindowComponent(windowState: .dummyLeftBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyRightBottom))
                    }
                }
                .frame(height: 468)
                
                VStack {
                    TimerBarView(progress: $viewModel.progress, color: .black)
                        .onReceive(viewModel.timer) { _ in
                            viewModel.updateTimer()
                            
                            if viewModel.isTimerUpdating {
                                let timeRemainingSecond = Int(viewModel.timeRemaining * 100)
                                
                                // 20초 미만 1초마다 1번
                                if timeRemainingSecond < 2000 {
                                    if timeRemainingSecond % 100 == 0 {
                                        // 20초 미만일 경우 검은 오리 4개(고정) 하얀 오리 3개(고정)
                                        viewModel.step(whiteNum: 3, blackNum: 4)
                                    }
                                }
                                
                                // 20초 이상 2초마다 1번
                                else if timeRemainingSecond < 4000 {
                                    if timeRemainingSecond % 200 == 0 {
                                        // 40초 미만일 경우 검은 오리 4개(고정) 하얀 오리 3개(고정)
                                        viewModel.step(whiteNum: 3, blackNum: 4)
                                    }
                                } 
                                
                                // 40초 이상 3초마다 1번
                                else {
                                    if timeRemainingSecond % 300 == 0 {
                                        // 60~40초일 경우 검은오리 3개(고정) 하얀 오리 2~3개
                                        let whiteNum = Int.random(in: 2..<4)
                                        viewModel.step(whiteNum: whiteNum, blackNum: 3)
                                    }
                                }
                            }
                        }
                    
                    HStack {
                        Text("Game.ScoreTitle")
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                        
                        Spacer()
                            .frame(width: 16)
                        
                        Text("\(viewModel.score)")
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 26)
                }
                .customNavigationBar(centerView: {
                    Text("Game.Catch")
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
                        Image(.beigePauseButton)
                    })
                }, height: 30)
                
                if viewModel.isCountdownViewPresented {
                    CountdownView(countdown: $viewModel.countdown)
                } else if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                } else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                }
                else if viewModel.isWaitingViewPresented {
                    GameWaitingView(second: $viewModel.countdown)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                // 카운트다운 시작
                viewModel.startCountdown()
                GAManager.shared.logScreenEvent(.CatchGame)
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
    
    @ViewBuilder
    func windowView(for window: WindowComponent) -> some View {
        ZStack {
            switch window.windowState {
            case .close:
                Image(.closedWindow)
            case .half:
                switch window.windowType {
                case .catchDuckkuWhite:
                    Image(.halfWindowWhite)
                case .catchDuckkuWhiteHit:
                    Image(.halfWindowWhiteHit)
                case .catchDuckkuBlack:
                    Image(.halfWindowBlack)
                case .catchDuckkuBlackHit:
                    Image(.halfWindowBlackHit)
                case .none:
                    Text("")
                }
            case .open:
                switch window.windowType {
                case .catchDuckkuWhite:
                    Image(.openWindowWhite)
                case .catchDuckkuWhiteHit:
                    Image(.openWindowWhiteHit)
                case .catchDuckkuBlack:
                    Image(.openWindowBlack)
                case .catchDuckkuBlackHit:
                    Image(.openWindowBlackHit)
                case .none:
                    Text("")
                }
            case .dummyLeft:
                Image(.catchClippedWindowLeft)
            case .dummyRight:
                Image(.catchClippedWindowRight)
            case .dummyLeftBottom:
                Image(.catchClippedWindowLeftBottom)
            case .dummyRightBottom:
                Image(.catchClippedWindowRightBottom)
            case .dummyBottom:
                Image(.catchClippedWindowBottom)
            }
        }
    }
}

#Preview {
    CatchGameView(viewModel: CatchGameViewModel(.catchDucku, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(rootViewModel: RootViewModel()), timeStart: 60.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
