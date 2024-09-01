//
//  MoonGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/31/24.
//

import SwiftUI

struct MoonGameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var viewModel: MoonGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    @State private var shouldShake = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(.moonBackground)
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
                    
                    Text("Game.Moon.Description")
                        .font(.pretendard15R)
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                    
                    Text("\(viewModel.moonTapped)")
                        .font(.neo50)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .overlay {
                    switch viewModel.moonState {
                    case .fullMoon, .cracked, .moreCracked, .duck:
                        moonImage(named: viewModel.moonState.image.rawValue, padding: shouldImagePadding)
                            .offset(y: shouldImagePadding ? 44 : 20)
                    }
                }
                .customNavigationBar(centerView: {
                    Text("Game.Moon.Title")
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
                        Image(.yellowPauseButton)
                    })
                }, height: 67)
                
                if viewModel.moonTapped == 0 {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                }
                
                if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                }
                else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                } else if viewModel.isCountdownViewPresented {
                    CountdownView(countdown: $viewModel.countdown)
                } else if viewModel.isWaitingViewPresented {
                    GameWaitingView(second: $viewModel.countdown)
                }
            }
            .onAppear {
                viewModel.startCountdown()
                GAManager.shared.logScreenEvent(.MoonGame)
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
    
    private func moonImage(named imageName: String, padding: Bool) -> some View {
        Image(imageName)
            .padding(.bottom, padding ? 40 : 0)
            .offset(x: shouldShake ? -3 : 3, y: 0)
            .onTapGesture {
                if self.viewModel.moonTapped > 0 {
                    withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(4)) {
                        self.shouldShake.toggle()
                    }
                    viewModel.moonClick()
                }
            }
            .disabled(viewModel.moonTapped == 0)
    }
}

#Preview {
    MoonGameView(viewModel: MoonGameViewModel(.moon, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(rootViewModel: RootViewModel()), timeStart: 15.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
