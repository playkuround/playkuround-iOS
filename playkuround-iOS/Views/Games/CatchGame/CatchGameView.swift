//
//  CatchGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/30/24.
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
                    ZStack {
                        Image(.catchBackgroundUp)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding(0)
                    }
                    
                    ZStack {
                        Image(.catchBackgroundDown)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .padding(0)
                    }
                    .overlay {
                        VStack {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 12) {
                                ForEach(windowList.indices, id: \.self) { index in
                                    windowView(for: windowList[index])
                                        .onTapGesture {
                                            
                                        }
                                }
                            }
                            .border(.red)
                            .padding(.horizontal, 32)
                            .padding(.top, 3)
                            
                            Spacer()
                        }
                    }
                    .border(.blue)
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
                }
            }
        }
        .frame(width: 72, height: 94)
    }
}

#Preview {
    CatchGameView()
}
