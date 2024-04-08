//
//  QuizBlockView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/2/24.
//

import SwiftUI

struct QuizBlockView: View {
    let quiz: Quiz
    
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
                quizBlock(quizState: .unable,
                          option: quiz.options[index],
                          index: index)
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func quizBlock(quizState: QuizState,
                           option: String,
                           index: Int) -> some View {
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
    }
}

