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
        uploadResult(uploadScore: score)
    }
    
    func startDuckAnimation() {
        stopDuckAnimation()
        
        duckAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.003, repeats: true) { timer in
            withAnimation(.linear(duration: 0.003)) {
                if self.isTimerUpdating {
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
        let randomInterval = Double.random(in: 0.3...0.6) // 게임 밸런스를 위해 임의로 인터벌 값 조정
        duckSpawnTimer = Timer.scheduledTimer(withTimeInterval: randomInterval, repeats: false) { timer in
            self.addNewDuck()
            self.scheduleNextDuckSpawn() // 다음 타이머 스케쥴링
        }
    }
    
    private func addNewDuck() {
        let initialWhiteDuckPosition: CGFloat = -UIScreen.main.bounds.width / 2 + 40
        let initialBlackDuckPosition: CGFloat = UIScreen.main.bounds.width / 2 - 40
        whiteDucksPositions.append(initialWhiteDuckPosition)
        blackDucksPositions.append(initialBlackDuckPosition)
    }
    
    private func checkDucksPosition() {
        var indicesToRemove: Set<Int> = [] // 중복 방지를 위해 Set 사용
        
        for i in 0..<whiteDucksPositions.count {
            let whiteDuckDistance = (self.whiteDucksPositions[i] - self.centralPosition)
            let blackDuckDistance = (self.blackDucksPositions[i] + self.centralPosition)
            
            /// 오리가 서로 지나칠 때
            if whiteDuckDistance > 16 && blackDuckDistance < -16 {
                self.result = .bad
                indicesToRemove.insert(i)
            }
        }
        
        if !indicesToRemove.isEmpty {
            removeDucks(at: Array(indicesToRemove))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.startDuckAnimation()
                self.result = nil
            }
        }
    }
    
    private func removeDucks(at indices: [Int]) {
        for index in indices.sorted(by: >) {
            whiteDucksPositions.remove(at: index)
            blackDucksPositions.remove(at: index)
        }
    }
    
    func stopButtonTapped() {
        self.stopDuckAnimation()
        
        var closestIndex: Int?
        var closestDistance: CGFloat = CGFloat.greatestFiniteMagnitude
        
        for i in 0..<whiteDucksPositions.count {
            let whiteDuckDistance = abs(whiteDucksPositions[i] - centralPosition)
            let blackDuckDistance = abs(blackDucksPositions[i] + centralPosition)
            
            // 두 오리 간의 거리 계산
            let totalDistance = whiteDuckDistance + blackDuckDistance
            
            // 가장 가까운 오리 쌍을 찾음
            if totalDistance < closestDistance {
                closestDistance = totalDistance
                closestIndex = i
            }
        }
        
        // 가장 가까운 오리 쌍에 대해 점수 계산 및 삭제
        if let index = closestIndex {
            let whiteDuckDistance = abs(whiteDucksPositions[index] - centralPosition)
            let blackDuckDistance = abs(blackDucksPositions[index] + centralPosition)
            
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
            
            removeDucks(at: [index])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.startDuckAnimation()
            self.result = nil
        }
    }
}
