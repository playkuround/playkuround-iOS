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
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Image(.quizBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                // iPhone SE 기기대응을 위한 변수
                let shouldImagePadding = geometry.size.height >= 700
                
                VStack {
                    VStack {
                        let quiz = viewModel.quizData[viewModel.randomNumber ?? 0]
                        
                        Text(quiz.question)
                            .font(.neo20)
                            .kerning(-0.41)
                            .lineSpacing(6)
                            .foregroundStyle(.kuText)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                        
                        ForEach(quiz.options.indices, id: \.self) { index in
                            BlockView(option: quiz.options[index],
                                      index: index,
                                      isCorrectAnswer: $viewModel.isCorrectAnswer)
                        }
                    }
                    .padding(.horizontal, 20)
                    
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
                // navigationBar 
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
                //TODO: 정답 시 백그라운드 불투명도 적용
            }
            .onAppear {
                // view appear시 json파일에서 랜덤한 문제 생성
                viewModel.createRandomNumber(data: viewModel.quizData)
            }
        }
    }
}
