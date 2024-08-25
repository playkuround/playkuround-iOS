//
//  TimerGameViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/3/24.
//

import Foundation
import SwiftUI

final class TimerGameViewModel: GameViewModel {
    @Published var milliSecond: String = "00"
    @Published var timerState: TimerState = .ready
    
    let soundManager = SoundManager.shared
    
    final func updateMilliSecondString() {
        self.milliSecond = String(format: "%02d", Int(timeRemaining * 100) % 100)
    }
    
    func timeButtonClick() {
        // 시작 전
        if timerState == .ready {
            timerState = .running
            isTimerUpdating = true
            soundManager.playSound(sound: .timerButtonClicked)
        }
        // 성공 여부 체크
        else if timerState == .running {
            isTimerUpdating = false
            
            // 오차 0 -> 200점
            if timeRemaining == 10.0 {
                timerState = .perfect
                self.score = 200
                soundManager.playSound(sound: .timerCorrect)
                finishGame()
            }
            // 오차 +- 0.25 -> 40점
            else if 9.75 <= timeRemaining && timeRemaining <= 10.25 {
                timerState = .failed
                self.score = 40
                soundManager.playSound(sound: .timerIncorrect)
                finishGame()
            }
            // 오차 +- 0.5 -> 35점
            else if 9.5 <= timeRemaining && timeRemaining <= 10.5 {
                timerState = .failed
                self.score = 35
                soundManager.playSound(sound: .timerIncorrect)
                finishGame()
            }
            // 오차 +- 0.75 -> 30점
            else if 9.25 <= timeRemaining && timeRemaining <= 10.75 {
                timerState = .failed
                self.score = 30
                soundManager.playSound(sound: .timerIncorrect)
                finishGame()
            }
            // 오차 +- 1 -> 20점
            else if 9.0 <= timeRemaining && timeRemaining <= 11.0 {
                timerState = .failed
                self.score = 20
                soundManager.playSound(sound: .timerIncorrect)
                finishGame()
            }
            // 이외 5점
            else {
                timerState = .failed
                self.score = 5
                soundManager.playSound(sound: .timerIncorrect)
                finishGame()
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
