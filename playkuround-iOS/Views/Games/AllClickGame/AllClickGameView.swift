//
//  AllClickGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/27/24.
//

import SwiftUI
import Combine

struct AllClickGameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var viewModel: AllClickGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    @State private var userText: String = ""
    @State private var userHeight: CGFloat = 0
    @State private var shouldBecomeFirstResponder: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    Image(.allClickBackground)
                        .resizable()
                        .ignoresSafeArea(edges: .all)
                    
                    Image(.allClickDuckku)
                        .offset(y: -20)
                }
                .ignoresSafeArea(.keyboard)
                
                let shouldFontResize = geometry.size.width <= 375
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Game.AllClick.Score")
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.trailing, 12)
                        
                        Text("\(viewModel.score)")
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                        
                        Spacer()
                        
                        HStack(spacing: 3){
                            Image(viewModel.life > 0 ? .allClickHeart : .allClickHeartEmpty)
                            Image(viewModel.life > 1 ? .allClickHeart : .allClickHeartEmpty)
                            Image(viewModel.life > 2 ? .allClickHeart : .allClickHeartEmpty)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    GeometryReader { geometry in
                        ForEach(viewModel.subjects.indices, id: \.self) { index in
                            AllClickTextRainView(subject: viewModel.subjects[index])
                                .position(x: viewModel.subjects[index].xPosition,
                                          y: viewModel.subjects[index].yPosition)
                        }
                    }
                    .padding(.top, 10)
                    
                    HStack(spacing: 0) {
                        Spacer()
                        
                        Text("Game.AllClick.ClassRegistration")
                            .font(shouldFontResize ? .neo17 : .neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.allClickGreen)
                        
                        Spacer()
                        
                        Image(.allClickWritingBox)
                            .overlay(alignment: .leading) {
                                AllClickCustomTextView(viewModel: viewModel,
                                                       text: $userText,
                                                       height: $userHeight,
                                                       shouldBecomeFirstResponder: $shouldBecomeFirstResponder)
                                .frame(height: 30, alignment: .center)
                                .frame(width: 200)
                                .padding(.leading, 8)
                                .overlay(alignment: .leading) {
                                    if userText.isEmpty {
                                        Text("Game.AllClick.WriteSubject")
                                            .font(.neo18)
                                            .kerning(-0.41)
                                            .foregroundStyle(.kuGray2)
                                            .padding(.leading, 16)
                                    }
                                }
                            }
                        
                        Spacer()
                        
                        Image(.allClickRegister)
                            .overlay {
                                Text("Game.AllClick.Register")
                                    .font(.neo18)
                                    .kerning(-0.41)
                                    .foregroundStyle(.white)
                            }
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .background(.white)
                    .offset(y: 8)
                }
                .customNavigationBar(centerView: {
                    Text("Game.AllClick.Title")
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
                }, height: 57)
                
                if viewModel.isCountdownViewPresented {
                    CountdownView(countdown: $viewModel.countdown)
                } else if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                        .onAppear {
                            viewModel.stopSubjectRain()
                            shouldBecomeFirstResponder = false
                        }
                        .onDisappear {
                            viewModel.startSubjectRain()
                            shouldBecomeFirstResponder = true
                        }
                } else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                        .onAppear {
                            viewModel.stopSubjectRain()
                            shouldBecomeFirstResponder = false
                        }
                }
            }
            .onAppear {
                viewModel.startCountdown()
                GAManager.shared.logScreenEvent(.AllClickGame)
            }
            .onChange(of: viewModel.countdownCompleted) { completed in
                if completed {
                    shouldBecomeFirstResponder = true
                }
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
    AllClickGameView(viewModel: AllClickGameViewModel(.allClear, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(rootViewModel: RootViewModel()), timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
