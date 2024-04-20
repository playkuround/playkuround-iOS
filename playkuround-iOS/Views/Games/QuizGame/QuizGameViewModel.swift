//
//  QuizGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/8/24.
//

import Foundation

final class QuizGameViewModel: GameViewModel {
    @Published var quizState: QuizState = .normal
    @Published var randomNumber: Int?
    @Published var selectedBlockIndex: Int?
    @Published var isCorrectAnswer: Bool?
    
    @Published var milliSecond: String = "00"
    @Published var timerState: TimerState = .ready
    
    func createRandomNumber(data: [Quiz]) {
        randomNumber = Int.random(in: 0..<data.count)
    }
    
    final func updateMilliSecondString() {
        self.milliSecond = String(format: "%02d", Int(timeRemaining * 100) % 100)
    }
    
    func blockClick() {
        if let isCorrectAnswer = isCorrectAnswer {
            print("isCorrectAnswer \(isCorrectAnswer)")
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
                }
                else if timerState == .running {
                    
                }
            }
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
