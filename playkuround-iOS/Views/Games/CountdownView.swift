//
//  CountdownView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/30/24.
//

import SwiftUI

struct CountdownView: View {
    // GameViewModel에서 카운트다운 숫자를 넘겨줌 (3초 ~ 1초)
    @State var countdown: Int
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.66).ignoresSafeArea()
            
            Image(countdownImage.allCases.map { $0.rawValue }[countdown - 1])
        }
    }
}

#Preview {
    CountdownView(countdown: 3)
}
