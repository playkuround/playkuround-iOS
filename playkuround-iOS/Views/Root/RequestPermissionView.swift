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
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.66).ignoresSafeArea()
            
            Image(.messageBackground)
                .overlay {
                    VStack {
                        let title = NSLocalizedString("Permission.Title", comment: "")
                            .replacingOccurrences(of: "<br>", with: "\n")
                        
                        Text(title)
                            .font(.neo22)
                            .kerning(-0.41)
                            .multilineTextAlignment(.center)
                            .padding(.top, 60)
                            .padding(.bottom, 30)
                        
                        let description1 = NSLocalizedString("Permission.Description1", comment: "")
                            .replacingOccurrences(of: "<br>", with: "\n")
                        
                        TextWithBoldSubstring(originalText: description1, boldSubText: NSLocalizedString("Permission.DescriptionBold", comment: ""), regularFont: .pretendard15R, boldFont: .pretendard15B)
                            .padding(.bottom, 16)
                        
                        let description2 = NSLocalizedString("Permission.Description2", comment: "")
                            .replacingOccurrences(of: "<br>", with: "\n")
                        
                        Text(description2)
                            .font(.pretendard15R)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 16)
                        
                        let description3 = NSLocalizedString("Permission.Description3", comment: "")
                            .replacingOccurrences(of: "<br>", with: "\n")
                        
                        Text(description3)
                            .font(.pretendard15R)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 40)
                        
                        Image(.shortButtonBlue)
                            .overlay {
                                Text("Permission.OpenSetting")
                                    .font(.neo18)
                                    .kerning(-0.41)
                            }
                            .onTapGesture {
                                // 설정 열기
                                soundManager.playSound(sound: .buttonClicked)
                                mapViewModel.openSettings()
                            }
                    }
                }
        }
        .onTapGesture {
            GAManager.shared.logScreenEvent(.RequestPermissionView)
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
