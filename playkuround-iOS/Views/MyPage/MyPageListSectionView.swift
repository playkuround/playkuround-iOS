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
                .padding(.bottom, 10)
            
            ForEach(rowTitle, id: \.self) { title in
                MyPageListRowView(rowTitle: title)
            }
        }
        .padding(.top, 24)
    }
}
