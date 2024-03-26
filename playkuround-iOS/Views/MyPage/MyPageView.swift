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
            
            VStack(alignment: .leading) {
                Text("건대콜럼버스스스님")
                    .font(.neo20)
                    .foregroundStyle(.kuText)
                
                Text("컴퓨터공학부")
                    .font(.neo15)
                    .foregroundStyle(.kuText)
                    .padding(.top, 8)
            }
        }
    }
}

#Preview {
    MyPageView()
}
