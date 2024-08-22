//
//  TotalRankingView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 6/5/24.
//

import SwiftUI

struct TotalRankingView: View {
    @ObservedObject var rootViewModel: RootViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var showInformationView: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.rankingBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                Color.black.opacity(0.2)
                    .ignoresSafeArea(.all)
                
                let shouldPadding = geometry.size.height >= 700
                let rankingList: [Ranking] = homeViewModel.totalRank
                
                VStack {
                    Image(.rankingTable)
                        .resizable()
                        .frame(width: 336, height: shouldPadding ? 712 : 580)
                        .overlay(alignment: .top) {
                            if !rankingList.isEmpty {
                                VStack {
                                    HStack(alignment: .top) {
                                        Image(.rankingSilver)
                                            .overlay(alignment: .bottom) {
                                                VStack {
                                                    if rankingList.indices.contains(1) {
                                                        Image(.engineering)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 42, height: 42)
                                                            .padding(.top, 20)
                                                        
                                                        Text(rankingList[1].nickname)
                                                            .font(.neo15)
                                                            .foregroundStyle(.kuText)
                                                            .padding(.bottom, 11)
                                                            .padding(.top, 8)
                                                        
                                                        Rectangle()
                                                            .frame(width: 60, height: 23)
                                                            .foregroundStyle(.kuBrown)
                                                            .overlay {
                                                                Text("\(rankingList[1].score.decimalFormatter)점")
                                                                    .font(.neo18)
                                                                    .kerning(-0.41)
                                                                    .foregroundStyle(.white)
                                                            }
                                                            .padding(.bottom, 128)
                                                    }
                                                }
                                                .padding(.horizontal, 12)
                                            }
                                        
                                        Image(.rankingGold)
                                            .overlay(alignment: .bottom) {
                                                VStack {
                                                    Image(.engineering)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 42, height: 42)
                                                        .padding(.top, 50)
                                                    
                                                    Text(rankingList[0].nickname)
                                                        .font(.neo15)
                                                        .foregroundStyle(.kuText)
                                                        .padding(.bottom, 11)
                                                        .padding(.top, 8)
                                                    
                                                    Rectangle()
                                                        .frame(width: 60, height: 23)
                                                        .foregroundStyle(.kuBrown)
                                                        .overlay {
                                                            Text("\(rankingList[0].score.decimalFormatter)점")
                                                                .font(.neo18)
                                                                .kerning(-0.41)
                                                                .foregroundStyle(.white)
                                                        }
                                                        .padding(.bottom, 128)
                                                }
                                                .padding(.horizontal, 12)
                                            }
                                        
                                        Image(.rankingBronze)
                                            .overlay(alignment: .bottom) {
                                                VStack {
                                                    if rankingList.indices.contains(2) {
                                                        Image(.engineering)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 42, height: 42)
                                                            .padding(.top, 20)
                                                        
                                                        Text(rankingList[2].nickname)
                                                            .font(.neo15)
                                                            .foregroundStyle(.kuText)
                                                            .padding(.bottom, 11)
                                                            .padding(.top, 8)
                                                        
                                                        Rectangle()
                                                            .frame(width: 60, height: 23)
                                                            .foregroundStyle(.kuBrown)
                                                            .overlay {
                                                                Text("\(rankingList[2].score.decimalFormatter)점")
                                                                    .font(.neo18)
                                                                    .kerning(-0.41)
                                                                    .foregroundStyle(.white)
                                                            }
                                                            .padding(.bottom, 128)
                                                    }
                                                }
                                                .padding(.horizontal, 12)
                                            }
                                    }
                                    .padding(.top, 20)
                                    
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
                                                                rank: Ranking(nickname: rank.nickname, score: rank.score, profileBadge: "ATTENDANCE_1"))
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 32)
                                    
                                    Image(.rankingMineRow)
                                        .overlay {
                                            HStack(spacing: 0) {
                                                Text(String(homeViewModel.userData.myRank.ranking))
                                                    .font(.neo18)
                                                    .kerning(-0.41)
                                                    .foregroundStyle(.kuText)
                                                    .frame(width: 40)
                                                    .padding(.trailing, 15)
                                                
                                                Image(.engineering)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 20, height: 20)
                                                    .padding(.trailing, 10)
                                                
                                                Text("나")
                                                    .font(.pretendard15R)
                                                    .foregroundStyle(.kuText)
                                                    .lineLimit(1)
                                                
                                                Spacer()
                                                
                                                Text(String(homeViewModel.userData.myRank.score.decimalFormatter))
                                                    .font(.neo18)
                                                    .kerning(-0.41)
                                                    .foregroundStyle(.kuText)
                                                    .frame(width: 60)
                                            }
                                            .padding(.horizontal, 11)
                                        }
                                        .padding(.horizontal, 16)
                                }
                                .padding(.bottom, shouldPadding ? 62 : 40)
                            }
                            else {
                                // 랭킹에 아무도 없을 때
                                Text(StringLiterals.Home.TotalRanking.empty)
                                    .font(.pretendard15R)
                                    .foregroundStyle(.kuText)
                                    .lineSpacing(15 * 0.3)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, shouldPadding ? 337 : 271)
                            }
                        }
                }
                .customNavigationBar(centerView: {
                    Text(StringLiterals.Home.TotalRanking.title)
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                }, leftView: {
                    Button {
                        homeViewModel.transition(to: .home)
                    } label: {
                        Image(.leftWhiteArrow)
                    }
                }, rightView: {
                    Button {
                        showInformationView.toggle()
                    } label: {
                        Image(.rankingInformationButton)
                    }
                }, height: 30)
            }
            if showInformationView {
                TotalRankingInformationView(backToMain: $showInformationView)
            }
        }
    }
}


#Preview {
    TotalRankingView(rootViewModel: RootViewModel(), homeViewModel: HomeViewModel())
}
