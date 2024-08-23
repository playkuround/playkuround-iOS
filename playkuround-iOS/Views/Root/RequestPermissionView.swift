//
//  RequestPermissionView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/28/24.
//

import SwiftUI
import UIKit

struct RequestPermissionView: View {
    @ObservedObject var mapViewModel: MapViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.66).ignoresSafeArea()
            
            Image(.messageBackground)
                .overlay {
                    VStack {
                        Text(StringLiterals.Permission.title)
                            .font(.neo22)
                            .kerning(-0.41)
                            .multilineTextAlignment(.center)
                            .padding(.top, 60)
                            .padding(.bottom, 30)
                        
                        TextWithBoldSubstring(originalText: StringLiterals.Permission.description1, boldSubText: StringLiterals.Permission.descriptionBold, regularFont: .pretendard15R, boldFont: .pretendard15B)
                            .padding(.bottom, 16)
                        
                        Text(StringLiterals.Permission.description2)
                            .font(.pretendard15R)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 16)
                        
                        Text(StringLiterals.Permission.description3)
                            .font(.pretendard15R)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 40)
                        
                        Image(.shortButtonBlue)
                            .overlay {
                                Text(StringLiterals.Permission.openSetting)
                                    .font(.neo18)
                                    .kerning(-0.41)
                            }
                            .onTapGesture {
                                // 설정 열기
                                mapViewModel.openSettings()
                            }
                    }
                }
        }
    }
}

struct TextWithBoldSubstring: View {
    let originalText: String
    let boldSubText: String
    let regularFont: Font
    let boldFont: Font
    
    var body: some View {
        if let boldRange = originalText.range(of: boldSubText) {
            let beforeRange = originalText[..<boldRange.lowerBound]
            let boldText = originalText[boldRange]
            let afterRange = originalText[boldRange.upperBound...]
            
            return Text(beforeRange) 
                .font(regularFont)
            + Text(boldText)
                .font(boldFont)
            + Text(afterRange)
                .font(regularFont)
        } else {
            return Text(originalText)
                .font(regularFont)
        }
    }
}

#Preview {
    RequestPermissionView(mapViewModel: MapViewModel(rootViewModel: RootViewModel()))
}
