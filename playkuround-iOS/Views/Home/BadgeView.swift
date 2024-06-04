//
//  BadgeView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 6/2/24.
//

import SwiftUI

struct BadgeView: View {
    var body: some View {
        ZStack {
            Image(.badgeBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                Image(.attendanceBadgeTable)
            }
        }
    }
}

#Preview {
    BadgeView()
}
