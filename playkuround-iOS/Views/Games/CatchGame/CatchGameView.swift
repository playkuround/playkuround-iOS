//
//  CatchGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/23/24.
//

import SwiftUI

struct CatchGameView: View {
    @ObservedObject var viewModel: CatchGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Color.kuSky.ignoresSafeArea()
                
                Image(.catchClearBackgroundBottom)
                    .resizable()
                    .frame(width: geometry.size.width)
                    .scaledToFit()
                
                Image(.catchClearBackgroundTop)
                    .resizable()
                    .frame(width: geometry.size.width)
                    .scaledToFit()
                    .offset(y: -466)
                
                VStack {
                    ForEach(0..<4) { rowIndex in
                        HStack(spacing: 0) {
                            windowView(for: WindowComponent(windowState: .dummyLeft))
                            Spacer()
                            
                            ForEach(0..<4) { columnIndex in
                                let index = rowIndex * 4 + columnIndex
                                windowView(for: viewModel.windowList[index])
                                Spacer()
                            }
                            
                            windowView(for: WindowComponent(windowState: .dummyRight))
                        }
                        Spacer()
                    }
                    
                    HStack(spacing: 0) {
                        windowView(for: WindowComponent(windowState: .dummyLeftBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyBottom))
                        Spacer()
                        windowView(for: WindowComponent(windowState: .dummyRightBottom))
                    }
                }
                .frame(height: 468)
                
                VStack {
                    TimerBarView(progress: $viewModel.progress, color: .black)
                    
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
                    }
                    .padding(.horizontal, 26)
                }
                .customNavigationBar(centerView: {
                    Text(StringLiterals.Game.Catch.title)
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.kuText)
                }, rightView: {
                    Button(action: {
                        viewModel.togglePauseView()
                    }, label: {
                        Image(.beigePauseButton)
                    })
                }, height: 30)
                
                if viewModel.isCountdownViewPresented {
                    CountdownView(countdown: $viewModel.countdown)
                } else if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                } else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    @ViewBuilder
    func windowView(for window: WindowComponent) -> some View {
        ZStack {
            switch window.windowState {
            case .close:
                Image(.closedWindow)
            case .half:
                switch window.windowType {
                case .catchDuckkuWhite:
                    Image(.halfWindowWhite)
                case .catchDuckkuWhiteHit:
                    Image(.halfWindowWhiteHit)
                case .catchDuckkuBlack:
                    Image(.halfWindowBlack)
                case .catchDuckkuBlackHit:
                    Image(.halfWindowBlackHit)
                case .none:
                    Text("")
                }
            case .open:
                switch window.windowType {
                case .catchDuckkuWhite:
                    Image(.openWindowWhite)
                case .catchDuckkuWhiteHit:
                    Image(.openWindowWhiteHit)
                case .catchDuckkuBlack:
                    Image(.openWindowBlack)
                case .catchDuckkuBlackHit:
                    Image(.openWindowBlackHit)
                case .none:
                    Text("")
                }
            case .dummyLeft:
                Image(.catchClippedWindowLeft)
            case .dummyRight:
                Image(.catchClippedWindowRight)
            case .dummyLeftBottom:
                Image(.catchClippedWindowLeftBottom)
            case .dummyRightBottom:
                Image(.catchClippedWindowRightBottom)
            case .dummyBottom:
                Image(.catchClippedWindowBottom)
            }
        }
    }
}

#Preview {
    CatchGameView(viewModel: CatchGameViewModel(.catchDucku, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 60.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
