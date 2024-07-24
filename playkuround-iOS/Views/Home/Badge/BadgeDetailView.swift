//
//  BadgeDetailView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 6/5/24.
//

import SwiftUI

struct BadgeDetailView: View {
    let badge: Badge
    let isLocked: Bool
    
    @Binding var showDetailBadge: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    showDetailBadge.toggle()
                }
            
            Image(.badgePopup)
                .overlay {
                    VStack {
                        (isLocked ? Image(.badgeLockBig) : badge.image)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .padding(.bottom, 16)
                        
                        Text(badge.title)
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                            .padding(.bottom, 16)
                        
                        Text(isLocked ? badge.lockDescription : badge.description)
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .lineSpacing(15 * 0.3)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 48)
                }
        }
    }
}
