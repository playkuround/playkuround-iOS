//
//  QuizGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/8/24.
//

import Foundation

final class QuizGameViewModel: GameViewModel {
    @Published var quizState: QuizState = .normal
    @Published var randomQuiz: Quiz?
    @Published var randomNumber: Int?
    
    func blockClick() {
        
    }
    
    func createRandomNumber(data: [Quiz]) {
        randomNumber = Int.random(in: 0..<data.count)
    }
}
