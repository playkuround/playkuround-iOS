//
//  QuizGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/8/24.
//

import Foundation

final class QuizGameViewModel: GameViewModel {
    @Published var randomNumber: Int?
    @Published var isCorrectAnswer: Bool?
    @Published var selectedIndex: Int?
    @Published var timerState: QuizTimerState = .ready
    @Published var isBlockEnabled: Bool = true
    
    var currentQuestionIndex: Int = 0
    var correctAnswersCount: Int = 0
    
    let quizData: [Quiz] = load("QuizData.json")
    
    override func startGame() {
        currentQuestionIndex = 0
        correctAnswersCount = 0
        
        loadNextQuestion()
    }
    
    func createRandomNumber() {
        randomNumber = Int.random(in: 1..<quizData.count)
    }
    
    func loadNextQuestion() {
        if currentQuestionIndex < quizData.count {
            randomNumber = Int.random(in: 1..<quizData.count)
            currentQuestionIndex += 1
            isCorrectAnswer = nil
        } else {
            finishGame()
        }
    }
    
    func blockClick() {
        guard let isCorrectAnswer = isCorrectAnswer else { return }
        
        if timerState == .ready {
            isBlockEnabled = false  // 블록을 비활성화
            
            if isCorrectAnswer {
                correctAnswersCount += 1
                score += correctAnswersCount * 10
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.loadNextQuestion()
                    self.isBlockEnabled = true
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.finishGame()
                }
            }
        }
    }
    
    override func finishGame() {
        gameState = .finish
        
        // 3초 뒤 서버로 점수 업로드
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            super.uploadResult(uploadScore: self.score)
        }
    }
}
