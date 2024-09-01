//
//  UpdateRequestView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 9/1/24.
//

import SwiftUI

struct UpdateRequestView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            
            Image(.updateBackground)
                .overlay {
                    VStack(alignment: .center, spacing: 0) {
                        Text("AppUpdate.Title")
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.top, 70)
                            .padding(.bottom, 20)
                        
                        let description = NSLocalizedString("AppUpdate.Description", comment: "")
                            .replacingOccurrences(of: "<br>", with: "\n")
                        
                        Text(description)
                            .multilineTextAlignment(.center)
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .padding(.bottom, 30)
                        
                        Button {
                            openAppStore()
                        } label: {
                            Image(.shortButtonBlue)
                                .overlay {
                                    Text("AppUpdate.OpenAppStore")
                                        .font(.neo18)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                }
                        }
                    }
                }
        }
    }
    
    // 앱 스토어로 이동
    func openAppStore() {
        let appStoreOpenUrlString = "itms-apps://itunes.apple.com/app/apple-store/6664073073"
        guard let url = URL(string: appStoreOpenUrlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    UpdateRequestView()
}
