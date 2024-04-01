//
//  QuizGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/1/24.
//

import SwiftUI

struct QuizGameView: View {
    let quizData: [Quiz] = load("QuizData.json")
    
    var body: some View {
        ZStack {
            Image(.quizBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                QuizBlockView(quiz: quizData[1])
                    .padding(.top, 130)
                
                Text("00.15")
                    .font(.neo45)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
                    .padding(.top, 30)
            
                Text(StringLiterals.Game.Quiz.incorrect)
                    .font(.pretendard15R)
                    .foregroundStyle(.kuRed)
                    .multilineTextAlignment(.center)
                    
            }
            .customNavigationBar(centerView: {
                Text(StringLiterals.Game.Quiz.title)
                    .font(.neo22)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
            }, rightView: {
                Button(action: {
                    // TODO: 일시 중지
                }, label: {
                    Image(.grayPauseButton)
                })
            }, height: 40)
        
        }
    }
}




#Preview {
    QuizGameView()
}
