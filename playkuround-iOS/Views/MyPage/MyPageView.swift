//
//  MyPageView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        ZStack {
            Color(.kuBackground).ignoresSafeArea(.all)
            
            VStack {
                MyPageProfileView()
                
                Rectangle()
                    .fill(.kuBlue3)
                    .frame(height: 11)
                    .padding(.top, 17)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MyPageView()
}
