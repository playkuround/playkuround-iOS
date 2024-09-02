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
    @Published var isResultTitleShowing: Bool = false
    @Published var resultType: CupidResultType = .bad
    
    private var frameWidth: CGFloat = 0.0
    
    let soundManager = SoundManager.shared
    
    @Published var duckkuList: [CupidEntity] = []
    
    private var id: Int = 0
    @Published var duckNum: Int = 0
    
    override func startGame() {
        super.startGame()
        super.startTimer()
    }
    
    override func timerDone() {
        finishGame()
    }
    
    override func finishGame() {
        if self.gameState != .finish {
            DispatchQueue.main.async {
                self.gameState = .finish
                
                self.isWaitingViewPresented = true
                self.countdown = 3
                
                self.startResultCountdownProgress()
            }
        }
    }
    
    override func afterEndCountdown() {
        DispatchQueue.main.async {
            // 서버로 점수 업로드
            self.uploadResult(uploadScore: self.score)
        }
    }
    
    func setFrameWidth(_ width: CGFloat) {
        self.frameWidth = width
    }
    
    func spawnDuckkus() {
        let rand = Double.random(in: 0...1)
        
        if (self.duckNum < 4 && rand > 0.35) {
            self.duckNum += 1
            self.addDuckkuPair(1)
        } else if (rand > 0.65) {
            self.duckNum -= 1
            self.addDuckkuPair(1)
        }
    }
    
    func addDuckkuPair(_ num: Int) {
        let newDuckku = CupidEntity(id: self.id, frameMax: self.frameWidth)
        self.id += 1
        self.duckkuList.append(newDuckku)
    }
    
    func updateEntityPos() {
        for i in self.duckkuList.indices {
            duckkuList[i].updatePosition()
            
            if duckkuList[i].posBlack < -8 {
                self.stopButtonTapped()
            }
        }
        
        duckkuList.removeAll { $0.died }
    }
    
    func stopButtonTapped() {
        if let minIdIndex = self.duckkuList.firstIndex(where: { !$0.died && $0.id == duckkuList.filter { !$0.died}.min(by: { $0.id < $1.id})?.id }) {
            let minDuckku = self.duckkuList[minIdIndex]
            let minId = minDuckku.id
            
            print("\(minId), distance: \(minDuckku.posBlack)")
            
            // perfect
            if -4 < minDuckku.posBlack && minDuckku.posBlack < 4 {
                DispatchQueue.main.async {
                    self.score += 5
                }
                soundManager.playSound(sound: .cupidGoodOrPerfect)
                openResultTitle(.perfect)
            }
            
            // good
            else if -8 < minDuckku.posBlack && minDuckku.posBlack < 8 {
                DispatchQueue.main.async {
                    self.score += 2
                }
                soundManager.playSound(sound: .cupidGoodOrPerfect)
                openResultTitle(.good)
            }
            
            // bad
            else {
                soundManager.playSound(sound: .cupidBad)
                openResultTitle(.bad)
            }
            
            print(minDuckku)
            self.duckkuList[minIdIndex].setDied()
            print(minDuckku)
        }
    }
    
    private func openResultTitle(_ type: CupidResultType) {
        if type == .perfect {
            DispatchQueue.main.async {
                self.resultType = .perfect
                withAnimation(.spring) {
                    self.isResultTitleShowing = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    withAnimation(.spring) {
                        self.isResultTitleShowing = false
                    }
                }
            }
        }
        else if type == .good {
            DispatchQueue.main.async {
                self.resultType = .good
                withAnimation(.spring) {
                    self.isResultTitleShowing = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    withAnimation(.spring) {
                        self.isResultTitleShowing = false
                    }
                }
            }
        }
        else if type == .bad {
            DispatchQueue.main.async {
                self.resultType = .bad
                withAnimation(.spring) {
                    self.isResultTitleShowing = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    withAnimation(.spring) {
                        self.isResultTitleShowing = false
                    }
                }
            }
        }
    }
}

enum CupidResultType {
    case perfect
    case good
    case bad
}
