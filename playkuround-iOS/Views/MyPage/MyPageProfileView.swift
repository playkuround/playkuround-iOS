//
//  MyPageProfileView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageProfileView: View {
    let user: UserEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(user.nickname)" + NSLocalizedString("Home.NicknameTitle", comment: ""))
                .font(.neo20)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
            
            Text(user.major)
                .font(.neo15)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .padding(.top, 5)
            
            Image(.mypageCurrentScore)
                .overlay {
                    HStack {
                        Text("MyPage.CurrentScore")
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .padding(.trailing, 15)
                        
                        Text("\(String(describing: user.myRank.score))" + NSLocalizedString("Home.ScoreTitle", comment: "") + " (\(user.myRank.ranking == 0 ? "-" : "\(user.myRank.ranking)")" + NSLocalizedString("Home.RankingUnit", comment: "") + ")")
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }
                }
                .padding(.top, 15)
            
            Image(.mypageHighestScore)
                .overlay {
                    HStack {
                        Text("MyPage.HighestScore")
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .padding(.trailing, 15)
                        
                        Text("\(String(describing: user.highestScore))" + NSLocalizedString("Home.ScoreTitle", comment: "") + " (\(user.highestRank)" + NSLocalizedString("Home.RankingUnit", comment: "") + ")")
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }
                }
        }
    }
}
