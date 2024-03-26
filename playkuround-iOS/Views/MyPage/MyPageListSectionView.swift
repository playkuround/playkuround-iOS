//
//  MyPageListSectionView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageListSectionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("마이")
                .font(.neo18)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .padding(.bottom, 10)
            
            MyPageListRowView(rowTitle: "스토리 다시보기")
            MyPageListRowView(rowTitle: "로그아웃")
        }
    }
}

#Preview {
    MyPageListSectionView()
}
