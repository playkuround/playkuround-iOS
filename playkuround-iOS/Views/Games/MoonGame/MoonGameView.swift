//
//  MoonGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/31/24.
//

import SwiftUI

struct MoonGameView: View {
    @State private var shouldShake = false
    @ObservedObject var viewModel: MoonGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(.moonBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                // 뷰의 사이즈에 따라 Image의 padding값 조절
                let shouldImagePadding = geometry.size.height >= 700
                
                VStack {
                    Text(StringLiterals.Game.Moon.description)
                        .font(.pretendard15R)
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                    
                    Text("\(viewModel.moonTapped)")
                        .font(.neo50)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .overlay {
                    switch viewModel.moonState {
                    case .fullMoon, .cracked, .moreCracked, .duck:
                        moonImage(named: viewModel.moonState.image.rawValue, padding: shouldImagePadding)
                    }
                }
                .padding(.top, 70)
                .customNavigationBar(centerView: {
                    Text(StringLiterals.Game.Moon.title)
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                }, rightView: {
                    Button(action: {
                        // TODO: 일시정지
                    }, label: {
                        Image(.yellowPauseButton)
                    })
                }, height: 67)
                
                
            }
        }
    }
    
    private func moonImage(named imageName: String, padding: Bool) -> some View {
        Image(imageName)
            .padding(.bottom, padding ? 40 : 0)
            .animation(Animation.easeInOut(duration: 0.1).repeatCount(4), value: shouldShake)
            .offset(x: shouldShake ? -3 : 3, y: 0)
            .onTapGesture {
                withAnimation {
                    self.shouldShake.toggle()
                    viewModel.moonClick()
                }
            }
    }
    
}
