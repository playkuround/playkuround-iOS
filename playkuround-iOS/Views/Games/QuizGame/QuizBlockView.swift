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
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
            
            ForEach(quiz.options.indices, id: \.self) { index in
                quizBlock(blockState: .correct,
                          image: numberImage.allCases[index].rawValue,
                          option: quiz.options[index])
            }
        }
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private func quizBlock(blockState: BlockState,
                           image: String,
                           option: String) -> some View {
        Image(blockState.image.rawValue)
            .overlay {
                HStack {
                    Image(image)
                        .padding(.horizontal, 15)
                    
                    Text(option)
                        .font(.pretendard15R)
                        .foregroundStyle(.kuText)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 16)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 2)
    }
}

