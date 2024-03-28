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
                        Text("위치 권한 허용하면\n플쿠 즐길 준비 완료!")
                            .font(.neo22)
                            .multilineTextAlignment(.center)
                            .padding(.top, 60)
                            .padding(.bottom, 30)
                        
                        TextWithBoldSubstring(originalText: "플레이쿠라운드는 GPS를 활용하여\n건국대학교를 탐험하는 게임이에요!", boldSubText: "GPS를 활용", regularFont: .pretendard15R, boldFont: .pretendard15B)
                            .padding(.bottom, 16)
                        
                        Text("게임 플레이를 위해서는\n사용자분의 위치 정보가 필요해요.")
                            .font(.pretendard15R)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 16)
                        
                        Text("설정에서 위치 권한 허용 후\n플레이쿠라운드를 마음껏 즐겨주세요!")
                            .font(.pretendard15R)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 40)
                        
                        Image(.shortButtonBlue)
                            .overlay {
                                Text("설정으로 이동")
                                    .font(.neo18)
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
    RequestPermissionView(mapViewModel: MapViewModel())
}
