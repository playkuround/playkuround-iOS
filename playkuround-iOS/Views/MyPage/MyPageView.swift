//
//  MyPageView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageView: View {
    @State private var isLogoutPresented: Bool = false
    @State private var isCheerPresented: Bool = false
    
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
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 20)
                .scrollIndicators(.hidden)
            }
            .padding(.top, 30)
            
            if isLogoutPresented {
                CheckLogoutView(isLogoutPresented: $isLogoutPresented)
            }
            
            if isCheerPresented {
                CheerPKTeamView(isCheerPresented: $isCheerPresented)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("logoutViewPresented"))) { _ in
            self.isLogoutPresented = true
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("cheerViewPresented"))) { _ in
            self.isCheerPresented = true
        }
    }
}

#Preview {
    MyPageView()
}
