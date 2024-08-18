//
//  ProfileBadgeView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/17/24.
//

import SwiftUI

struct ProfileBadgeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var selectedBadge: Badge? = nil
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    homeViewModel.transition(to: .home)
                }
            Image(.profileBadgeBackground)
                .overlay {
                    VStack(alignment: .center, spacing: 0) {
                        Text(StringLiterals.Home.ProfileBadge.title)
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                            .padding(.top, 70)
                            .padding(.bottom, 4)
                            
                        Text(StringLiterals.Home.ProfileBadge.description)
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .padding(.bottom, 30)
                        
                        /* if let selectedBadge = selectedBadge {
                            selectedBadge.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .padding(.bottom, 10)
                        } */
                        
                        // 임시 이미지
                        Image(.engineering)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .padding(.bottom, 10)
                        
                        Text("USER_NICKNAME")
                        // Text(homeViewModel.userData.nickname) // TODO: 실제 사용자 닉네임 대체
                            .font(.neo18)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                            .padding(.bottom, 30)
                        
                        ScrollView(.vertical, content: {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                                ForEach(Badge.allCases, id: \.self) { badge in
                                    ZStack {
                                        filterBadgeImage(for: badge)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .onTapGesture {
                                                // TODO: 잠기지 않은 경우에만 변경되도록 조건 걸기
                                                if homeViewModel.badgeList.contains(where: { $0.description == badge.rawValue }) {
                                                    selectedBadge = badge
                                                }
                                            }
                                        
                                        if badge == selectedBadge {
                                            Image(.badgeChecked)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        }
                                    }
                                }
                            }
                        })
                        .padding(.horizontal, 40)
                        
                        Button {
                            // TODO: upload selected user profile
                        } label: {
                            Image(.shortButtonBlue)
                                .overlay {
                                    Text(StringLiterals.Home.ProfileBadge.change)
                                        .font(.neo18)
                                        .kerning(-0.41)
                                        .foregroundStyle(.kuText)
                                }
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 70)
                    }
                }
        }
    }
    
    func filterBadgeImage(for badge: Badge) -> Image {
        // 디자인 구현용으로 모두 열린 상태로 반환
        if homeViewModel.badgeList.contains(where: { $0.description == badge.rawValue }) {
            return badge.image
        } else {
            return Image(.badgeLock)
        }
    }
}

#Preview {
    ProfileBadgeView(homeViewModel: HomeViewModel())
}
