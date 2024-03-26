//
//  MyPageProfileView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("건대콜럼버스스스님")
                .font(.neo20)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
            
            Text("컴퓨터공학부")
                .font(.neo15)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .padding(.top, 8)
            
            Image(.mypageCurrentScore)
                .overlay {
                    HStack {
                        Text(StringLiterals.MyPage.currentScore)
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .padding(.trailing, 15)
                        
                        Text("1,827점(129등)")
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }
                }
                .padding(.top, 20)
            
            Image(.mypageHighestScore)
                .overlay {
                    HStack {
                        Text(StringLiterals.MyPage.highestScore)
                            .font(.pretendard15R)
                            .foregroundStyle(.kuText)
                            .padding(.trailing, 15)
                        
                        Text("2,827점(1939등)")
                            .font(.neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }
                }
        }
    }
}

#Preview {
    MyPageProfileView()
}
