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
                        Text("Home.ProfileBadge.Title")
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                            .padding(.top, 70)
                            .padding(.bottom, 4)
                            
                        Text("Home.ProfileBadge.Description")
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .padding(.bottom, 30)
                        
                        if let selectedBadge = selectedBadge {
                            selectedBadge.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .padding(.bottom, 10)
                        } else {
                            Color.kuGray1.opacity(0.5)
                                .frame(width: 120, height: 120)
                                .cornerRadius(5)
                                .padding(.bottom, 10)
                        }
                        
                        Text(homeViewModel.userData.nickname)
                            .font(.neo18)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                            .padding(.bottom, 30)
                        
                        ScrollView(.vertical, content: {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                                ForEach(Badge.allCases, id: \.self) { badge in
                                    if let badgeImage = filterBadgeImage(for: badge) {
                                        ZStack {
                                            badgeImage
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .onTapGesture {
                                                    // TODO: 잠기지 않은 경우에만 변경되도록 조건 걸기
                                                    if homeViewModel.badgeList.contains(where: { $0.name == badge.rawValue }) {
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
                            }
                        })
                        .padding(.horizontal, 40)
                        
                        Button {
                            if let selectedBadge = selectedBadge {
                                APIManager.shared.callPOSTAPI(endpoint: .profileBadge, parameters: ["profileBadge": selectedBadge.rawValue]) { result in
                                    switch result {
                                    case .success(let data):
                                        print("(success) /api/users/profile-badge: \(data)")
                                        
                                        // 뱃지 변경 이벤트
                                        GAManager.shared.logEvent(.BADGE_PROFILE_CHANGE,
                                                                  parameters: ["BadgeName": selectedBadge.rawValue])
                                        
                                        homeViewModel.loadUserData()
                                        homeViewModel.loadTotalRanking()
                                        homeViewModel.transition(to: .home)
                                    case .failure(let error):
                                        print("(fail) /api/users/profile-badge: \(error)")
                                    }
                                }
                            }
                        } label: {
                            Image(.shortButtonBlue)
                                .overlay {
                                    Text("Home.ProfileBadge.Change")
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
        .onAppear {
            selectedBadge = Badge(rawValue: homeViewModel.userData.profileBadge)
            GAManager.shared.logScreenEvent(.BadgeProfileView)
        }
    }
    
    func filterBadgeImage(for badge: Badge) -> Image? {
        if homeViewModel.badgeList.contains(where: { $0.name == badge.rawValue }) {
            return badge.image
        } else {
            return nil
        }
    }
}

#Preview {
    ProfileBadgeView(homeViewModel: HomeViewModel(rootViewModel: RootViewModel()))
}
