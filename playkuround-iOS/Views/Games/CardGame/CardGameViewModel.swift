//
//  CardGameViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/2/24.
//

import Foundation
import SwiftUI

final class CardGameViewModel: GameViewModel {
    @Published var cardList: [CardComponent] = [CardComponent(cardType: .bullCard, cardState: .cover),
                                                CardComponent(cardType: .bullCard, cardState: .cover),
                                                CardComponent(cardType: .catCard, cardState: .cover),
                                                CardComponent(cardType: .catCard, cardState: .cover),
                                                CardComponent(cardType: .flowerCard, cardState: .cover),
                                                CardComponent(cardType: .flowerCard, cardState: .cover),
                                                CardComponent(cardType: .gooseCard, cardState: .cover),
                                                CardComponent(cardType: .gooseCard, cardState: .cover),
                                                CardComponent(cardType: .lakeCard, cardState: .cover),
                                                CardComponent(cardType: .lakeCard, cardState: .cover),
                                                CardComponent(cardType: .milkCard, cardState: .cover),
                                                CardComponent(cardType: .milkCard, cardState: .cover),
                                                CardComponent(cardType: .treeCard, cardState: .cover),
                                                CardComponent(cardType: .treeCard, cardState: .cover),
                                                CardComponent(cardType: .turtleCard, cardState: .cover),
                                                CardComponent(cardType: .turtleCard, cardState: .cover)]

    @Published var flippedCardIndex1: Int = -1
    @Published var flippedCardIndex2: Int = -1
    @Published var correctCount: Int = 0
    @Published var isFlipping: Bool = false
    private let lock = NSLock()
    
    let soundManager = SoundManager.shared
    
    override func startGame() {
        self.shuffleCard()
        
        super.startGame()
        super.startTimer()
    }
    
    override func timerDone() {
        self.finishGame()
    }
    
    override func finishGame() {
        if self.gameState != .finish {
            DispatchQueue.main.async {
                self.gameState = .finish
                
                // 최종 점수 계산
                // 맞춘 카드 쌍 * 5점, 시간 * 2
                self.score = self.correctCount * 5 / 2
                self.score += Int(self.timeRemaining) * 2
                
                self.isWaitingViewPresented = true
                self.countdown = 3
                
                self.startResultCountdownProgress()
            }
        }
    }
    
    override func afterEndCountdown() {
        DispatchQueue.main.async {
            // 서버로 점수 업로드
            print("score: \(self.score), time: \(self.timeRemaining), correctCount: \(self.correctCount)")
            super.uploadResult(uploadScore: self.score)
        }
    }
    
    func shuffleCard() {
        DispatchQueue.main.async {
            self.cardList.shuffle()
        }
    }
    
    func coverToDrawing(index: Int) {
        print("index: \(index), \(flippedCardIndex1), \(flippedCardIndex2)")
        
        DispatchQueue.main.async {
            self.lock.lock()
            
            if self.cardList[index].cardState == .cover && self.flippedCardIndex1 == -1 {
                self.flippedCardIndex1 = index
                self.isFlipping = true
                self.cardList[index].cardState = .side
                self.lock.unlock()
                
                // 카드 옆면에서 0.15초 대기
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    self.cardList[index].cardState = .drawing
                    self.isFlipping = false
                    self.checkCard()
                }
                self.soundManager.playSound(sound: .cardClicked)
            }
            else if self.cardList[index].cardState == .cover && self.flippedCardIndex2 == -1 {
                self.flippedCardIndex2 = index
                self.isFlipping = true
                self.cardList[index].cardState = .side
                self.lock.unlock()
                
                // 카드 옆면에서 0.15초 대기
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    self.cardList[index].cardState = .drawing
                    self.isFlipping = false
                    self.checkCard()
                }
                self.soundManager.playSound(sound: .cardClicked)
            }
            else {
                self.lock.unlock()
            }
        }
    }
    
    private func drawingToCover(index: Int) {
        DispatchQueue.main.async {
            self.lock.lock()
            if self.cardList[index].cardState == .drawing {
                self.cardList[index].cardState = .side
                // 카드 옆면에서 0.15초 대기
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    self.cardList[index].cardState = .cover
                    
                    if index == self.flippedCardIndex1 {
                        self.flippedCardIndex1 = -1
                    } else if index == self.flippedCardIndex2 {
                        self.flippedCardIndex2 = -1
                    }
                }
            }
            self.lock.unlock()
        }
    }
    
    // 카드 숨기는 함수
    private func hideCard(index: Int) {
        DispatchQueue.main.async {
            self.lock.lock()
            withAnimation(.linear(duration: 0.7)) {
                self.cardList[index].cardState = .hidden
            }
            self.correctCount += 1
            
            if index == self.flippedCardIndex1 {
                self.flippedCardIndex1 = -1
            } else if index == self.flippedCardIndex2 {
                self.flippedCardIndex2 = -1
            }
            
            if self.correctCount == 16 {
                self.soundManager.playSound(sound: .cardAllCorrect)
                super.pauseOrRestartTimer()
                self.finishGame()
            }
            self.lock.unlock()
        }
    }
    
    // 뒤집은 카드 검사
    private func checkCard() {
        DispatchQueue.main.async {
            self.lock.lock()
            if self.flippedCardIndex1 >= 0 && self.flippedCardIndex2 >= 0 {
                
                // 뒤집은 두 카드가 같은 경우
                if self.cardList[self.flippedCardIndex1].cardType == self.cardList[self.flippedCardIndex2].cardType {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.hideCard(index: self.flippedCardIndex1)
                        self.hideCard(index: self.flippedCardIndex2)
                        self.soundManager.playSound(sound: .cardCorrect)
                    }
                }
                // 다른 경우
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.drawingToCover(index: self.flippedCardIndex1)
                        self.drawingToCover(index: self.flippedCardIndex2)
                        self.soundManager.playSound(sound: .cardIncorrect)
                    }
                }
            }
            self.lock.unlock()
        }
    }
}
