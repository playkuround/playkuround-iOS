//
//  CountdownView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/30/24.
//

import SwiftUI

struct CountdownView: View {
    // GameViewModel에서 카운트다운 숫자를 넘겨줌
    @Binding var countdown: Int
    let countdownImages: [ImageResource] = [.countdown1, .countdown2, .countdown3]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.66).ignoresSafeArea()
            
            Image(countdownImages[countdown - 1])
        }
    }
}

#Preview {
    CountdownView(countdown: .constant(3))
}
