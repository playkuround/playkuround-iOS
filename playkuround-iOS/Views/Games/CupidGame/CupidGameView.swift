//
//  CupidGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/26/24.
//

import SwiftUI

struct CupidGameView: View {
    @ObservedObject var viewModel: CupidGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.cupidBackGround)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                let shouldImagePadding = geometry.size.height >= 700
                
                /// 타임바
                TimerBarView(progress: $viewModel.progress, color: .black)
                    .padding(.bottom, shouldImagePadding ? 580 : 490)
                    .onReceive(viewModel.timer) { _ in
                        viewModel.updateTimer()
                    }
                
                /// 덕쿠
                HStack {
                    Image(.cupidDuckkuWhite)
                        .offset(x: -geometry.size.width / 2 + 88)
                    
                    Image(.cupidDuckkuBlack)
                        .offset(x: geometry.size.width / 2 - 88)
                }
                .padding(.top, shouldImagePadding ? 50 : 25)
                
                /// 백그라운드 홍예교
                Image(.cupidBackgroundBridge)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                /// 결과 뷰 및 정지버튼
                VStack {
                    /// BAD일 때
                    //                    VStack {
                    //                        Image(.cupidHeartBroken)
                    //                        Image(.cupidBad)
                    //                    }
                    //                    .padding(.top, shouldImagePadding ? 150 : 130)
                    
                    /// PERFECT일 때
                    //                    VStack {
                    //                        Image(.cupidHeart)
                    //                        Image(.cupidPerfect)
                    //                    }
                    //                    .padding(.top, shouldImagePadding ? 150 : 130)
                    
                    /// GOOD일 때
                    Image(.cupidGood)
                        .padding(.top, shouldImagePadding ? 190 : 160)
                    
                    Spacer()
                    
                    Button(action: {
                        //TODO: viewModel에 정의된 함수 넣기
                    }, label: {
                        Image(.cupidStop)
                            .padding(.bottom, 60)
                    })
                }
                
                VStack {}
                    .customNavigationBar(centerView: {
                        Text(StringLiterals.Game.Cupid.title)
                            .font(.neo22)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }, rightView: {
                        Button(action: {
                            viewModel.togglePauseView()
                        }, label: {
                            Image(.brownPauseButton)
                        })
                    }, height: 67)
                    .padding(.top, -10)
                
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
            }
        }
    }
}

#Preview {
    CupidGameView(viewModel: CupidGameViewModel(.cupid, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
