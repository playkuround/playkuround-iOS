//
//  MyPageListSectionView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageListSectionView: View {
    let sectionTitle: String
    let rowTitle: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sectionTitle)
                .font(.neo18)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .padding(.top, 18)
            
            ForEach(rowTitle, id: \.self) { title in
                if title == StringLiterals.MyPage.Shortcut.instagram.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            linkInstagramURL()
                        }
                }
                else {
                    MyPageListRowView(rowTitle: title)
                }
            }
        }
    }
    
    private func linkInstagramURL() {
        if let instagramURL = URL(string: StringLiterals.MyPage.instagramURL) {
            UIApplication.shared.open(instagramURL)
        }
    }
}

#Preview {
    MyPageView()
}
