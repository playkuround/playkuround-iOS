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
            Color.kuLightYellowBackground.ignoresSafeArea()
            
            Image(.timeBackground)
                .resizable()
                .scaledToFit()
                .padding(.bottom, -20)
            
            VStack {
                Text(StringLiterals.Game.Time.description)
                    .font(.pretendard15R)
                    .foregroundStyle(.kuText)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.top, 80)
            
            VStack {
                Text("00:00")
                    .font(.neo70)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
                
                Text(StringLiterals.Game.Time.success)
                    .font(.pretendard15R)
                    .foregroundStyle(.kuGreen)
                
//                Image(.timeStopButton)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 120, height: 120)
//                    .padding(.top, 20)
                
                AnimationCustomView(
                    imageArray: gameSuccessImage.allCases.map { $0.rawValue },
                    delayTime: 0.2)
                .scaledToFit()
                .frame(height: 140)
                
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
