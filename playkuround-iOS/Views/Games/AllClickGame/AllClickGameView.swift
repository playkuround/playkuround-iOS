//
//  AllClickGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/27/24.
//

import SwiftUI
import Combine

struct AllClickGameView: View {
    @ObservedObject var viewModel: AllClickGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    @State private var userText: String = ""
    @State private var userHeight: CGFloat = 0
    @State private var shouldBecomeFirstResponder: Bool = false
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    Image(.allClickBackground)
                        .resizable()
                        .ignoresSafeArea(edges: .all)
                    
                    Image(.allClickDuckku)
                        .offset(y: -20)
                }
                .ignoresSafeArea(.keyboard)
                
                let shouldFontResize = geometry.size.width <= 375
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(StringLiterals.Game.AllClick.score)
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.trailing, 12)
                        
                        Text("\(viewModel.score)")
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                        
                        Spacer()
                        
                        HStack(spacing: 3){
                            Image(viewModel.life > 0 ? .allClickHeart : .allClickHeartEmpty)
                            Image(viewModel.life > 1 ? .allClickHeart : .allClickHeartEmpty)
                            Image(viewModel.life > 2 ? .allClickHeart : .allClickHeartEmpty)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Spacer()
                        
                        Text(StringLiterals.Game.AllClick.classRegistration)
                            .font(shouldFontResize ? .neo17 : .neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.allClickGreen)
                        
                        Spacer()
                        
                        Image(.allClickWritingBox)
                            .overlay(alignment: .leading) {
                                AllClickCustomTextView(text: $userText,
                                                       height: $userHeight,
                                                       shouldBecomeFirstResponder: $shouldBecomeFirstResponder)
                                .frame(height: 30, alignment: .center)
                                .frame(width: 200)
                                .padding(.leading, 8)
                            }
                        
                        Spacer()
                        
                        Image(.allClickRegister)
                            .overlay {
                                Text(StringLiterals.Game.AllClick.register)
                                    .font(.neo18)
                                    .kerning(-0.41)
                                    .foregroundStyle(.white)
                            }
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .background(.white)
                    .offset(y: 8)
                }
                .customNavigationBar(centerView: {
                    Text(StringLiterals.Game.AllClick.title)
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.kuText)
                }, rightView: {
                    Button(action: {
                        viewModel.togglePauseView()
                    }, label: {
                        Image(.brownPauseButton)
                    })
                }, height: 57)
                
                ForEach(viewModel.subjects.indices, id: \.self) { index in
                    AllClickTextRainView(subject: viewModel.subjects[index])
                        .position(x: viewModel.subjects[index].xPosition,
                                  y: viewModel.subjects[index].yPosition)
                }
                
                if viewModel.isCountdownViewPresented {
                    CountdownView(countdown: $viewModel.countdown)
                } else if viewModel.isPauseViewPresented {
                    GamePauseView(viewModel: viewModel)
                        .onAppear {
                            viewModel.stopSubjectRain()
                            shouldBecomeFirstResponder = false
                        }
                        .onDisappear {
                            viewModel.startSubjectRain()
                            shouldBecomeFirstResponder = true
                        }
                } else if viewModel.isResultViewPresented {
                    GameResultView(rootViewModel: rootViewModel, gameViewModel: viewModel)
                        .onAppear {
                            viewModel.stopSubjectRain()
                            shouldBecomeFirstResponder = false
                        }
                }
            }
            .onAppear {
                viewModel.startCountdown()
            }
            .onChange(of: viewModel.countdownCompleted) { completed in
                if completed {
                    shouldBecomeFirstResponder = true
                }
            }
            .onChange(of: userText) { newText in
                if let index = viewModel.subjects.firstIndex(where: { $0.title == newText }) {
                    viewModel.calculateScore(index: index)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        viewModel.subjects.remove(at: index)
                        soundManager.playSound(sound: .classCorrect)
                        userText = ""
                    }
                }
            }
        }
    }
}

#Preview {
    AllClickGameView(viewModel: AllClickGameViewModel(.allClear, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
