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
        HStack(spacing: 0) {
            Text(String(ranking))
                .font(.neo18)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .frame(width: 40)
                .padding(.trailing, 15)
            
            if let badge = Badge(rawValue: rank.profileBadge) {
                badge.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 10)
            } else {
                // 예외 처리
                Color.kuGray1.opacity(0.5)
                    .frame(width: 20, height: 20)
                    .cornerRadius(4)
                    .padding(.trailing, 10)
            }
            
            Text(rank.nickname)
                .font(.pretendard15R)
                .foregroundStyle(.kuText)
                .lineLimit(1)
            
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
    TotalRankingRow(ranking: 1, rank: Ranking(nickname: "구라스", score: 123, profileBadge: "ATTENDANCE_1"))
}
