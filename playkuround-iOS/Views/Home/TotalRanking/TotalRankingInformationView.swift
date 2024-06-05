//
//  TotalRankingInformationView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 6/5/24.
//

import SwiftUI

struct TotalRankingInformationView: View {
    @Binding var backToMain: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    backToMain.toggle()
                }
            
            Image(.rankingInformation)
                .overlay(alignment: .top) {
                    VStack {
                        Text(StringLiterals.Home.TotalRanking.informationTitle)
                            .font(.neo22)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                            .padding(.bottom, 30)
                        
                        Text(StringLiterals.Home.TotalRanking.informationDescription)
                            .multilineTextAlignment(.center)
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .lineSpacing(15 * 0.3)
                    }
                    .padding(.top, 45)
                }
        }
    }
}
