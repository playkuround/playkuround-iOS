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
    private let quizData: [Quiz] = load("QuizData.json")
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Image(.quizBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                let shouldImagePadding = geometry.size.height >= 700
                
                VStack {
                    QuizBlockView(quiz: quizData[viewModel.randomNumber ?? 0],
                                  selectedBlockIndex: $viewModel.selectedBlockIndex,
                                  isCorrectAnswer: $viewModel.isCorrectAnswer)
                    
                    if let isCorrectAnswer = viewModel.isCorrectAnswer {
                        //오답일 때
                        if !isCorrectAnswer {
                            Text("00.15")
                                .font(shouldImagePadding ? .neo45 : .neo38)
                                .kerning(-0.41)
                                .foregroundStyle(.kuText)
                                .padding(.vertical, shouldImagePadding ? 20 : 0)
                            
                            Text(StringLiterals.Game.Quiz.incorrect)
                                .font(.pretendard15R)
                                .foregroundStyle(.kuRed)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, shouldImagePadding ? 0 : 25)
                        }
                        else {
                            //정답일 때
                            Text(StringLiterals.Game.Quiz.correct)
                                .font(.pretendard15R)
                                .foregroundStyle(.kuGreen)
                                .multilineTextAlignment(.center)
                                .padding(.top, 20)
                                .padding(.bottom, shouldImagePadding ? 0 : 25)
                        }
                    }
                }
                .padding(.top, shouldImagePadding ? 140 : 100)
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
                
                if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                }
                else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                }
                if let isCorrectAnswer = viewModel.isCorrectAnswer {
                    if isCorrectAnswer {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                    }
                }
            }
            .onAppear {
                viewModel.createRandomNumber(data: quizData)
            }
        }
    }
}
