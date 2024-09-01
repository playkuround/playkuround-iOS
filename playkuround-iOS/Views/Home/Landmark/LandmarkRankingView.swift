//
//  LandmarkRankingView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 6/24/24.
//

import SwiftUI

struct LandmarkRankingView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @Binding var isRankingShowing: Bool
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.homeBackground)
                    .resizable()
                    .ignoresSafeArea()
                
                Color.black.opacity(0.2).ignoresSafeArea()
                
                let shouldPadding = geometry.size.height >= 700
                let rankingList: [Ranking] = homeViewModel.landmarkRank
                
                VStack {
                    Spacer()
                    
                    Image(.landmarkRankingBackground)
                        .resizable()
                        .frame(width: 336, height: shouldPadding ? 712 : 580)
                        .overlay(alignment: .top) {
                            if !rankingList.isEmpty {
                                VStack {
                                    ZStack {
                                        Image(.landmarkRankingFrame)
                                            .resizable()
                                            .frame(width: 176, height: 176)
                                        Image("landmark\(homeViewModel.getSelectedLandmark().number)")
                                            .resizable()
                                            .frame(width: 168, height: 168)
                                    }
                                    .overlay {
                                        Image(.landmarkScoreBackground)
                                            .overlay {
                                                // 1등 플레이어 점수
                                                Text("+ \(rankingList[0].score.decimalFormatter)")
                                                    .font(.neo20)
                                                    .foregroundColor(.kuText)
                                                    .kerning(-0.41)
                                                    .minimumScaleFactor(0.5)
                                                    .lineLimit(1)
                                            }
                                            .offset(y: 81)
                                    }
                                    .padding(.top, 60)
                                    
                                    Spacer()
                                        .frame(height: 24)
                                    
                                    VStack(alignment: .center, spacing: 5) {
                                        let originalString = NSLocalizedString("Home.Landmark.RankingSubtext", comment: "")
                                        
                                        let replacedString = originalString
                                            .replacingOccurrences(of: "[LANDMARK]", with: homeViewModel.getSelectedLandmark().name)
                                            .replacingOccurrences(of: "[NICKNAME]", with: rankingList[0].nickname)
                                            .replacingOccurrences(of: "<br>", with: "\n")
                                        
                                        TextWithColorSubstring(originalText: replacedString,
                                                               colorSubText1: homeViewModel.getSelectedLandmark().name,
                                                               colorSubText2: rankingList[0].nickname,
                                                               regularFont: .neo18,
                                                               regularColor: .kuText,
                                                               color: .kuTextDarkGreen)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                            .kerning(-0.41)
                                    }
                                    
                                    Spacer()
                                        .frame(height: 30)
                                    
                                    Image(.rankingTitleRow)
                                        .overlay {
                                            HStack {
                                                Text("Home.TotalRanking.Ranking")
                                                    .font(.neo15)
                                                    .foregroundStyle(.kuText)
                                                
                                                Spacer()
                                                
                                                Text("Home.TotalRanking.Nickname")
                                                    .font(.neo15)
                                                    .foregroundStyle(.kuText)
                                                
                                                Spacer()
                                                
                                                Text("Home.TotalRanking.Score")
                                                    .font(.neo15)
                                                    .foregroundStyle(.kuText)
                                            }
                                            .padding(.horizontal, 16)
                                        }
                                    
                                    ScrollView {
                                        VStack(spacing: 12) {
                                            ForEach(Array(rankingList.enumerated()), id: \.offset) { index, rank in
                                                TotalRankingRow(ranking: index + 1,
                                                                rank: Ranking(nickname: rank.nickname, 
                                                                              score: rank.score,
                                                                              profileBadge: rank.profileBadge))
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 32)
                                    
                                    Image(.rankingMineRow)
                                        .overlay {
                                            HStack(spacing: 0) {
                                                let ranking = homeViewModel.userData.landmarkRank.ranking
                                                
                                                Text(ranking == 0 ? "-" : String(ranking))
                                                    .font(.neo18)
                                                    .kerning(-0.41)
                                                    .foregroundStyle(.kuText)
                                                    .frame(width: 40)
                                                    .padding(.trailing, 15)
                                                
                                                if let badge = Badge(rawValue: homeViewModel.userData.myRank.profileBadge) {
                                                    badge.image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                        .padding(.trailing, 10)
                                                } else {
                                                    Color.kuGray1.opacity(0.5)
                                                        .frame(width: 20, height: 20)
                                                        .cornerRadius(4)
                                                        .padding(.trailing, 10)
                                                }
                                                
                                                Text("Home.Me")
                                                    .font(.pretendard15R)
                                                    .foregroundStyle(.kuText)
                                                    .lineLimit(1)
                                                
                                                Spacer()
                                                
                                                let score = homeViewModel.userData.landmarkRank.score.decimalFormatter
                                                
                                                Text(String(score))
                                                    .font(.neo18)
                                                    .kerning(-0.41)
                                                    .foregroundStyle(.kuText)
                                                    .frame(width: 60)
                                            }
                                            .padding(.horizontal, 11)
                                        }
                                        .padding(.horizontal, 16)
                                }
                                .padding(.bottom, shouldPadding ? 37 : 37)
                            } else {
                                // 랭킹에 아무도 없을 때
                                let text = NSLocalizedString("Home.Landmark.RankingEmpty", comment: "")
                                    .replacingOccurrences(of: "<br>", with: "\n")
                                
                                Text(text)
                                    .font(.pretendard15R)
                                    .foregroundStyle(.kuText)
                                    .lineSpacing(15 * 0.3)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, shouldPadding ? 337 : 271)
                            }
                        }
                    
                    Spacer()
                }
                .customNavigationBar(centerView: {
                    Text("Home.Landmark.RankingTitle")
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                }, leftView: {
                    Button {
                        isRankingShowing.toggle()
                        soundManager.playSound(sound: .buttonClicked)
                    } label: {
                        Image(.leftWhiteArrow)
                    }
                }, height: 30)
            }
            .onAppear {
                GAManager.shared.logScreenEvent(.LandmarkRankingView,
                                                landmarkID: homeViewModel.getSelectedLandmark().number)
            }
        }
    }
}

