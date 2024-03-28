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
                
                ScrollView {
                    VStack(alignment: .leading) {
                        MyPageListSectionView(sectionTitle: StringLiterals.MyPage.Title.my,
                                              rowTitle: StringLiterals.MyPage.My.allCases.map { $0.rawValue })
                        
                        Rectangle()
                            .fill(.kuBlue3)
                            .frame(height: 1)
                            .padding(.top, 8)
                        
                        MyPageListSectionView(sectionTitle: StringLiterals.MyPage.Title.shortcut,
                                              rowTitle: StringLiterals.MyPage.Shortcut.allCases.map { $0.rawValue })
                        
                        Rectangle()
                            .fill(.kuBlue3)
                            .frame(height: 1)
                            .padding(.top, 8)
                        
                        MyPageListSectionView(sectionTitle: StringLiterals.MyPage.Title.instruction,
                                              rowTitle: StringLiterals.MyPage.Instruction.allCases.map { $0.rawValue })
                    }
                }
                .padding(.horizontal, 20)
                .scrollIndicators(.hidden)
            }
            .padding(.top, 30)
        }
    }
}

#Preview {
    MyPageView()
}
