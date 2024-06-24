//
//  LandmarkView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/31/24.
//

import SwiftUI

struct LandmarkView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var isDescriptionShowing: Bool = false
    @State private var isRankingShowing: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    if isDescriptionShowing {
                        isDescriptionShowing = false
                    } else {
                        homeViewModel.transition(to: .home)
                    }
                }
            
            if isDescriptionShowing {
                LandmarkDetailView(homeViewModel: homeViewModel, isDescriptionShowing: $isDescriptionShowing)
            } else if isRankingShowing {
                LandmarkRankingView(homeViewModel: homeViewModel, isRankingShowing: $isRankingShowing)
            } else {
                Image(.landmarkBackground)
                    .overlay {
                        VStack(spacing: 0) {
                            Text(homeViewModel.getSelectedLandmark().name)
                                .font(.neo22)
                                .foregroundStyle(.kuText)
                                .kerning(-0.41)
                                .padding(.bottom, 8)
                            
                            ZStack {
                                Image("landmark\(homeViewModel.getSelectedLandmark().number)")
                                    .resizable()
                                    .frame(width: 112, height: 112)
                                
                                Image(.landmarkBorder)
                                    .resizable()
                                    .frame(width: 116, height: 116)
                            }
                            
                            let landmarkRank = homeViewModel.landmarkRank
                            
                            if landmarkRank.isEmpty {
                                // 랭킹이 없는 경우 아무것도 표시하지 않음
                                Spacer()
                                    .frame(height: 132)
                            } else {
                                Image(.landmarkMedal)
                                    .padding(.bottom, 8)
                                
                                Text(landmarkRank[0].nickname + StringLiterals.Home.nicknameTitle)
                                    .font(.neo18)
                                    .foregroundStyle(.kuText)
                                    .kerning(-0.41)
                                    .padding(.bottom, 2)
                                
                                Text("\(landmarkRank[0].score) " + StringLiterals.Home.scoreTitle)
                                    .font(.neo15)
                                    .foregroundStyle(.kuText)
                                    .kerning(-0.41)
                                    .padding(.bottom, 30)
                            }
                            
                            Button {
                                isRankingShowing.toggle()
                            } label: {
                                Image(.shortButtonBlue)
                                    .overlay {
                                        Text(StringLiterals.Home.Landmark.rankingTitle)
                                            .font(.neo18)
                                            .foregroundStyle(.kuText)
                                            .kerning(-0.41)
                                    }
                            }
                            .padding(.bottom, 5)
                            
                            Button {
                                isDescriptionShowing.toggle()
                            } label: {
                                Image(.shortButtonBlue)
                                    .overlay {
                                        Text(StringLiterals.Home.Landmark.buildingDescriptionTitle)
                                            .font(.neo18)
                                            .foregroundStyle(.kuText)
                                            .kerning(-0.41)
                                    }
                            }
                        }
                        .offset(y: 18)
                    }
            }
        }
        .onAppear {
            homeViewModel.selectedLandmarkID = 1
        }
    }
}

#Preview {
    LandmarkView(homeViewModel: HomeViewModel())
}
