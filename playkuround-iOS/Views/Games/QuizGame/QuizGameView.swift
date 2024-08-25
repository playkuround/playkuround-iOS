//
//  QuizGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/1/24.
//

import SwiftUI

struct QuizGameView: View {
    @ObservedObject var viewModel: QuizGameViewModel
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
                    if viewModel.currentQuestionIndex < viewModel.shuffledQuizData.count {
                        let quiz = viewModel.shuffledQuizData[viewModel.currentQuestionIndex]
                        
                        Text(quiz.question)
                            .font(.neo20)
                            .kerning(-0.41)
                            .lineSpacing(6)
                            .foregroundStyle(.kuText)
                            .multilineTextAlignment(.center)
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
                                Text(StringLiterals.Game.Quiz.correct)
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
                                Text(StringLiterals.Game.Quiz.incorrect)
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
                .padding(.top, shouldImagePadding ? 140 : 90)
                .customNavigationBar(centerView: {
                    Text(StringLiterals.Game.Quiz.title)
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.kuText)
                }, rightView: {
                    Button(action: {
                        viewModel.soundManager.playSound(sound: .buttonClicked)
                        viewModel.togglePauseView()
                    }, label: {
                        Image(.grayPauseButton)
                    })
                }, height: 40)
                
                if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                }
                else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                }
            }
        }
        .onAppear {
            viewModel.startGame()
            GAManager.shared.logScreenEvent(.QuizGame)
        }
    }
}