struct TextWithColorSubstring: View {
    let originalText: String
    let colorSubText1: String
    let colorSubText2: String
    let regularFont: Font
    let regularColor: Color
    let color: Color

    var body: some View {
        // 첫 번째 colorSubText1 범위 탐색
        if let colorRange1 = originalText.range(of: colorSubText1) {
            let beforeRange1 = originalText[..<colorRange1.lowerBound]
            let colorText1 = originalText[colorRange1]
            let afterRange1 = originalText[colorRange1.upperBound...]
            
            // 두 번째 colorSubText2 범위 탐색
            if let colorRange2 = afterRange1.range(of: colorSubText2) {
                let beforeRange2 = afterRange1[..<colorRange2.lowerBound]
                let colorText2 = afterRange1[colorRange2]
                let afterRange2 = afterRange1[colorRange2.upperBound...]
                
                return Text(beforeRange1)
                    .font(regularFont)
                    .foregroundColor(regularColor)
                + Text(colorText1)
                    .font(regularFont)
                    .foregroundColor(color)
                + Text(beforeRange2)
                    .font(regularFont)
                    .foregroundColor(regularColor)
                + Text(colorText2)
                    .font(regularFont)
                    .foregroundColor(color)
                + Text(afterRange2)
                    .font(regularFont)
                    .foregroundColor(regularColor)
            } else {
                // colorSubText2가 없을 경우
                return Text(beforeRange1)
                    .font(regularFont)
                    .foregroundColor(regularColor)
                + Text(colorText1)
                    .font(regularFont)
                    .foregroundColor(color)
                + Text(afterRange1)
                    .font(regularFont)
                    .foregroundColor(regularColor)
            }
        } else {
            // colorSubText1이 없을 경우
            return Text(originalText)
                .font(regularFont)
                .foregroundColor(regularColor)
        }
    }
}

#Preview {
    LandmarkRankingView(homeViewModel: HomeViewModel(rootViewModel: RootViewModel()), isRankingShowing: .constant(true))
}
