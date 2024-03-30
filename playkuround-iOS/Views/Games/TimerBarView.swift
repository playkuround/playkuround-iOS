//
//  TimerBarView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/31/24.
//

import SwiftUI

struct TimerBarView: View {
    @Binding var progress: Double
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("TIME")
                .font(.neo22)
                .foregroundStyle(.white)
                .kerning(-0.41)
                .offset(y: 3)
                .padding(.trailing, 13)
            
            VStack(spacing: 0) {
                Image(.timerBarIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 51, height: 40)
                    .offset(x: offsetValue())
                
                ZStack(alignment: .leading) {
                    Image(.timerBarBackground)
                    
                    Rectangle()
                        .frame(width: 272 * progress, height: 8)
                        .foregroundColor(progress >= 0.5 ? .kuTimebarGreen : (progress >= 0.2 ? .kuTimebarOrange : .kuTimebarRed))
                        .padding(.horizontal, 4)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
    private func offsetValue() -> Double {
        // 90.81% 이상
        if progress > (248 / 272) {
            return 112
        }
        // 9.19% 미만
        else if progress < (24 / 272) {
            return -112
        }
        // 중간
        else {
            return (272 * progress) - 136
        }
    }
}

struct TimerBarTestView: View {
    @State var progress: Double = 1.0
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            VStack {
                TimerBarView(progress: $progress)
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
