//
//  CardView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/1/24.
//

import SwiftUI

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
