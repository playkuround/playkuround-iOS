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
                TimerBarView(progress: $viewModel.progress, color: .black)
                    .onReceive(viewModel.timer) { _ in
                        viewModel.updateTimer()
                        
                        // update score 1초마다 호출
                        if viewModel.isTimerUpdating {
                            if Int(viewModel.timeRemaining * 100) % 100 == 0 {
                                viewModel.updateScore()
                            }
                            
                            // update bug num 10초마다 호출
                            if Int(viewModel.timeRemaining * 100) % 1000 == 0 {
                                viewModel.updateNumBug()
                            }
                            
                            // update entity position
                            if Int(viewModel.timeRemaining * 100) % 4 == 0 {
                                viewModel.updateEntityPos()
                            }
                            
                            // 3초마다 add Bug
                            if Int(viewModel.timeRemaining * 100) % 300 == 0 {
                                viewModel.addBug(viewModel.numBug)
                            }
                            
                            // 5초마다 add Boat
                            if Int(viewModel.timeRemaining * 100) % 500 == 0 {
                                viewModel.addBoat(Int(viewModel.numBug / 4))
                            }
                        }
                    }
                
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
                        Image(viewModel.life > 0 ? .surviveHeart : .surviveHeartBroken)
                        Image(viewModel.life > 1 ? .surviveHeart : .surviveHeartBroken)
                        Image(viewModel.life > 2 ? .surviveHeart : .surviveHeartBroken)
                    }
                }
                .padding(.horizontal, 26)
                
                // Main Frame
                GeometryReader { geometry in
                    VStack{
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
                            ForEach(viewModel.bugList, id: \.self) { bug in
                                entityView(type: .bug, angle: bug.angle)
                                    .border(.green)
                                    .offset(x: bug.posX, y: bug.posY)
                            }
                            
                            ForEach(viewModel.boatList, id: \.self) { boat in
                                entityView(type: .boat, angle: boat.angle)
                                    .border(.blue)
                                    .rotationEffect(boat.angle)
                                    .border(.orange)
                                    .offset(x: boat.posX, y: boat.posY)
                            }
                            
                            Image(viewModel.isTransparent ? .surviveDuckkuHit : .surviveDuckku)
                                .border(.red)
                                .offset(x: viewModel.duckkuPosX, y: viewModel.duckkuPosY)
                        }
                    }
                    .clipped()
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
        .onAppear {
            // 카운트다운 시작
            viewModel.startCountdown()
        }
    }
    
    @ViewBuilder
    func entityView(type: SurviveGameEntityType, angle: Angle) -> some View {
        switch type {
        case .boat:
            Image(.surviveBoat)
        case .bug:
            Image(.surviveBug)
        }
    }
}

#Preview {
    SurviveGameView(viewModel: SurviveGameViewModel(rootViewModel: RootViewModel(), mapViewModel: MapViewModel()), rootViewModel: RootViewModel())
}
