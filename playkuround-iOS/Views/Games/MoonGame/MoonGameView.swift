//
//  MoonGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/31/24.
//

import SwiftUI

struct MoonGameView: View {
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
                    
                    Text("100")
                        .font(.neo50)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .overlay {
                    if shouldImagePadding {
                        Image(.moon4)
                            .padding(.bottom, 40)
                    }
                    else {
                        Image(.moon4)
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
}

#Preview {
    MoonGameView()
}
