//
//  BadgeView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 6/2/24.
//

import SwiftUI

struct BadgeView: View {
    @ObservedObject var rootViewModel: RootViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var showDetail: Bool = false
    @State private var selectedBadge: Badge?
    
    var body: some View {
        ZStack {
            Image(.badgeBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack {
                    Image(.attendanceBadgeTable)
                        .overlay(alignment: .top) {
                            VStack {
                                Text(StringLiterals.Home.Badge.attendanceTitle)
                                    .font(.neo20)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuText)
                                    .padding(.top, 19)
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                                    /// 0~10번째: 출석 뱃지
                                    ForEach(Array(Badge.allCases.prefix(11)), id: \.self) { badge in
                                        badge.image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .onTapGesture {
                                                self.showDetail.toggle()
                                                selectedBadge = badge
                                            }
                                    }
                                }
                                .padding(.top, 30)
                                .padding(.horizontal,40)
                            }
                        }
                        .padding(.bottom, 38)
                    
                    Image(.adventureBadgeTable)
                        .overlay(alignment: .top) {
                            VStack {
                                Text(StringLiterals.Home.Badge.adventureTitle)
                                    .font(.neo20)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuText)
                                    .padding(.top, 19)
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                                    /// 11~37번째: 탐험 뱃지
                                    ForEach(Array(Badge.allCases.suffix(27)), id: \.self) { badge in
                                        badge.image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .onTapGesture {
                                                self.showDetail.toggle()
                                                selectedBadge = badge
                                            }
                                    }
                                }
                                .padding(.top, 30)
                                .padding(.horizontal, 40)
                            }
                        }
                }
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
            .customNavigationBar(centerView: {
                Text(StringLiterals.Home.Badge.title)
                    .font(.neo22)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
            }, leftView: {
                Button {
                    homeViewModel.transition(to: .home)
                } label: {
                    Image(.leftWhiteArrow)
                }
            }, height: 42)
            
            if showDetail {
                if let selectedBadge = selectedBadge {
                    BadgeDetailView(badge: selectedBadge,
                                    showDetail: $showDetail)
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    BadgeView(rootViewModel: RootViewModel(), homeViewModel: HomeViewModel())
}
