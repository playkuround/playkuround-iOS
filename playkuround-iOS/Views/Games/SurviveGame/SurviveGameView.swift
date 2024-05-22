//
//  SurviveGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/22/24.
//

import SwiftUI

struct SurviveGameView: View {
    @ObservedObject var viewModel: SurviveGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    var body: some View {
        ZStack {
            Image(.surviveBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                TimerBarView(progress: .constant(1), color: .black)
                
                HStack {
                    Text(StringLiterals.Game.scoreTitle)
                        .font(.neo22)
                        .foregroundStyle(.kuText)
                        .kerning(-0.41)
                    
                    Spacer()
                        .frame(width: 16)
                    
                    Text("\(viewModel.score)")
                        .font(.neo22)
                        .foregroundStyle(.kuText)
                        .kerning(-0.41)
                    
                    Spacer()
                    
                    HStack(spacing: 2) {
                        Image(.surviveHeart)
                        Image(.surviveHeart)
                        Image(.surviveHeart)
                    }
                }
                .padding(.horizontal, 26)
                
                // Main Frame
                GeometryReader { geometry in
                    HStack {
                        Spacer()
                        
                        VStack {
                            Spacer()
                        }
                    }
                    .onAppear {
                        print("Survive Game Size: \(geometry.size.width), \(geometry.size.height)")
                        viewModel.setFrameXY(x: geometry.size.width, y: geometry.size.height)
                    }
                    .overlay {
                        Image(.surviveDuckku)
                            // TODO: View Model의 pos값과 연결
                            // .offset(x: viewModel.duckkuPosX, y: viewModel.duckkuPosY)
                        
                        SurviveGameEntityView(type: .boat)
                            .offset(x: 0, y: 90)
                        SurviveGameEntityView(type: .bug)
                            .offset(x: 0, y: 180)
                    }
                }
            }
            .customNavigationBar(centerView: {
                Text(StringLiterals.Game.Survive.title)
                    .font(.neo22)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
            }, rightView: {
                Button(action: {
                    viewModel.togglePauseView()
                }, label: {
                    Image(.beigePauseButton)
                })
            }, height: 67)
            
            if viewModel.isCountdownViewPresented {
                CountdownView(countdown: $viewModel.countdown)
            } else if viewModel.isPauseViewPresented {
                GamePauseView(viewModel: viewModel)
            } else if viewModel.isResultViewPresented {
                GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
            }
        }
    }
}

#Preview {
    SurviveGameView(viewModel: SurviveGameViewModel(.survive, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 60.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
