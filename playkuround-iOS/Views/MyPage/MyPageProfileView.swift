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
            Text("\(user.nickname)님")
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
                        Text(StringLiterals.MyPage.currentScore)
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .padding(.trailing, 15)
                        
                        Text("\(String(describing: user.myRank.score))점 (\(user.myRank.ranking == 0 ? "-" : "\(user.myRank.ranking)")등)")
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }
                }
                .padding(.top, 15)
            
            Image(.mypageHighestScore)
                .overlay {
                    HStack {
                        Text(StringLiterals.MyPage.highestScore)
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .padding(.trailing, 15)
                        
                        Text("\(String(describing: user.highestScore))점 (\(user.highestRank)등)")
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }
                }
        }
    }
}
