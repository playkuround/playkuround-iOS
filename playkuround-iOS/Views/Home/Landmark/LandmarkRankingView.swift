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
                                        
                                        // 1등 플레이어 닉네임
                                        Text(rankingList[0].nickname)
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
                                                                              score: rank.score,
                                                                              profileBadge: rank.profileBadge))
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

#Preview {
    LandmarkRankingView(homeViewModel: HomeViewModel(rootViewModel: RootViewModel()), isRankingShowing: .constant(true))
}
