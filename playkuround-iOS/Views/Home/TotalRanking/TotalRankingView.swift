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
    @State private var showmain: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.rankingBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                Color.black.opacity(0.2)
                    .ignoresSafeArea(.all)
                
                let shouldPadding = geometry.size.height >= 700
                
                VStack {
                    Image(.rankingTable)
                        .resizable()
                        .frame(width: 336, height: shouldPadding ? 712 : 580)
                        .overlay(alignment: .top) {
                            VStack {
                                HStack(alignment: .top) {
                                    Image(.rankingSilver)
                                        .overlay(alignment: .bottom) {
                                            VStack {
                                                Text("안녕안녕")
                                                    .font(.neo15)
                                                    .foregroundStyle(.kuText)
                                                    .padding(.bottom, 11)
                                                    .padding(.top, 40)
                                                
                                                Rectangle()
                                                    .frame(width: 60, height: 23)
                                                    .foregroundStyle(.kuBrown)
                                                    .overlay {
                                                        Text("156점")
                                                            .font(.neo18)
                                                            .kerning(-0.41)
                                                            .foregroundStyle(.white)
                                                    }
                                                    .padding(.bottom, 128)
                                            }
                                            .padding(.horizontal, 12)
                                        }
                                    
                                    Image(.rankingGold)
                                        .overlay(alignment: .bottom) {
                                            VStack {
                                                Text("안녕안녕안녕")
                                                    .font(.neo15)
                                                    .foregroundStyle(.kuText)
                                                    .padding(.bottom, 11)
                                                    .padding(.top, 40)
                                                
                                                Rectangle()
                                                    .frame(width: 60, height: 23)
                                                    .foregroundStyle(.kuBrown)
                                                    .overlay {
                                                        Text("1,156점")
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
                                                Text("안녕안녕안녕")
                                                    .font(.neo15)
                                                    .foregroundStyle(.kuText)
                                                    .padding(.bottom, 11)
                                                    .padding(.top, 40)
                                                
                                                Rectangle()
                                                    .frame(width: 60, height: 23)
                                                    .foregroundStyle(.kuBrown)
                                                    .overlay {
                                                        Text("1,156점")
                                                            .font(.neo18)
                                                            .kerning(-0.41)
                                                            .foregroundStyle(.white)
                                                    }
                                                    .padding(.bottom, 128)
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
                                        ForEach(0..<100) { index in
                                            TotalRankingRow(ranking: index+1, rank: Ranking(nickname: "후훗gggggggggggggggg", score: 2322))
                                        }
                                    }
                                }
                                .padding(.horizontal, 32)
                                
                                Image(.rankingMineRow)
                                    .overlay {
                                        HStack {
                                            Text("67")
                                                .font(.neo18)
                                                .kerning(-0.41)
                                                .foregroundStyle(.kuText)
                                            
                                            Spacer()
                                            
                                            Text("나")
                                                .font(.pretendard15R)
                                                .foregroundStyle(.kuText)
                                                .frame(width: 104)
                                            
                                            Spacer()
                                            
                                            Text("1,234")
                                                .font(.neo18)
                                                .kerning(-0.41)
                                                .foregroundStyle(.kuText)
                                        }
                                        .padding(.horizontal, 22)
                                    }
                                    .padding(.horizontal, 16)
                            }
                            .padding(.bottom, shouldPadding ? 62 : 40)
                            
                            /// 순위가 없을 때 - 분기처리 필요
//                            Text(StringLiterals.Home.TotalRanking.empty)
//                                .font(.pretendard15R)
//                                .foregroundStyle(.kuText)
//                                .lineSpacing(15 * 0.3)
//                                .multilineTextAlignment(.center)
//                                .padding(.top, shouldPadding ? 337 : 271)
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
                        showmain.toggle()
                    } label: {
                        Image(.rankingInformationButton)
                    }
                }, height: 30)
            }
            if showmain {
                TotalRankingInformationView(backToMain: $showmain)
            }
        }
    }
}


#Preview {
    TotalRankingView(rootViewModel: RootViewModel(), homeViewModel: HomeViewModel())
}
