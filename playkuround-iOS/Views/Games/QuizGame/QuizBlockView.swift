//
//  QuizBlockView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/2/24.
//

import SwiftUI

struct QuizBlockView: View {
    let quiz: Quiz
    @Binding var selectedBlockIndex: Int?
    @Binding var isCorrectAnswer: Bool?
    var body: some View {
        VStack {
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
                          isCorrect: index == quiz.answer,
                          isCorrectBinding: $isCorrectAnswer)
                .disabled(isCorrectAnswer == true)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct BlockView: View {
    @State private var quizState: QuizState = .normal
    var option: String
    var index: Int
    //TODO: isCorrect와 isCorrectBinding 로직 수정 필요
    var isCorrect: Bool
    @Binding var isCorrectBinding: Bool?
    
    var body: some View {
        Image(quizState.image.rawValue)
            .overlay {
                HStack {
                    Image("\(quizState.numberImage.rawValue)\(index + 1)")
                        .padding(.horizontal, 15)
                    
                    Text(option)
                        .font(.pretendard15R)
                        .foregroundStyle(quizState == .unable ? .kuGray2 : .kuText)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 16)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 2)
            .onTapGesture {
                // viewModel.blockClick 함수 바인딩
                
                if isCorrect {
                    quizState = .correct
                    isCorrectBinding = true
                }
                else {
                    quizState = .incorrect
                    isCorrectBinding = false
                }
            }
    }
}

