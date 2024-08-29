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
            
            if let majorName = getLocalizedMajorName() {
                Text(majorName)
                    .font(.neo15)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
                    .padding(.top, 5)
            }
            
            let currentScoreLabel = Text("MyPage.CurrentScore")
                .font(.pretendard15R)
                .foregroundStyle(.kuText)
                .padding(.trailing, 15)
            
            let userRank = "(" + (user.myRank.ranking == 0 ? "- " : "\(user.myRank.ranking)")

            let currentScoreValue = Text("\(String(describing: user.myRank.score))" + NSLocalizedString("Home.ScoreTitle", comment: "") + userRank + NSLocalizedString("MyPage.RankingUnit", comment: "") + ")")
                .font(.neo20)
                .kerning(-0.41)
                .foregroundStyle(.kuText)

            let currentScoreOverlay = HStack {
                currentScoreLabel
                currentScoreValue
            }

            Image(.mypageCurrentScore)
                .overlay(currentScoreOverlay)
                .padding(.top, 15)

            // Highest Score Section
            let highestScoreLabel = Text("MyPage.HighestScore")
                .font(.pretendard15R)
                .foregroundStyle(.kuText)
                .padding(.trailing, 15)
            
            let highestRank = "(" + (user.highestRank == "-" ? "- " : "\(user.highestRank)")

            let highestScoreValue = Text("\(String(describing: user.highestScore))" + NSLocalizedString("Home.ScoreTitle", comment: "") + highestRank + NSLocalizedString("MyPage.RankingUnit", comment: "") + ")")
                .font(.neo20)
                .kerning(-0.41)
                .foregroundStyle(.kuText)

            let highestScoreOverlay = HStack {
                highestScoreLabel
                highestScoreValue
            }

            Image(.mypageHighestScore)
                .overlay(highestScoreOverlay)
        }
    }
    
    private func getLocalizedMajorName() -> String? {
        let majorKoreanName = self.user.major
        
        let currentLanguage = Locale.current.language.languageCode?.identifier
        
        if currentLanguage != "zh" && currentLanguage != "en" {
            return majorKoreanName
        }
        
        var id: Int = -1
        
        for colleges in majorListKorean {
            for major in colleges.majors {
                if major.name == majorKoreanName {
                    id = major.id
                }
            }
        }
        
        if id < 0 {
            return nil
        }
        
        if currentLanguage == "zh" {
            for colleges in majorListChinese {
                for major in colleges.majors {
                    if major.id == id {
                        return major.name
                    }
                }
            }
        } else {
            for colleges in majorListEnglish {
                for major in colleges.majors {
                    if major.id == id {
                        return major.name
                    }
                }
            }
        }
        
        return nil
    }
}
