//
//  QuizState.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/8/24.
//

import Foundation

enum QuizState {
    case normal
    case unable
    case correct
    case incorrect
    
    var image: BlockImage {
        switch self {
        case .normal: return .quizBlock
        case .unable: return .quizUnableBlock
        case .correct: return .quizCorrectBlock
        case .incorrect: return .quizIncorrectBlock
        }
    }
    
    var numberImage: NumberImage {
        switch self {
        case .normal: return .gray
        case .unable: return .lightGray
        case .correct: return .white
        case .incorrect: return .white
        }
    }
}

enum BlockImage: String {
    case quizBlock
    case quizUnableBlock
    case quizCorrectBlock
    case quizIncorrectBlock
}

enum NumberImage: String {
    case gray
    case lightGray
    case white
}
