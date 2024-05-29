//
//  AllClickGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/27/24.
//

import Foundation

final class AllClickGameViewModel: GameViewModel {
    @Published var countdownCompleted: Bool = false
    // 생명
    @Published var life: Int = 3
    
    override func startGame() {
        print(countdownCompleted)
        super.startGame()
        
        countdownCompleted = true
        print(countdownCompleted)
    }
    
    override func timerDone() {
        finishGame()
    }
    
    override func finishGame() {
        gameState = .finish
        
        // 서버로 점수 업로드
        uploadResult()
    }
}
