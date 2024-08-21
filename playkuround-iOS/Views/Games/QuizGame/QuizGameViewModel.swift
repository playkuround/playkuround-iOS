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
    @Published var isBlockEnabled: Bool = true
    
    var currentQuestionIndex: Int = 0
    var correctAnswersCount: Int = 0
    
    let quizData: [Quiz] = load("QuizData.json")
    var usedQuestionIndices: Set<Int> = []
    
    override func startGame() {
        currentQuestionIndex = 0
        correctAnswersCount = 0
        
        loadNextQuestion()
    }
    
    func createRandomNumber() {
        var newRandomNumber: Int?
        
        repeat {
            newRandomNumber = Int.random(in: 0..<quizData.count)
        } while usedQuestionIndices.contains(newRandomNumber!)
        
        randomNumber = newRandomNumber
        usedQuestionIndices.insert(newRandomNumber!)
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
    
    override func finishGame() {
        gameState = .finish
        self.calculateScore()
        
        // 3초 뒤 서버로 점수 업로드
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            super.uploadResult(uploadScore: self.score)
        }
    }
    
    private func calculateScore() {
        if correctAnswersCount >= 0 && correctAnswersCount <= 9 {
            score = 10 * ( correctAnswersCount + 1 )
        }
        else if correctAnswersCount >= 10 && correctAnswersCount <= 14 {
            score = 10 * ( 2 * correctAnswersCount - 8 )
        }
        else if correctAnswersCount == 15 {
            score = 250
        }
    }
}
