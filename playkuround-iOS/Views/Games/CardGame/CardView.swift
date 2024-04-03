//
//  CardView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/1/24.
//

import SwiftUI

struct CardView: View {
    @Binding var cardComponent: CardComponent
    
    var body: some View {
        VStack {
            switch cardComponent.cardState {
            case .cover:
                Image(.frontCard)
            case .side:
                Image(.sideCard)
            case .drawing:
                Image(cardComponent.cardType.rawValue)
            case .hidden:
                Spacer()
            }
        }
        .frame(width: 66, height: 98)
    }
}
