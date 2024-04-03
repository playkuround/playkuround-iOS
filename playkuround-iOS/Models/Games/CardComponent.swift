//
//  CardComponent.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/3/24.
//

import Foundation

struct CardComponent: Identifiable, Hashable {
    var id = UUID()
    let cardType: CardType
    var cardState: CardState
}
