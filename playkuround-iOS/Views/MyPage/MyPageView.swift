//
//  MyPageView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageView: View {
    private let myValues = [StringLiterals.MyPage.My.story, 
                            StringLiterals.MyPage.My.logout]
    private let shortcutValues = [StringLiterals.MyPage.Shortcut.instagram, 
                                  StringLiterals.MyPage.Shortcut.cheer]
    private let instructionValues = [StringLiterals.MyPage.Instruction.version, 
                                     StringLiterals.MyPage.Instruction.privacy,
                                     StringLiterals.MyPage.Instruction.terms]
    
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
                        MyPageListSectionView(sectionTitle: StringLiterals.MyPage.My.title,
                                              rowTitle: myValues)
                        
                        Rectangle()
                            .fill(.kuBlue3)
                            .frame(height: 1)
                            .padding(.top, 8)
                        
                        MyPageListSectionView(sectionTitle: StringLiterals.MyPage.Shortcut.title, 
                                              rowTitle: shortcutValues)
                        
                        Rectangle()
                            .fill(.kuBlue3)
                            .frame(height: 1)
                            .padding(.top, 8)
                        
                        MyPageListSectionView(sectionTitle: StringLiterals.MyPage.Instruction.title, 
                                              rowTitle: instructionValues)
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
