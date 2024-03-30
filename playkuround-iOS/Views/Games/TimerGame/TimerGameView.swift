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
        ZStack(alignment: .top) {
            Color.kuLightYellowBackground.ignoresSafeArea()
            
            GeometryReader { geometry in
                
                VStack {
                    Spacer()
                    
                    Text(StringLiterals.Game.Time.description)
                        .font(.pretendard15R)
                        .foregroundStyle(.kuText)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width)
                .frame(height: geometry.size.height > 700 ? 90 : 60)
                .customNavigationBar(
                    centerView: {
                        Text(StringLiterals.Game.Time.title)
                            .font(.neo22)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    },
                    rightView: {
                        Button {
                            // TODO: 일시정지
                        } label: {
                            Image(.bluePauseButton)
                        }
                        
                    },
                    height: 67)
                .ignoresSafeArea(edges: .bottom)
                .overlay {
                    Image(.timeBackground)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .offset(y: 100)
                        .overlay {
                            VStack {
                                Text("00:00")
                                    .font(.neo70)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuText)
                                
                                Text(StringLiterals.Game.Time.success)
                                    .font(.pretendard15R)
                                    .foregroundStyle(.kuGreen)
                                
                                Button {
                                    
                                } label: {
                                    Image(.timeStopButton)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 120)
                                        .padding(.top, 20)
                                }
                                
                                // 성공 시
                                /* AnimationCustomView(
                                    imageArray: gameSuccessImage.allCases.map { $0.rawValue },
                                    delayTime: 0.2)
                                .scaledToFit()
                                .frame(height: 140) */
                            }
                            .offset(y: 110)
                        }
                }
            }
        }
    }
}

#Preview {
    TimerGameView()
}
