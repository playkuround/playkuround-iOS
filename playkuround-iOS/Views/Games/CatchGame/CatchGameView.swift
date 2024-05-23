//
//  CatchGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/23/24.
//

import SwiftUI

struct CatchGameView: View {
    @State private var windowList: [WindowComponent] = [WindowComponent(windowState: .half, windowType: .catchDuckkuWhite),
                                                        WindowComponent(windowState: .half, windowType: .catchDuckkuWhiteHit),
                                                        WindowComponent(windowState: .half, windowType: .catchDuckkuBlack),
                                                        WindowComponent(windowState: .half, windowType: .catchDuckkuBlackHit),
                                                        WindowComponent(windowState: .open, windowType: .catchDuckkuWhite),
                                                        WindowComponent(windowState: .open, windowType: .catchDuckkuWhiteHit),
                                                        WindowComponent(windowState: .open, windowType: .catchDuckkuBlack),
                                                        WindowComponent(windowState: .open, windowType: .catchDuckkuBlackHit),
                                                        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
                                                        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .top) {
                VStack (alignment: .center, spacing: 0) {
                    Spacer()
                    
                    ZStack {
                        Image(.catchBackgroundTop)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .padding(0)
                    }
                    .border(.red)
                    
                    ZStack {
                        Image(.catchBackgroundMiddle)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .padding(0)
                    }
                    .border(.orange)
                    .overlay {
                        VStack {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 6) {
                                ForEach(windowList.indices, id: \.self) { index in
                                    windowView(for: windowList[index])
                                        .onTapGesture {
                                            
                                        }
                                }
                            }
                            .border(.red)
                            .padding(.horizontal, 32)
                            // .padding(.top, 3)
                        }
                    }
                    .border(.blue)
                    
                    ZStack {
                        Image(.catchBackgroundBottom)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .padding(0)
                    }
                    .border(.brown)
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .padding(0)
                .ignoresSafeArea()
                .offset(y: -130)
                
                VStack {
                    Text("")
                        .customNavigationBar(centerView: {
                            Text(StringLiterals.Game.Catch.title)
                                .font(.neo22)
                                .kerning(-0.41)
                                .foregroundStyle(.kuText)
                        }, rightView: {
                            Button(action: {
                                // TODO: Pause Button
                            }, label: {
                                Image(.beigePauseButton)
                            })
                        }, height: 30)
                        .overlay {
                            VStack {
                                TimerBarView(progress: .constant(1), color: .black)
                                
                                HStack {
                                    Text(StringLiterals.Game.scoreTitle)
                                        .font(.neo22)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                    
                                    Spacer()
                                        .frame(width: 16)
                                    
                                    Text("\(0)")
                                        .font(.neo22)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 26)
                                
                                Spacer()
                            }
                            .offset(y: 36)
                        }
                }
            }
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
            case .dummyLeft, .dummyRight, .dummyLeftBottom, .dummyRightBottom, .dummyBottom:
                Text("")
            }
        }
        .frame(width: 72, height: 94)
    }
}

//#Preview {
//    CatchGameView()
//}

struct CatchGameView2: View {
    @ObservedObject var viewModel: CatchGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    @State private var windowList: [WindowComponent] = [
        WindowComponent(windowState: .dummyLeft, windowType: nil),
        WindowComponent(windowState: .half, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .half, windowType: .catchDuckkuWhiteHit),
        WindowComponent(windowState: .half, windowType: .catchDuckkuBlack),
        WindowComponent(windowState: .half, windowType: .catchDuckkuBlackHit),
        WindowComponent(windowState: .dummyRight, windowType: nil),
        
        WindowComponent(windowState: .dummyLeft, windowType: nil),
        WindowComponent(windowState: .open, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .open, windowType: .catchDuckkuWhiteHit),
        WindowComponent(windowState: .open, windowType: .catchDuckkuBlack),
        WindowComponent(windowState: .open, windowType: .catchDuckkuBlackHit),
        WindowComponent(windowState: .dummyRight, windowType: nil),
        
        WindowComponent(windowState: .dummyLeft, windowType: nil),
        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .dummyRight, windowType: nil),
        
        WindowComponent(windowState: .dummyLeft, windowType: nil),
        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .close, windowType: .catchDuckkuWhite),
        WindowComponent(windowState: .dummyRight, windowType: nil),
        
        WindowComponent(windowState: .dummyLeftBottom, windowType: nil),
        WindowComponent(windowState: .dummyBottom, windowType: nil),
        WindowComponent(windowState: .dummyBottom, windowType: nil),
        WindowComponent(windowState: .dummyBottom, windowType: nil),
        WindowComponent(windowState: .dummyBottom, windowType: nil),
        WindowComponent(windowState: .dummyRightBottom, windowType: nil),
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Color.kuSky
            
            GeometryReader { geometry2 in
                VStack(alignment: .center, spacing: 0) {
                    Image(.catchClearBackgroundTop)
                        .resizable()
                        // .scaledToFit()
                        .frame(width: geometry2.size.width)
                    
                    GeometryReader { geometry in
                        Image(.catchClearBackgroundBottom)
                            .resizable()
                            // .scaledToFit()
                            .frame(width: geometry2.size.width)
                            .border(.red)
                            .overlay {
                                VStack(spacing: 0) {
                                    ForEach(0..<5) { rowIndex in
                                        HStack(spacing: 0) {
                                            ForEach(0..<6) { columnIndex in
                                                let index = rowIndex * 6 + columnIndex
                                                windowView(for: windowList[index])
                                                
                                                if (columnIndex < 5) {
                                                    Spacer()
                                                }
                                            }
                                        }
                                        if (rowIndex < 4) {
                                            Spacer()
                                        }
                                    }
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .border(.green)
                            }
                            
                    }
                }
                .offset(y: -100)
                .ignoresSafeArea(.all)
                .frame(width: geometry2.size.width, height: geometry2.size.height, alignment: .bottom)
                .border(.pink)
            }
            
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
        // .frame(width: 72, height: 94)
    }
}

//#Preview {
//    CatchGameView2(viewModel: CatchGameViewModel(.catchDucku, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 60.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
//}

struct CatchGameView3: View {
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
    CatchGameView3(viewModel: CatchGameViewModel(.catchDucku, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 60.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
