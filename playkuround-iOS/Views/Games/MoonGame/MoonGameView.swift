//
//  MoonGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/31/24.
//

import SwiftUI

struct MoonGameView: View {
    @ObservedObject var viewModel: MoonGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    @State private var shouldShake = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(.moonBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                    .onReceive(viewModel.timer) { _ in
                        viewModel.updateTimer()
                    }
                
                // 뷰의 사이즈에 따라 Image의 padding값 조절
                let shouldImagePadding = geometry.size.height >= 700
                
                VStack {
                    Text(StringLiterals.Game.Moon.description)
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
                    }
                }
                .padding(.top, 70)
                .customNavigationBar(centerView: {
                    Text(StringLiterals.Game.Moon.title)
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
                
                if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                }
                else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                }
                else if viewModel.moonTapped == 0 {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                }
            }
        }
        .onAppear {
            viewModel.startCountdown()
            GAManager.shared.logScreenEvent(.MoonGame)
        }
    }
    
    private func moonImage(named imageName: String, padding: Bool) -> some View {
        Image(imageName)
            .padding(.bottom, padding ? 40 : 0)
            .offset(x: shouldShake ? -3 : 3, y: 0)
            .onTapGesture {
                withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(4)) {
                    self.shouldShake.toggle()
                }
                viewModel.moonClick()
            }
            .disabled(viewModel.moonTapped == 0)
    }
}
