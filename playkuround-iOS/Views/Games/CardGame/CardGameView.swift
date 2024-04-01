//
//  CardGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/1/24.
//

import SwiftUI

struct CardGameView: View {
    // 아래 두 변수는 임시 구현으로, GameViewModel에서 받아올 예정
    @State private var progress: Double = 1.0
    @State private var cardList: [CardType] = [.milkCard, .turtleCard, .treeCard, .bullCard,
        .lakeCard, .gooseCard, .catCard, .flowerCard]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(.cardBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                // 뷰의 사이즈에 따라 Image의 padding값 조절
                let shouldImagePadding = geometry.size.height >= 700
                
                VStack {
                    TimerBarView(progress: $progress, color: .white)
                        .padding(.bottom, shouldImagePadding ? 44 : 20)
                    
                    // MARK: 아래는 UI 구현을 위한 임시 구현
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                        ForEach(cardList, id: \.self) { cardType in
                            CardView(cardType: cardType, cardState: .constant(.drawing))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                        ForEach(cardList, id: \.self) { cardType in
                            CardView(cardType: cardType, cardState: .constant(.drawing))
                        }
                    }
                    .padding(.horizontal)
                }
                .customNavigationBar(centerView: {
                    Text(StringLiterals.Game.Card.title)
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                }, rightView: {
                    Button(action: {
                        // TODO: 일시정지
                    }, label: {
                        Image(.bronzePauseButton)
                    })
                }, height: 67)
            }
        }
    }
}

struct CardView: View {
    let cardType: CardType
    @Binding var cardState: CardState
    
    var body: some View {
        VStack {
            switch cardState {
            case .cover:
                Image(.frontCard)
            case .side:
                Image(.sideCard)
            case .drawing:
                Image(cardType.rawValue)
            case .hidden:
                Spacer()
            }
        }
        .frame(width: 66, height: 98)
    }
}

enum CardState {
    case cover
    case side
    case drawing
    case hidden
}

enum CardType: String {
    case milkCard
    case turtleCard
    case treeCard
    case bullCard
    case lakeCard
    case gooseCard
    case catCard
    case flowerCard
}

#Preview {
    CardGameView()
}

#Preview {
    VStack {
        CardView(cardType: .milkCard, cardState: .constant(.drawing))
        CardView(cardType: .milkCard, cardState: .constant(.side))
        CardView(cardType: .milkCard, cardState: .constant(.cover))
        CardView(cardType: .milkCard, cardState: .constant(.hidden))
            .border(.gray)
    }
}
