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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.homeBackground)
                    .resizable()
                    .ignoresSafeArea()
                
                Color.black.opacity(0.2).ignoresSafeArea()
                
                let shouldPadding = geometry.size.height >= 700
                let rankingList = [Ranking(nickname: "test1", score: 1000),
                                   Ranking(nickname: "test2", score: 900),
                                   Ranking(nickname: "test3", score: 800),
                                   Ranking(nickname: "test4", score: 700),
                                   Ranking(nickname: "test5", score: 600),
                                   Ranking(nickname: "test6", score: 500),
                                   Ranking(nickname: "test7", score: 400)]
                
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
                                                // TODO: 1등 플레이어 점수 가져오기
                                                Text("+ 1,214")
                                                    .font(.neo20)
                                                    .foregroundColor(.kuText)
                                                    .kerning(-0.41)
                                            }
                                            .offset(y: 81)
                                    }
                                    .padding(.top, 60)
                                    
                                    Spacer()
                                        .frame(height: 24)
                                    
                                    VStack(alignment: .center, spacing: 5) {
                                        Text(homeViewModel.getSelectedLandmark().name)
                                            .font(.neo18)
                                            .foregroundColor(.kuTextDarkGreen)
                                            .kerning(-0.41) +
                                        
                                        Text(StringLiterals.Home.Landmark.rankingSubtext1)
                                            .font(.neo18)
                                            .foregroundColor(.kuText)
                                            .kerning(-0.41)
                                        
                                        Text(StringLiterals.Home.Landmark.rankingSubtext2)
                                            .font(.neo18)
                                            .foregroundColor(.kuText)
                                            .kerning(-0.41)
                                        
                                        // TODO: 1등 플레이어 닉네임 가져오기
                                        Text("건덕이")
                                            .font(.neo18)
                                            .foregroundColor(.kuTextDarkGreen)
                                            .kerning(-0.41) +
                                        
                                        Text(StringLiterals.Home.Landmark.rankingSubtext3)
                                            .font(.neo18)
                                            .foregroundColor(.kuText)
                                            .kerning(-0.41)
                                    }
                                    
                                    Spacer()
                                        .frame(height: 30)
                                    
                                    Image(.rankingTitleRow)
                                        .overlay {
                                            HStack {
                                                Text(StringLiterals.Home.TotalRanking.ranking)
                                                    .font(.neo15)
                                                    .foregroundStyle(.kuText)
                                                
                                                Spacer()
                                                
                                                Text(StringLiterals.Home.TotalRanking.nickname)
                                                    .font(.neo15)
                                                    .foregroundStyle(.kuText)
                                                
                                                Spacer()
                                                
                                                Text(StringLiterals.Home.TotalRanking.score)
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
                                                                              score: rank.score))
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 32)
                                    
                                    Image(.rankingMineRow)
                                        .overlay {
                                            HStack {
                                                Text(String(homeViewModel.userData.myRank.ranking))
                                                    .font(.neo18)
                                                    .kerning(-0.41)
                                                    .foregroundStyle(.kuText)
                                                
                                                Spacer()
                                                
                                                Text(StringLiterals.Home.me)
                                                    .font(.pretendard15R)
                                                    .foregroundStyle(.kuText)
                                                    .frame(width: 104)
                                                
                                                Spacer()
                                                
                                                Text(String(homeViewModel.userData.myRank.score.decimalFormatter))
                                                    .font(.neo18)
                                                    .kerning(-0.41)
                                                    .foregroundStyle(.kuText)
                                            }
                                            .padding(.horizontal, 22)
                                        }
                                        .padding(.horizontal, 16)
                                }
                                .padding(.bottom, shouldPadding ? 37 : 37)
                            } else {
                                // 랭킹에 아무도 없을 때
                                Text(StringLiterals.Home.Landmark.rankingEmpty)
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
                    Text(StringLiterals.Home.Landmark.rankingTitle)
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                }, leftView: {
                    Button {
                        isRankingShowing.toggle()
                    } label: {
                        Image(.leftWhiteArrow)
                    }
                }, height: 30)
            }
        }
    }
}

#Preview {
    LandmarkRankingView(homeViewModel: HomeViewModel(), isRankingShowing: .constant(true))
}
