//
//  CardGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/1/24.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var viewModel: CardGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(.cardBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                // 뷰의 사이즈에 따라 Image의 padding값 조절
                let shouldImagePadding = geometry.size.height >= 700
                
                VStack {
                    TimerBarView(progress: $viewModel.progress, color: .white)
                        .padding(.bottom, shouldImagePadding ? 44 : 20)
                        .onReceive(viewModel.timer) { _ in
                            viewModel.updateTimer()
                        }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                        ForEach(viewModel.cardList.indices, id: \.self) { index in
                            viewModel.cardView(for: viewModel.cardList[index])
                                .onTapGesture {
                                    if viewModel.cardList[index].cardState == .cover {
                                        viewModel.coverToDrawing(index: index)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .customNavigationBar(centerView: {
                    Text(StringLiterals.Game.Card.title)
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                }, rightView: {
                    Button(action: {
                        viewModel.soundManager.playSound(sound: .buttonClicked)
                        viewModel.togglePauseView()
                    }, label: {
                        Image(.bronzePauseButton)
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
                viewModel.startCountdown()
                GAManager.shared.logScreenEvent(.CardGame)
            }
        }
    }
}

#Preview {
    CardGameView(viewModel: CardGameViewModel(.book, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
