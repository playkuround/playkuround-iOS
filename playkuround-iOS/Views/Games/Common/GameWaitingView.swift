//
//  GameWaitingView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/30/24.
//

import SwiftUI

struct GameWaitingView: View {
    let viewType: GameWaitingViewType
    @Binding var second: Int
    
    init(_ viewType: GameWaitingViewType = .gameEnd, second: Binding<Int>) {
        self.viewType = viewType
        self._second = second // binding
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack {
                Spacer()
                
                let text = viewType == .gameEnd
                ? "\(second)" + NSLocalizedString("Game.Result.Waiting", comment: "")
                : String(format: NSLocalizedString("Game.Quiz.Waiting", comment: ""), second)
                
                Text(text)
                    .font(.neo18)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
                    .padding(.bottom, 80)
            }
        }
    }
    
    enum GameWaitingViewType {
        case quiz
        case gameEnd
    }
}

#Preview {
    GameWaitingView(second: .constant(3))
}

#Preview {
    GameWaitingView(.quiz, second: .constant(3))
}
