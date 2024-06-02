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
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring(duration: 0.2, bounce: 0.3)) {
                        if isDescriptionShowing {
                            isDescriptionShowing = false
                        } else {
                            homeViewModel.transition(to: .home)
                        }
                    }
                }
            
            if isDescriptionShowing {
                LandmarkDetailView(homeViewModel: homeViewModel, isDescriptionShowing: $isDescriptionShowing)
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
                            
                            Image(.landmarkMedal)
                                .padding(.bottom, 8)
                            
                            // TODO: HomeViewModel에서 건물 별 랭킹 로딩 필요
                            Text("USER_NAME" + StringLiterals.Home.nicknameTitle)
                                .font(.neo18)
                                .foregroundStyle(.kuText)
                                .kerning(-0.41)
                                .padding(.bottom, 2)
                            
                            Text("\(0) " + StringLiterals.Home.scoreTitle)
                                .font(.neo15)
                                .foregroundStyle(.kuText)
                                .kerning(-0.41)
                                .padding(.bottom, 30)
                            
                            Button {
                                // TODO: 랜드마크별 정복랭킹 뷰
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
                                withAnimation(.spring(duration: 0.2, bounce: 0.3)) {
                                    isDescriptionShowing.toggle()
                                }
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
    }
}

#Preview {
    LandmarkView(homeViewModel: HomeViewModel())
}
