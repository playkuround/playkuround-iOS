//
//  QuizBlockView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/2/24.
//

import SwiftUI

struct QuizBlockView: View {
    let imageNames = ["gray1", "gray2", "gray3", "gray4"]
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
                .padding(.bottom, 50)
            
            ForEach(quiz.options.indices, id: \.self) { index in
                Image(.quizBlock)
                    .overlay {
                        HStack {
                            Image(imageNames[index])
                                .padding(.horizontal, 15)
                            
                            Text(quiz.options[index])
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
        .padding(.horizontal, 20)
    }
}
