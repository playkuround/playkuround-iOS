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
    
    let soundManager = SoundManager.shared
    
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
            self.soundManager.playSound(sound: .moonClicked)
        }
        else if 51 < moonTapped && moonTapped <= 81 {
            DispatchQueue.main.async {
                self.moonTapped -= 1
                self.moonState = .cracked
            }
            self.soundManager.playSound(sound: .moonClicked)
        }
        else if 1 < moonTapped && moonTapped <= 51 {
            DispatchQueue.main.async {
                self.moonTapped -= 1
                self.moonState = .moreCracked
            }
            self.soundManager.playSound(sound: .moonClicked)
        }
        else if moonTapped == 1 {
            DispatchQueue.main.async {
                self.moonTapped = 0
                self.moonState = .duck
                
                let leftTime = super.timeRemaining
                print("left time: \(leftTime)s")
                
                // 점수 로직 v1.6
                if leftTime > 12.0 {
                    self.score = 40 + 160
                }
                else if leftTime > 10.0 {
                    self.score = 40 + 100
                }
                else if leftTime > 8.0 {
                    self.score = 40 + 80
                }
                else if leftTime > 6.0 {
                    self.score = 40 + 60
                }
                else if leftTime > 4.0 {
                    self.score = 40 + 40
                }
                else if leftTime > 2.0 {
                    self.score = 40 + 30
                }
                else if leftTime > 1.0 {
                    self.score = 40 + 20
                }
                else if leftTime > 0.0 {
                    self.score = 40 + 10
                }
                else {
                    // 실패
                    self.score = 0
                }
                
                self.finishGame()
            }
            self.soundManager.playSound(sound: .moonHundredClicked)
            finishGame()
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
