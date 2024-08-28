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
    
    private let soundManager = SoundManager.shared
    
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
                                                        let rank2 = rankingList[1]
                                                        
                                                        if let badge = Badge(rawValue: rank2.profileBadge) {
                                                            badge.image
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: 42, height: 42)
                                                                .padding(.top, 20)
                                                        } else {
                                                            Color.kuGray1.opacity(0.5)
                                                                .frame(width: 42, height: 42)
                                                                .cornerRadius(5)
                                                                .padding(.top, 20)
                                                        }
                                                        
                                                        Text(rank2.nickname)
                                                            .font(.neo15)
                                                            .foregroundStyle(.kuText)
                                                            .padding(.bottom, 11)
                                                            .padding(.top, 8)
                                                        
                                                        Rectangle()
                                                            .frame(width: 60, height: 23)
                                                            .foregroundStyle(.kuBrown)
                                                            .overlay {
                                                                Text("\(rank2.score.decimalFormatter)" + NSLocalizedString("Ranking.ScoreTitle", comment: ""))
                                                                    .font(.neo18)
                                                                    .kerning(-0.41)
                                                                    .foregroundStyle(.white)
                                                                    .minimumScaleFactor(0.5)
                                                                    .lineLimit(1)
                                                            }
                                                            .padding(.bottom, 128)
                                                    }
                                                }
                                                .padding(.horizontal, 12)
                                            }
                                        
                                        Image(.rankingGold)
                                            .overlay(alignment: .bottom) {
                                                VStack {
                                                    let rank1 = rankingList[0]
                                                    
                                                    if let badge = Badge(rawValue: rank1.profileBadge) {
                                                        badge.image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 42, height: 42)
                                                            .padding(.top, 50)
                                                    } else {
                                                        Color.kuGray1.opacity(0.5)
                                                            .frame(width: 42, height: 42)
                                                            .cornerRadius(5)
                                                            .padding(.top, 50)
                                                    }
                                                    
                                                    Text(rank1.nickname)
                                                        .font(.neo15)
                                                        .foregroundStyle(.kuText)
                                                        .padding(.bottom, 11)
                                                        .padding(.top, 8)
                                                    
                                                    Rectangle()
                                                        .frame(width: 60, height: 23)
                                                        .foregroundStyle(.kuBrown)
                                                        .overlay {
                                                            Text("\(rank1.score.decimalFormatter)" + NSLocalizedString("Ranking.ScoreTitle", comment: ""))
                                                                .font(.neo18)
                                                                .kerning(-0.41)
                                                                .foregroundStyle(.white)
                                                                .minimumScaleFactor(0.5)
                                                                .lineLimit(1)
                                                        }
                                                        .padding(.bottom, 128)
                                                }
                                                .padding(.horizontal, 12)
                                            }
                                        
                                        Image(.rankingBronze)
                                            .overlay(alignment: .bottom) {
                                                VStack {
                                                    if rankingList.indices.contains(2) {
                                                        let rank3 = rankingList[2]
                                                        
                                                        if let badge = Badge(rawValue: rank3.profileBadge) {
                                                            badge.image
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: 42, height: 42)
                                                                .padding(.top, 20)
                                                        } else {
                                                            Color.kuGray1.opacity(0.5)
                                                                .frame(width: 42, height: 42)
                                                                .cornerRadius(5)
                                                                .padding(.top, 20)
                                                        }
                                                        
                                                        Text(rank3.nickname)
                                                            .font(.neo15)
                                                            .foregroundStyle(.kuText)
                                                            .padding(.bottom, 11)
                                                            .padding(.top, 8)
                                                        
                                                        Rectangle()
                                                            .frame(width: 60, height: 23)
                                                            .foregroundStyle(.kuBrown)
                                                            .overlay {
                                                                Text("\(rank3.score.decimalFormatter)" + NSLocalizedString("Ranking.ScoreTitle", comment: ""))
                                                                    .font(.neo18)
                                                                    .kerning(-0.41)
                                                                    .foregroundStyle(.white)
                                                                    .minimumScaleFactor(0.5)
                                                                    .lineLimit(1)
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
                                                                rank: Ranking(nickname: rank.nickname, score: rank.score, profileBadge: rank.profileBadge))
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
                                let text = NSLocalizedString("Home.TotalRanking.Empty", comment: "")
                                    .replacingOccurrences(of: "<br>", with: "\n")
                                
                                Text(text)
                                    .font(.pretendard15R)
                                    .foregroundStyle(.kuText)
                                    .lineSpacing(15 * 0.3)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, shouldPadding ? 337 : 271)
                            }
                        }
                }
                .customNavigationBar(centerView: {
                    Text("Home.TotalRanking.InformationTitle")
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.white)
                }, leftView: {
                    Button {
                        homeViewModel.transition(to: .home)
                        soundManager.playSound(sound: .buttonClicked)
                    } label: {
                        Image(.leftWhiteArrow)
                    }
                }, rightView: {
                    Button {
                        showInformationView.toggle()
                        soundManager.playSound(sound: .buttonClicked)
                    } label: {
                        Image(.rankingInformationButton)
                    }
                }, height: 30)
            }
            .onAppear {
                GAManager.shared.logScreenEvent(.TotalRankingView)
            }
            if showInformationView {
                TotalRankingInformationView(backToMain: $showInformationView)
            }
        }
    }
}


#Preview {
    TotalRankingView(rootViewModel: RootViewModel(), homeViewModel: HomeViewModel(rootViewModel: RootViewModel()))
}
