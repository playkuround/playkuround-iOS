//
//  CupidGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/26/24.
//

import SwiftUI

enum CupidResult {
    case bad
    case good
    case perfect
}

final class CupidGameViewModel: GameViewModel {
    
    @Published var duckPosition: CGFloat = 200
    @Published var result: CupidResult?
    
    /// 초기 오리 위치
    @Published var whiteDuckPosition: CGFloat = -UIScreen.main.bounds.width / 2 + 88
    @Published var blackDuckPosition: CGFloat = UIScreen.main.bounds.width / 2 - 88
    
    private var duckAnimationTimer: Timer?
    
    override func startGame() {
        super.startGame()
        super.startTimer()
        
        self.startDuckAnimation()
    }
    
    override func timerDone() {
        finishGame()
    }
    
    override func finishGame() {
        gameState = .finish
        stopDuckAnimation()
        
        print("finish score: \(score)")
        // 서버로 점수 업로드
        uploadResult()
    }
    
    func startDuckAnimation() {
        stopDuckAnimation()
        duckAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.003, repeats: true) { timer in
            withAnimation(.linear(duration: 0.003)) {
                self.whiteDuckPosition += 1
                self.blackDuckPosition -= 1
                self.duckPosition = self.blackDuckPosition - self.whiteDuckPosition
                
                // 오리가 서로 지나치면 애니메이션 멈추고 bad 처리
                if self.duckPosition < -164 {
                    self.result = .bad
                    self.stopDuckAnimation()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.resetDucks()
                        self.startDuckAnimation()
                    }
                }
            }
        }
    }
    
    private func stopDuckAnimation() {
        duckAnimationTimer?.invalidate()
        duckAnimationTimer = nil
    }
    
    private func resetDucks() {
        self.whiteDuckPosition = -UIScreen.main.bounds.width / 2 + 88
        self.blackDuckPosition = UIScreen.main.bounds.width / 2 - 88
        self.duckPosition = self.blackDuckPosition - self.whiteDuckPosition
        self.result = nil
    }
    
    func stopButtonTapped() {
        self.stopDuckAnimation()
        
        if abs(duckPosition) <= 16 {
            result = .perfect
            score += 3
            print(score)
        }
        else if abs(duckPosition) <= 32 {
            result = .good
            score += 1
            print(score)
        }
        else {
            result = .bad
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.resetDucks()
            self.startDuckAnimation()
        }
    }
}
