//
//  TotalRankingRow.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 6/7/24.
//

import SwiftUI

struct TotalRankingRow: View {
    let ranking: Int
    let rank: Ranking
    
    var body: some View {
        HStack {
            Text(String(ranking))
                .font(.neo18)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .frame(width: 40)
            
            Spacer()
            
            Text(rank.nickname)
                .font(.pretendard15R)
                .foregroundStyle(.kuText)
                .frame(width: 100)
            
            Spacer()
            
            Text(String(rank.score.decimalFormatter))
                .font(.neo18)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .frame(width: 60)
        }
        .padding(.horizontal, 11)
        .frame(height: 30)
    }
}

#Preview {
    TotalRankingRow(ranking: 1, rank: Ranking(nickname: "구라스", score: 123))
}
