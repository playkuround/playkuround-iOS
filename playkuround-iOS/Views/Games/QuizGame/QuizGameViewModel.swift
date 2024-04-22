//
//  QuizGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/8/24.
//

import Foundation

final class QuizGameViewModel: GameViewModel {
    @Published var quizData: [Quiz] = load("QuizData.json")
    @Published var randomNumber: Int?
    @Published var isCorrectAnswer: Bool?
    @Published var selectedIndex: Int?
    
    @Published var milliSecond: String = "00"
    @Published var timerState: QuizTimerState = .ready
    
    func createRandomNumber(data: [Quiz]) {
        randomNumber = Int.random(in: 0..<data.count)
    }
    
    final func updateMilliSecondString() {
        self.milliSecond = String(format: "%02d", Int(timeRemaining * 100) % 100)
    }
    
    func blockClick() {
        if let isCorrectAnswer = isCorrectAnswer {
            // 정답일 때
            if isCorrectAnswer {
                score = 20
                finishGame()
            }
            // 오답일 때
            else {
                if timerState == .ready {
                    timerState = .running
                    isTimerUpdating = true
                    checkTimerFinished()
                }
            }
        }
    }
    
    func checkTimerFinished() {
        if timeRemaining <= 0.0 {
            timerState = .ready
            timeRemaining = 5.0
            isTimerUpdating = true
        }
    }
    
    override func finishGame() {
        gameState = .finish
        
        // 3초 뒤 서버로 점수 업로드
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            super.uploadResult()
        }
    }
}
