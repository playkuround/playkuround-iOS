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
    
    @State private var showDetailBadge: Bool = false
    @State private var selectedBadge: Badge?
    @State private var isSelectedBadgeLocked: Bool = false
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Image(.badgeBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
            Color.black.opacity(0.2)
                .ignoresSafeArea(.all)
            
            let badgeList: [BadgeResponse] = homeViewModel.badgeList
            
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
                                    /// 0~15번째: 출석 뱃지
                                    ForEach(Badge.allCases.prefix(16), id: \.self) { badge in
                                        filterBadgeImage(for: badge)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .onTapGesture {
                                                self.showDetailBadge.toggle()
                                                selectedBadge = badge
                                                isSelectedBadgeLocked = !badgeList.contains { $0.name == badge.rawValue }
                                                soundManager.playSound(sound: .buttonClicked)
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
                                    ForEach(Badge.allCases.suffix(27), id: \.self) { badge in
                                        filterBadgeImage(for: badge)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .onTapGesture {
                                                self.showDetailBadge.toggle()
                                                selectedBadge = badge
                                                isSelectedBadgeLocked = !badgeList.contains { $0.name == badge.rawValue }
                                                soundManager.playSound(sound: .buttonClicked)
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
                    soundManager.playSound(sound: .buttonClicked)
                } label: {
                    Image(.leftWhiteArrow)
                }
            }, height: 42)
            
            if showDetailBadge {
                if let selectedBadge = selectedBadge {
                    BadgeDetailView(badge: selectedBadge,
                                    isLocked: isSelectedBadgeLocked,
                                    showDetailBadge: $showDetailBadge)
                }
            }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.BadgeView)
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    func filterBadgeImage(for badge: Badge) -> Image {
        if homeViewModel.badgeList.contains(where: { $0.name == badge.rawValue }) {
            return badge.image
        } else {
            return Image(.badgeLock)
        }
    }
}

#Preview {
    BadgeView(rootViewModel: RootViewModel(), homeViewModel: HomeViewModel())
}
