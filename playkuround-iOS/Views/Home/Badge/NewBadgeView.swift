//
//  NewBadgeView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/19/24.
//

import SwiftUI

struct NewBadgeView: View {
    @ObservedObject var rootViewModel: RootViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    rootViewModel.closeNewBadgeView()
                }
            
            let badge = rootViewModel.newBadgeList.first
            
            if let badge = badge {
                
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
                                
                                Text(getTranslatedTitle(badge))
                                    .font(.neo20)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuText)
                                
                                Text("Home.Badge.New")
                                    .font(.neo15)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuTimebarRed)
                                    .padding(.bottom, 4)
                            }
                            .padding(.bottom, 16)
                            
                            Text(getTranslatedDescription(badge))
                                .font(.pretendard15R)
                                .foregroundStyle(.kuText)
                                .lineSpacing(15 * 0.3)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 48)
                    }
                    .onAppear {
                        GAManager.shared.logScreenEvent(.NewBadgeView, badgeName: badge.rawValue)
                    }
            }
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
    
    func getTranslatedDescription(_ badge: Badge) -> String {
        let currentLanguage = Locale.current.language.languageCode?.identifier
        
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
