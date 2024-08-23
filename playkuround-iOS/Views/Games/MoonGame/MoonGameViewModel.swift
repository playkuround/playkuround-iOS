//
//  MoonGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/5/24.
//

import Foundation

final class MoonGameViewModel: GameViewModel {
    @Published var moonState: MoonState = .fullMoon
    @Published var moonTapped: Int = 100
    
    override func startGame() {
        super.startGame()
        super.startTimer()
    }
    
    override func timerDone() {
        DispatchQueue.main.async {
            self.score = 0 // 실패
            self.finishGame()
        }
    }
    
    func moonClick() {
        if 81 < moonTapped && moonTapped <= 100 {
            DispatchQueue.main.async {
                self.moonTapped -= 1
                self.moonState = .fullMoon
            }
        }
        else if 51 < moonTapped && moonTapped <= 81 {
            DispatchQueue.main.async {
                self.moonTapped -= 1
                self.moonState = .cracked
            }
        }
        else if 1 < moonTapped && moonTapped <= 51 {
            DispatchQueue.main.async {
                self.moonTapped -= 1
                self.moonState = .moreCracked
            }
        }
        else if moonTapped == 1 {
            DispatchQueue.main.async {
                self.moonTapped = 0
                self.moonState = .duck
                
                let leftTime = super.timeRemaining
                print("left time: \(leftTime)s")
                
                if leftTime >= 13.0 {
                    // 기본 30 + 추가 30
                    self.score = 30 + 30
                } else if leftTime >= 9.0 {
                    // 기본 30 + 추가 15
                    self.score = 30 + 15
                } else if leftTime >= 6.0 {
                    // 기본 30 + 추가 10
                    self.score = 30 + 10
                } else if leftTime >= 4.0 {
                    // 기본 30 + 추가 5
                    self.score = 30 + 5
                } else {
                    // 기본 30 + 추가 0
                    self.score = 30
                }
                
                self.finishGame()
            }
        }
    }
    
    override func finishGame() {
        DispatchQueue.main.async {
            self.gameState = .finish
        }
        
        // 3초 뒤 서버로 점수 업로드
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            super.uploadResult(uploadScore: self.score)
        }
    }
}
