//
//  AllClickGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/27/24.
//

import SwiftUI
import Combine

final class AllClickGameViewModel: GameViewModel {
    
    @Published var countdownCompleted: Bool = false
    @Published var life: Int = 3
    @Published var subjects: [Subject] = []

    private var subjectRainTimer: Timer?
    
    override func startGame() {
        super.startGame()
        
        countdownCompleted = true
        startSubjectRain()
    }

    override func finishGame() {
        gameState = .finish
        
        // 서버로 점수 업로드
        uploadResult(uploadScore: score)
    }
    
    func startSubjectRain(withInterval interval: TimeInterval = 1.0) {
        var currentFallingCount = 0 // 현재까지 내려온 글자의 수
        var randomFallingCount = 1  // 랜덤으로 지정된 내려오는 횟수
        var elapsedTime: TimeInterval = 0 // 경과 시간 추적
        var currentInterval: TimeInterval = interval
        
        subjectRainTimer = Timer.scheduledTimer(withTimeInterval: currentInterval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            // 경과 시간 업데이트
            elapsedTime += currentInterval
            
            for i in self.subjects.indices {
                self.subjects[i].yPosition += 20
                
                //임시
                if self.subjects[i].yPosition >= 300 {
                    self.life -= 1
                    if self.life <= 0 {
                        self.finishGame()
                        return
                    }
                    self.subjects.remove(at: i)
                    return
                }
            }
            
            currentFallingCount += 1
            
            // 내려오는 횟수가 랜덤으로 지정된 횟수일 때에만 새로운 글자를 추가.
            if currentFallingCount == randomFallingCount, let newSubject = subjectList.randomElement() {
                var subject = newSubject
                subject.xPosition = self.randomXPosition()
                subject.yPosition = 0
                self.subjects.append(subject)
                
                // 새로운 글자를 추가한 후, 다음 추가 타이밍을 위해 새로운 랜덤 값을 생성.
                currentFallingCount = 0
                randomFallingCount = Int.random(in: 2...7)
            }
            
            // 30초 경과 시 타이머 간격 0.2초씩 감소
            if elapsedTime >= 30.0 {
                elapsedTime = 0.0
                currentInterval = max(0.4, currentInterval - 0.2)
                self.subjectRainTimer?.invalidate()
                self.startSubjectRain(withInterval: currentInterval)
            }
        }
    }
    
    func randomXPosition() -> CGFloat {
        var xPosition: CGFloat = 20
        let temp = Int.random(in: 60...Int(UIScreen.main.bounds.width) - 60)
        xPosition = CGFloat(temp)
        return xPosition
    }
    
    func stopSubjectRain() {
        subjectRainTimer?.invalidate()
        subjectRainTimer = nil
    }
    
    func calculateScore(index: Int) {
        // 기초교양일 때 -> 기존 점수 + 1
        if self.subjects[index].type == .basic {
            if 3 <= self.subjects[index].title.count, self.subjects[index].title.count <= 5 {
                score += 2
            }
            else if 6 <= self.subjects[index].title.count, self.subjects[index].title.count <= 8 {
                score += 3
            }
            else if 9 <= self.subjects[index].title.count {
                score += 4
            }
        }
        else {
            if 3 <= self.subjects[index].title.count, self.subjects[index].title.count <= 5 {
                score += 1
            }
            else if 6 <= self.subjects[index].title.count, self.subjects[index].title.count <= 8 {
                score += 2
            }
            else if 9 <= self.subjects[index].title.count {
                score += 3
            }
        }
    }
}
