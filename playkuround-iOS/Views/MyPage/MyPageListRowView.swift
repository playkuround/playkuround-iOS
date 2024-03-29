//
//  MyPageListRowView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageListRowView: View {
    let rowTitle: String
    
    var body: some View {
        HStack {
            Text(rowTitle)
                .font(.pretendard15R)
                .foregroundStyle(.kuText)
                .padding(.top, 18)
            
            Spacer()
        }
    }
}
