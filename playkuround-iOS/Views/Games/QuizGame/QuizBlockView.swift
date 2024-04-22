//
//  BlockView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/2/24.
//

import SwiftUI

struct BlockView: View {
    var option: String
    var index: Int
    
    @State private var quizState: QuizState = .normal
    @Binding var isCorrectAnswer: Bool?
    
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
                if let isCorrectAnswer = isCorrectAnswer {
                    if isCorrectAnswer {
                        quizState = .correct
                    }
                    else {
                        quizState = .incorrect
                    }
                }
            }
    }
}

