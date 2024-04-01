//
//  Card.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/1/24.
//

// 카드 상태
enum CardState {
    case cover
    case side
    case drawing
    case hidden
}

// 카드 종류
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
