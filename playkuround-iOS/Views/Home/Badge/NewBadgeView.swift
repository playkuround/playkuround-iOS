//
//  NewBadgeView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/19/24.
//

import SwiftUI

struct NewBadgeView: View {
    let badge: Badge
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    // TODO: 화면 닫기
                }
            
            Image(.badgePopup)
                .overlay {
                    VStack {
                        badge.image
                            .resizable()
                            .frame(width: 120, height: 120)
                            .padding(.bottom, 16)
                        
                        HStack(alignment: .center, spacing: 8) {
                            // 뱃지 글자 가운데 오도록
                            Spacer()
                                .frame(width: 24)
                            
                            Text(badge.title)
                                .font(.neo20)
                                .kerning(-0.41)
                                .foregroundStyle(.kuText)
                            
                            Text(StringLiterals.Home.Badge.new)
                                .font(.neo15)
                                .kerning(-0.41)
                                .foregroundStyle(.kuTimebarRed)
                                .padding(.bottom, 4)
                        }
                        .padding(.bottom, 16)
                        
                        Text(badge.description)
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .lineSpacing(15 * 0.3)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 48)
                }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.NewBadgeView, badgeName: badge.rawValue)
        }
    }
}

#Preview {
    NewBadgeView(badge: .ATTENDANCE_1)
}
