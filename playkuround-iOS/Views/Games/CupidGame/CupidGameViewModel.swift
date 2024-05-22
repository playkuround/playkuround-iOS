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
    
    @Published var result: CupidResult?
    
    /// 초기 오리 위치
    @Published var whiteDuckPosition: CGFloat = -UIScreen.main.bounds.width / 2 + 88
    @Published var blackDuckPosition: CGFloat = UIScreen.main.bounds.width / 2 - 88
    
    /// 두 오리 이미지가 완전히 겹쳐지는 offset
    private let centralPosition: CGFloat = 46
    
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
        
        // 서버로 점수 업로드
        uploadResult()
    }
    
    func startDuckAnimation() {
        stopDuckAnimation()
        
        duckAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.003, repeats: true) { timer in
            withAnimation(.linear(duration: 0.003)) {
                self.whiteDuckPosition += 1
                self.blackDuckPosition -= 1
                
                let whiteDuckDistance = (self.whiteDuckPosition - self.centralPosition)
                let blackDuckDistance = (self.blackDuckPosition + self.centralPosition)
                
                /// 오리가 서로 지나칠 때
                if  whiteDuckDistance > 16 && blackDuckDistance < -16 {
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
    
    func stopDuckAnimation() {
        duckAnimationTimer?.invalidate()
        duckAnimationTimer = nil
    }
    
    private func resetDucks() {
        self.whiteDuckPosition = -UIScreen.main.bounds.width / 2 + 88
        self.blackDuckPosition = UIScreen.main.bounds.width / 2 - 88
        self.result = nil
    }
    
    func stopButtonTapped() {
        self.stopDuckAnimation()
        
        let whiteDuckDistance = abs(whiteDuckPosition - centralPosition)
        let blackDuckDistance = abs(blackDuckPosition + centralPosition)
        
        if whiteDuckDistance <= 8 && blackDuckDistance <= 8 {
            result = .perfect
            score += 3
        }
        else if whiteDuckDistance <= 16 && blackDuckDistance <= 16 {
            result = .good
            score += 1
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
