//
//  TimerBarView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/31/24.
//

import SwiftUI

enum TimerBarColor {
    case white
    case black
}

struct TimerBarView: View {
    @Binding var progress: Double
    let color: TimerBarColor
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(StringLiterals.Game.timerTitle)
                .font(.neo22)
                .foregroundStyle(color == .white ? .white : .kuText)
                .kerning(-0.41)
                .offset(y: 3)
                .padding(.trailing, 13)
            
            Spacer()
            
            VStack(spacing: 0) {
                Image(.timerBarIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 51, height: 40)
                    .offset(x: offsetValue())
                
                ZStack(alignment: .leading) {
                    Image(color == .white ? .timerBarBackground : .timerBarBackgroundBlack)
                    
                    Rectangle()
                        .frame(width: 272 * progress, height: 8)
                        // 50% 이상 초록, 20% 이상 주황, 20% 미만 빨강
                        .foregroundColor(progress >= 0.5 ?
                            .kuTimebarGreen : (progress >= 0.2 ?
                                .kuTimebarOrange : .kuTimebarRed))
                        .padding(.horizontal, 4)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .padding(.horizontal, 26)
    }
    
    private func offsetValue() -> Double {
        // 90.81% 이상은 100% 상태로 움직이지 않음
        if progress > (248 / 272) {
            return 112
        }
        // 9.19% 미만부터는 0% 상태로 움직이지 않음
        else if progress < (24 / 272) {
            return -112
        }
        // 중간 부분 offset 계산
        else {
            return (272 * progress) - 136
        }
    }
}

/// 테스트용 뷰
struct TimerBarTestView: View {
    @State var progress: Double = 1.0
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            VStack {
                // 뷰의 범위를 알아볼 수 있도록 border 추가
                TimerBarView(progress: $progress, color: .black)
                    .border(.black)
                
                Text("\(progress * 100)%")
                
                Slider(value: $progress, in: 0...1)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    TimerBarTestView()
}
