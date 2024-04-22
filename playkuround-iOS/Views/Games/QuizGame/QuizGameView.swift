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
                
                // iPhone SE 기기대응을 위한 변수
                let shouldImagePadding = geometry.size.height >= 700
                
                VStack {
                    let quiz = viewModel.quizData[viewModel.randomNumber ?? 0]
                    
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
                        }
                        else {
                            //오답일 때
                            Text("\(viewModel.second).\(viewModel.milliSecond)")
                                .font(shouldImagePadding ? .neo45 : .neo38)
                                .kerning(-0.41)
                                .foregroundStyle(.kuText)
                                .padding(.vertical, shouldImagePadding ? 20 : 0)
                                .onReceive(viewModel.timer) { _ in
                                    if let isCorrect = viewModel.isCorrectAnswer {
                                        if !isCorrect && viewModel.timerState == .running {
                                            viewModel.updateTimer2()
                                            viewModel.updateMilliSecondString()
                                            
                                            if viewModel.timeRemaining < 0 {
                                                viewModel.checkTimerFinished()
                                                selectedIndex = nil
                                                viewModel.isCorrectAnswer = nil
                                            }
                                        }
                                    }
                                }
                            
                            Text(StringLiterals.Game.Quiz.incorrect)
                                .font(.pretendard15R)
                                .foregroundStyle(.kuRed)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, shouldImagePadding ? 0 : 25)
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
                        viewModel.togglePauseView()
                    }, label: {
                        Image(.grayPauseButton)
                    })
                }, height: 40)
                
                if let isCorrectAnswer = viewModel.isCorrectAnswer {
                    if isCorrectAnswer {
                        Color.black.opacity(0.3).ignoresSafeArea(.all)
                    }
                }
                if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                }
                else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                }
            }
            .onAppear {
                viewModel.createRandomNumber(data: viewModel.quizData)
            }
        }
    }
}
