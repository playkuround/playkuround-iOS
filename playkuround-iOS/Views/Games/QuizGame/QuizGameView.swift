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
                    QuizBlockView(quiz: quizData[viewModel.randomNumber ?? 0])
                    
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
            }
            .onAppear {
                viewModel.createRandomNumber(data: quizData)
            }
        }
    }
}
