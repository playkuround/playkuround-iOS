//
//  TimerGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/29/24.
//

import SwiftUI

struct TimerGameView: View {
    @State private var isPaused: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.kuLightYellow.ignoresSafeArea()
            
            Image(.timeBackground)
                .resizable()
                .scaledToFit()
            
            VStack {
                Text("00:00")
                    .font(.neo70)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
                
                Text(StringLiterals.Game.Time.success)
                    .font(.pretendard15R)
                    .foregroundStyle(.kuGreen)
                
                // if success {
                //     Image(.timeSuccessIcon)
                // } else {
                Image(.timeStopButton)
                    .padding(.top, 20)
                
                Spacer()
                    .frame(height: 150)
            }
            
            Spacer()
                .customNavigationBar(
                    centerView: {
                        Text(StringLiterals.Game.Time.title)
                            .font(.neo22)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    },
                    rightView: {
                        Image(.bluePauseButton)
                            .onTapGesture {
                                // TODO: 일시정지
                            }
                    },
                    height: 67)
        }
    }
}

#Preview {
    TimerGameView()
}
