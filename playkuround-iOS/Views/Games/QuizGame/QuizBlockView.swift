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
    var isCorrect: Bool
    
    @ObservedObject var viewModel: QuizGameViewModel
    @State private var quizState: QuizState = .normal
    @Binding var isCorrectAnswer: Bool?
    @Binding var selectedIndex: Int?
    
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
                selectedIndex = index
                if isCorrect {
                    quizState = .correct
                    isCorrectAnswer = true
                }
                else {
                    quizState = .incorrect
                    isCorrectAnswer = false
                }
                viewModel.blockClick()
            }
            .disabled(quizState != .normal)
            .onChange(of: isCorrectAnswer) { newValue in
                if index != selectedIndex {
                    quizState = .unable
                }
            }
            .onReceive(viewModel.timer) { _ in
                if viewModel.timerState == .ready {
                    if index != selectedIndex {
                        quizState = .normal
                    }
                }
            }
    }
}

