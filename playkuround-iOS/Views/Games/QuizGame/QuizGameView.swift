//
//  QuizGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/1/24.
//

import SwiftUI

struct QuizGameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var viewModel: QuizGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    @State private var selectedIndex: Int?
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Image(.quizBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                let shouldImagePadding = geometry.size.height >= 700
                
                VStack {
                    HStack {
                        Text("\(self.viewModel.score) " + NSLocalizedString("Game.Quiz.LongPoint", comment: ""))
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                        Spacer()
                    }
                    .padding(.horizontal, 32)
                    
                    Image(.quizBackDeco)
                    
                    if viewModel.currentQuestionIndex < viewModel.shuffledQuizData.count {
                        let quiz = viewModel.shuffledQuizData[viewModel.currentQuestionIndex]
                        
                        Text(quiz.question)
                            .font(.neo20)
                            .kerning(-0.41)
                            .lineSpacing(6)
                            .foregroundStyle(.kuText)
                            .multilineTextAlignment(.center)
                            .padding(.top, 30)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 20)
                        
                        ForEach(quiz.options.indices, id: \.self) { index in
                            BlockView(option: quiz.options[index],
                                      index: index,
                                      isCorrect: index == quiz.answer,
                                      viewModel: viewModel,
                                      isCorrectAnswer: $viewModel.isCorrectAnswer,
                                      selectedIndex: $selectedIndex)
                        }
                        
                        if let isCorrectAnswer = viewModel.isCorrectAnswer {
                            //정답일 때
                            if isCorrectAnswer {
                                Text("Game.Quiz.Correct")
                                    .font(.pretendard15R)
                                    .foregroundStyle(.kuGreen)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 20)
                                    .padding(.bottom, shouldImagePadding ? 0 : 25)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            viewModel.loadNextQuestion()
                                            selectedIndex = nil
                                        }
                                    }
                            }
                            else {
                                // 오답 시 게임 종료
                                Text("Game.Quiz.Incorrect")
                                    .font(.pretendard15R)
                                    .foregroundStyle(.kuRed)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 20)
                                    .padding(.bottom, shouldImagePadding ? 0 : 25)
                                    .onAppear {
                                        viewModel.finishGame()
                                    }
                            }
                        }
                    }
                }
                // .padding(.top, shouldImagePadding ? 140 : 90)
                .customNavigationBar(centerView: {
                    Text("Game.Quiz.Title")
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
                        Image(.grayPauseButton)
                    })
                }, height: 40)
                
                if viewModel.isQuizWaitingViewPresented {
                    GameWaitingView(.quiz, second: $viewModel.countdown)
                }
                else if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                }
                else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                }
                else if viewModel.isWaitingViewPresented {
                    GameWaitingView(second: $viewModel.countdown)
                }
            }
            .onAppear {
                viewModel.startGame()
                GAManager.shared.logScreenEvent(.QuizGame)
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
    QuizGameView(viewModel: QuizGameViewModel(.quiz, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(rootViewModel: RootViewModel()), timeStart: 15.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
