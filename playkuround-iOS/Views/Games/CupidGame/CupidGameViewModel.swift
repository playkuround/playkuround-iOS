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
    
    /// 오리 위치 배열
    @Published var whiteDucksPositions: [CGFloat] = [-UIScreen.main.bounds.width / 2 + 88]
    @Published var blackDucksPositions: [CGFloat] = [UIScreen.main.bounds.width / 2 - 88]
    
    /// 두 오리 이미지가 완전히 겹쳐지는 offset
    private let centralPosition: CGFloat = 46
    
    private var duckAnimationTimer: Timer?
    private var duckSpawnTimer: Timer?
    
    override func startGame() {
        super.startGame()
        super.startTimer()
        
        self.startDuckAnimation()
        self.startDuckSpawn()
    }
    
    override func timerDone() {
        finishGame()
    }
    
    override func finishGame() {
        gameState = .finish
        stopDuckAnimation()
        stopDuckSpawn()
        
        // 서버로 점수 업로드
        uploadResult()
    }
    
    func startDuckAnimation() {
        stopDuckAnimation()
        
        duckAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.003, repeats: true) { timer in
            withAnimation(.linear(duration: 0.003)) {
                for i in 0..<self.whiteDucksPositions.count {
                    self.whiteDucksPositions[i] += 1
                }
                for i in 0..<self.blackDucksPositions.count {
                    self.blackDucksPositions[i] -= 1
                }
                
                self.checkDucksPosition()
            }
        }
    }
    
    func stopDuckAnimation() {
        duckAnimationTimer?.invalidate()
        duckAnimationTimer = nil
    }
    
    func startDuckSpawn() {
        stopDuckSpawn()
        scheduleNextDuckSpawn()
    }
    
    func stopDuckSpawn() {
        duckSpawnTimer?.invalidate()
        duckSpawnTimer = nil
    }
    
    func scheduleNextDuckSpawn() {
        let randomInterval = Double.random(in: 0.5...0.8) // 게임 밸런스를 위해 임의로 인터벌 값 조정
        duckSpawnTimer = Timer.scheduledTimer(withTimeInterval: randomInterval, repeats: false) { timer in
            self.addNewDuck()
            self.scheduleNextDuckSpawn() // 다음 타이머 스케쥴링
        }
    }
    
    private func addNewDuck() {
        let initialWhiteDuckPosition: CGFloat = -UIScreen.main.bounds.width / 2 + 88
        let initialBlackDuckPosition: CGFloat = UIScreen.main.bounds.width / 2 - 88
        whiteDucksPositions.append(initialWhiteDuckPosition)
        blackDucksPositions.append(initialBlackDuckPosition)
    }
    
    private func checkDucksPosition() {
        var indicesToRemove: [Int] = []
        
        for i in 0..<whiteDucksPositions.count {
            let whiteDuckDistance = (self.whiteDucksPositions[i] - self.centralPosition)
            let blackDuckDistance = (self.blackDucksPositions[i] + self.centralPosition)
            
            /// 오리가 서로 지나칠 때
            if whiteDuckDistance > 16 && blackDuckDistance < -16 {
                self.result = .bad
                self.stopDuckAnimation()
                indicesToRemove.append(i)
            }
        }
        
        if !indicesToRemove.isEmpty {
            removeDucks(at: indicesToRemove)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.startDuckAnimation()
            }
        }
    }
    
    private func removeDucks(at indices: [Int]) {
        for index in indices.sorted(by: >) {
            whiteDucksPositions.remove(at: index)
            blackDucksPositions.remove(at: index)
        }
        self.result = nil
    }
    
    func stopButtonTapped() {
        self.stopDuckAnimation()
        
        var indicesToRemove: [Int] = []
        var foundResult = false
        
        for i in 0..<whiteDucksPositions.count {
            let whiteDuckDistance = abs(whiteDucksPositions[i] - centralPosition)
            let blackDuckDistance = abs(blackDucksPositions[i] + centralPosition)
            
            if whiteDuckDistance <= 8 && blackDuckDistance <= 8 {
                result = .perfect
                score += 3
                foundResult = true
                break
            }
            else if whiteDuckDistance <= 16 && blackDuckDistance <= 16 {
                result = .good
                score += 1
                foundResult = true
                break
            }
        }
        
        if !foundResult {
            result = .bad
        }
        
        if !indicesToRemove.isEmpty {
            removeDucks(at: indicesToRemove)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.startDuckAnimation()
        }
    }
}
