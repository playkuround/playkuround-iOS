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
    
    private var flippedCardIndex: [Int] = []
    private var correctCount: Int = 0
    
    override func startGame() {
        super.startGame()
        super.startTimer()
    }
    
    override func timerDone() {
        finishGame()
    }
    
    override func finishGame() {
        gameState = .finish
        
        // 최종 점수 계산
        // 맞춘 카드 쌍 * 5점, 시간 * 2
        score = correctCount * 5 / 2
        score += Int(timeRemaining) * 2
        
        print("final score: \(score)")
    
        // 서버로 점수 업로드
        uploadResult()
    }
    
    func shuffleCard() {
        cardList.shuffle()
    }
    
    func coverToDrawing(index: Int) {
        if flippedCardIndex.count < 2 && cardList[index].cardState == .cover {
            flippedCardIndex.append(index)
            cardList[index].cardState = .side
            // 카드 옆면에서 0.15초 대기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.cardList[index].cardState = .drawing
                self.checkCard()
            }
        }
    }
    
    private func drawingToCover(index: Int) {
        if cardList[index].cardState == .drawing {
            cardList[index].cardState = .side
            // 카드 옆면에서 0.15초 대기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.cardList[index].cardState = .cover
            }
        }
    }
    
    // 카드 숨기는 함수
    private func hideCard(index: Int) {
        withAnimation(.linear(duration: 0.7)) {
            cardList[index].cardState = .hidden
        }
        correctCount += 1
        
        if correctCount == 16 {
            super.pauseOrRestartTimer()
            super.finishGame()
        }
    }
    
    // 뒤집은 카드 검사
    private func checkCard() {
        if flippedCardIndex.count == 2 {
            let index1 = flippedCardIndex[0]
            let index2 = flippedCardIndex[1]
            
            // 뒤집은 두 카드가 같은 경우
            if cardList[index1].cardType == cardList[index2].cardType {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.flippedCardIndex.removeAll()
                    self.hideCard(index: index1)
                    self.hideCard(index: index2)
                }
            } 
            // 다른 경우
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.flippedCardIndex.removeAll()
                    self.drawingToCover(index: index1)
                    self.drawingToCover(index: index2)
                }
            }
        }
    }
    
    @ViewBuilder
    func cardView(for cardComponent: CardComponent) -> some View {
        VStack {
            switch cardComponent.cardState {
            case .cover:
                Image("frontCard")
            case .side:
                Image("sideCard")
            case .drawing:
                Image(cardComponent.cardType.rawValue)
            case .hidden:
                Spacer()
            }
        }
        .frame(width: 66, height: 98)
    }
}
