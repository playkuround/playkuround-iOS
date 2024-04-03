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
    
    final func updateMilliSecondString() {
        self.milliSecond = String(format: "%02d", Int(timeRemaining * 100) % 100)
    }
    
    func timeButtonClick() {
        // 시작 전
        if timerState == .ready {
            timerState = .running
            isTimerUpdating = true
        }
        // 성공 여부 체크
        else if timerState == .running {
            isTimerUpdating = false
            if timeRemaining == 10.0 {
                timerState = .perfect
                // 점수 계산 후 finishGame 함수 호출
                score = 500
                finishGame()
            } else if 9.90 <= timeRemaining && timeRemaining <= 10.10 {
                timerState = .success
                // 점수 계산 후 finishGame 함수 호출
                score = 50
                finishGame()
            } else {
                // 실패 처리
                timerState = .failed
            }
        }
        // 실패 시 재시도
        else if timerState == .failed {
            timerState = .running
            timeRemaining = 0.0
            isTimerUpdating = true
        }
    }
    
    override func startGame() {
        super.startGame()
    }
    
    override func finishGame() {
        gameState = .finish
    
        // 3초 뒤 서버로 점수 업로드
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            super.uploadResult()
        }
    }
}
