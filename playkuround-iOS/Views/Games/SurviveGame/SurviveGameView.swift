//
//  SurviveGameView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/2/24.
//

import SwiftUI

struct SurviveGameView: View {
    var body: some View {
        ZStack {
            Image(.surviveBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
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
            }, height: 67)
        }
    }
}

#Preview {
    SurviveGameView()
}

struct SurviveInstance: Hashable, Identifiable {
    var id = UUID()
    
}


