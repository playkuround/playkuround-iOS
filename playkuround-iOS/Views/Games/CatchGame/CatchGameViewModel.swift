//
//  CatchGameViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/23/24.
//

import Foundation

final class CatchGameViewModel: GameViewModel {
    @Published var windowList: [WindowComponent] = [WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                    WindowComponent(windowState: .close, windowType: .catchDuckkuWhite)]
    
    let soundManager = SoundManager.shared
    
    override func startGame() {
        super.startGame()
        super.startTimer()
        
        step(whiteNum: 1, blackNum: 2)
    }
    
    override func timerDone() {
        finishGame()
    }
    
    override func finishGame() {
        if gameState != .finish {
            DispatchQueue.main.async {
                self.gameState = .finish
                super.pauseOrRestartTimer()
                self.isTimerUpdating = false
                
                self.isWaitingViewPresented = true
                self.countdown = 3
                
                self.startResultCountdownProgress()
            }
        }
    }
    
    override func afterEndCountdown() {
        DispatchQueue.main.async {
            // 서버로 점수 업로드
            super.uploadResult(uploadScore: self.score)
        }
    }
    
    func step(whiteNum: Int, blackNum: Int) {
        print("open \(whiteNum) white windows, \(blackNum) black windows")
        
        // open할 창문 white n개, black n개 지정 n * 2개 랜덤 뽑음
        let toOpenIndexList: [Int] = getRandomNums(whiteNum + blackNum)
        
        for i in toOpenIndexList.indices {
            let ridx = toOpenIndexList[i]
            
            // white
            if i < whiteNum {
                DispatchQueue.main.async {
                    self.windowList[ridx].windowType = .catchDuckkuWhite
                }
            }
            // black
            else {
                DispatchQueue.main.async {
                    self.windowList[ridx].windowType = .catchDuckkuBlack
                }
            }
        }
        
        for i in toOpenIndexList {
            self.openWindow(index: i)
        }
    }
    
    func checkWindow(index: Int) {
        if windowList[index].windowState == .open {
            // black
            if windowList[index].windowType == .catchDuckkuBlack {
                if self.score > 0 {
                    self.score -= 1
                }
                soundManager.playSound(sound: .blackDuckkuClicked)
                windowList[index].windowType = .catchDuckkuBlackHit
                closeWindow(index: index)
            }
            
            // white
            else if windowList[index].windowType == .catchDuckkuWhite {
                self.score += 1
                soundManager.playSound(sound: .duckkuClicked)
                windowList[index].windowType = .catchDuckkuWhiteHit
                closeWindow(index: index)
            }
        }
    }
    
    func openWindow(index: Int) {
        if windowList[index].windowState == .close {
            windowList[index].windowState = .half
            // 반 열린 상태로 0.15초 대기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.windowList[index].windowState = .open
                self.soundManager.playSound(sound: .duckkuWindowOpenAndClose)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.65) {
                self.closeWindow(index: index)
                self.soundManager.playSound(sound: .duckkuWindowOpenAndClose)
            }
        }
    }
    
    func closeWindow(index: Int) {
        if windowList[index].windowState == .open {
            windowList[index].windowState = .half
            // 반 열린 상태로 0.15초 대기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.windowList[index].windowState = .close
                self.soundManager.playSound(sound: .duckkuWindowOpenAndClose)
            }
        }
    }
    
    func getRandomNums(_ num: Int) -> [Int] {
        if num > 16 {
            return Array(0..<16).shuffled()
        }
        
        var numbers = Array(0..<16)
        numbers.shuffle()
        
        return Array(numbers.prefix(num))
    }
}
