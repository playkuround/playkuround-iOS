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
                        
                        Text(getTranslatedTitle(badge))
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                            .padding(.bottom, 16)
                        
                        Text(getTranslatedDescription(badge, isLocked: isLocked))
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .lineSpacing(15 * 0.3)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 48)
                }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.BadgeDetailView, badgeName: badge.rawValue)
        }
    }
    
    func getTranslatedTitle(_ badge: Badge) -> String {
        let currentLanguage = Locale.current.language.languageCode?.identifier
        
        switch currentLanguage {
        case "ko":
            return badge.titleKorean
        case "en":
            return badge.titleEnglish
        case "zh":
            return badge.titleChinese
        default:
            return badge.titleKorean
        }
    }
    
    func getTranslatedDescription(_ badge: Badge, isLocked: Bool) -> String {
        let currentLanguage = Locale.current.language.languageCode?.identifier
        
        // 잠긴 경우
        if isLocked {
            switch currentLanguage {
            case "ko":
                return badge.lockDescriptionKorean
            case "en":
                return badge.lockDescriptionEnglish
            case "zh":
                return badge.lockDescriptionChinese
            default:
                return badge.lockDescriptionKorean
            }
        }
        // 열린 경우
        else {
            switch currentLanguage {
            case "ko":
                return badge.descriptionKorean
            case "en":
                return badge.descriptionEnglish
            case "zh":
                return badge.descriptionChinese
            default:
                return badge.descriptionKorean
            }
        }
    }
}
