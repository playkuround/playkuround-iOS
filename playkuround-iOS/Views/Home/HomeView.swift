//
//  HomeView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 6/3/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: RootViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var storyViewModel: StoryViewModel
    @State private var showStoryView: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.kuDarkGreen.ignoresSafeArea(.all)
                
                MapView(mapViewModel: mapViewModel, homeViewModel: homeViewModel)
                
                Image(.homeBorder)
                    .resizable()
                    .ignoresSafeArea(edges: .bottom)
                    .allowsHitTesting(false)
                
                let shouldPadding = geometry.size.width > 375
                
                VStack {
                    
                    HStack(spacing: 8) {
                        
                        Image(.engineering)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                // TODO: 추후 기능 구현 시
                                // homeViewModel.transition(to: .badgeProfile)
                            }
                        
                        Text(homeViewModel.userData.nickname + "님")
                            .font(.neo18)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .lineLimit(2)
                            .padding(.trailing, 10)
                        
                        Spacer()
                        
                        Image(.rankingKeywordBackground)
                            .overlay {
                                HStack(spacing: 6) {
                                    Text(StringLiterals.Home.ranking)
                                        .font(.neo12)
                                        .foregroundStyle(.white)
                                        .kerning(-0.41)
                                    Spacer()
                                    Text("\(homeViewModel.userData.myRank.ranking)" + StringLiterals.Home.rankingUnit)
                                        .font(.neo12)
                                        .foregroundStyle(.white)
                                        .kerning(-0.41)
                                }
                                .frame(width: 73)
                            }
                        
                        Image(.badgeKeywordBackground)
                            .overlay {
                                HStack {
                                    Text(String(format: StringLiterals.Home.badgeNum, "\(homeViewModel.badgeList.count)"))
                                        .font(.neo12)
                                        .foregroundStyle(.white)
                                        .kerning(-0.41)
                                }
                                .padding(.horizontal, 8)
                            }
                            .onTapGesture {
                                showStoryView.toggle()
                            }
                    }
                    .padding(.top, shouldPadding ? 4 : 0)
                    .padding(.horizontal, 24)
                    
                    HStack {
                        Spacer()
                        
                        // TODO: 버튼 클릭 시 각 뷰 표시
                        VStack(spacing: 7) {
                            Button {
                                homeViewModel.transition(to: .attendance)
                            } label: {
                                Image(.attendanceButton)
                            }
                            
                            Button {
                                homeViewModel.transition(to: .badge)
                            } label: {
                                Image(.badgeButton)
                            }
                            
                            Button {
                                homeViewModel.transition(to: .ranking)
                            } label: {
                                Image(.rankingButton)
                            }
                            
                            Button {
                                homeViewModel.transition(to: .myPage)
                            } label: {
                                Image(.myPageButton)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                    }
                    .padding(.top, shouldPadding ? 16 : 10)
                    
                    Spacer()
                    
                    // 임시 구현
                    Menu {
                        Section("탐험") {
                            Button("AdventureView 열기") {
                                let latitude = mapViewModel.userLatitude
                                let longitude = mapViewModel.userLongitude
                                
                                homeViewModel.adventure(latitude: latitude, longitude: longitude)
                            }
                        }
                        
                        Section("게임") {
                            Button("책 뒤집기") {
                                viewModel.transition(to: .cardGame)
                            }
                            Button("10초를 맞춰봐") {
                                viewModel.transition(to: .timeGame)
                            }
                            Button("MOON을 점령해") {
                                viewModel.transition(to: .moonGame)
                            }
                            Button("건쏠지식") {
                                viewModel.transition(to: .quizGame)
                            }
                            Button("덕큐피트") {
                                viewModel.transition(to: .cupidGame)
                            }
                            Button("수강신청 ALL 클릭") {
                                viewModel.transition(to: .allClickGame)
                            }
                            Button("일감호에서 살아남기") {
                                viewModel.transition(to: .surviveGame)
                            }
                            Button("덕쿠를 잡아라!") {
                                viewModel.transition(to: .catchGame)
                            }
                        }
                    } label: {
                        Image(.shortButtonBlue)
                            .overlay {
                                Text(StringLiterals.Home.adventure)
                                    .font(.neo18)
                                    .foregroundColor(.kuText)
                                    .kerning(-0.41)
                            }
                    }
                    .padding(.bottom, shouldPadding ? 60 : 70)
                }
                .padding(.top, shouldPadding ? 12 : 9)
                
                switch homeViewModel.viewStatus {
                case .home:
                    EmptyView()
                case .attendance:
                    AttendanceView(rootViewModel: viewModel, homeViewModel: homeViewModel, mapViewModel: mapViewModel)
                case .badge:
                    BadgeView(rootViewModel: viewModel, homeViewModel: homeViewModel)
                case .ranking:
                    TotalRankingView(rootViewModel: viewModel, homeViewModel: homeViewModel)
                case .myPage:
                    MyPageView(viewModel: viewModel, homeViewModel: homeViewModel)
                case .landmark:
                    LandmarkView(homeViewModel: homeViewModel)
                case .adventure:
                    AdventureView(viewModel: viewModel, homeViewModel: homeViewModel)
                case .badgeProfile:
                    ProfileBadgeView(homeViewModel: homeViewModel)
                }
                
                if showStoryView {
                    StoryView(viewModel: storyViewModel, showStoryView: $showStoryView)
                }
            }
            .onAppear {
                mapViewModel.startUpdatingLocation()
                
                // 홈 뷰 들어올 때 유저 데이터 받아옴
                homeViewModel.loadUserData()
                homeViewModel.loadBadge()
                homeViewModel.loadTotalRanking()
                homeViewModel.loadAttendance()
            }
            .onDisappear {
                // 홈 뷰에서 벗어날 때 위치 업데이트 중지
                mapViewModel.stopUpdatingLocation()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: RootViewModel(), homeViewModel: HomeViewModel(), mapViewModel: MapViewModel(), storyViewModel: StoryViewModel(stories: storyList))
}
