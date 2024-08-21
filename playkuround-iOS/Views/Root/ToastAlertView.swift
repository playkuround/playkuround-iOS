//
//  ToastAlertView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/16/24.
//

import SwiftUI

struct ToastAlertView: View {
    let alertText: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            Image(.toastAlert)
                .overlay {
                    HStack(alignment: .center, spacing: 10) {
                        Text(alertText)
                            .font(.pretendard15R)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.kuText)
                    }
                    .padding(10)
                    .frame(width: 238, height: 100, alignment: .center)
                }
        }
    }
}

#Preview {
    ToastAlertView(alertText: "서버에 연결할 수 없습니다.\n잠시 후 다시 시도해주세요. 테스트 테스트 테스트")
}
