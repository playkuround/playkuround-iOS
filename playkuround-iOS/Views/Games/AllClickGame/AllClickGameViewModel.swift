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
    // 생명 개수
    @Published var life: Int = 3
    @Published var subjects: [Subject] = []
    @Published var textRainOffsets: [CGFloat] = []
    private var subjectRainTimer: Timer?
    
    override func startGame() {
        super.startGame()
        countdownCompleted = true
        startSubjectRain()
    }
    
    override func timerDone() {
        finishGame()
    }
    
    override func finishGame() {
        gameState = .finish
        
        // 서버로 점수 업로드
        uploadResult()
    }
    
    func startSubjectRain() {
        var currentFallingCount = 0 // 현재까지 내려온 글자의 수
        var randomFallingCount = 1  // 랜덤으로 지정된 내려오는 횟수
        
        subjectRainTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            for i in self.subjects.indices {
                self.subjects[i].yOffset += 20
            }
            self.subjects.removeAll { $0.yOffset > UIScreen.main.bounds.height }
            
            currentFallingCount += 1
            
            // 내려오는 횟수가 랜덤으로 지정된 횟수일 때에만 새로운 글자를 추가.
            if currentFallingCount == randomFallingCount, let newSubject = subjectList.randomElement() {
                var subject = newSubject
                subject.xOffset = self.randomXOffset()
                subject.yOffset = -150 // 초기 offset 설정
                self.subjects.append(subject)
                
                // 새로운 글자를 추가한 후, 다음 추가 타이밍을 위해 새로운 랜덤 값을 생성.
                currentFallingCount = 0
                randomFallingCount = Int.random(in: 2...7)
            }
        }
    }
    
    func randomXOffset() -> CGFloat {
        var xOffset: CGFloat = 0
        let temp = Int.random(in: -50...130)
        xOffset = CGFloat(temp)
        return xOffset
    }
    
    func stopSubjectRain() {
        subjectRainTimer?.invalidate()
        subjectRainTimer = nil
    }
}
