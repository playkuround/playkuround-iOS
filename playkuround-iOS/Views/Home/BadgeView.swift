//
//  BadgeView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 6/2/24.
//

import SwiftUI

struct BadgeView: View {
    @ObservedObject var rootViewModel: RootViewModel
    
    var body: some View {
        ZStack {
            Image(.badgeBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack {
                    Image(.attendanceBadgeTable)
                        .overlay(alignment: .top) {
                            VStack {
                                Text(StringLiterals.Home.Badge.attendanceTitle)
                                    .font(.neo20)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuText)
                                    .padding(.top, 19)
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                                    ForEach(0..<10) {_ in
                                        Image(.engineering)
                                            .resizable()
                                            .frame(width: 56, height: 56)
                                    }
                                }
                                .padding(.top, 30)
                                .padding(.horizontal,40)
                            }
                        }
                        .padding(.bottom, 38)
                    
                    Image(.adventureBadgeTable)
                        .overlay(alignment: .top) {
                            VStack {
                                Text(StringLiterals.Home.Badge.adventureTitle)
                                    .font(.neo20)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuText)
                                    .padding(.top, 19)
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                                    ForEach(0..<28) {_ in
                                        Image(.badgeLock)
                                    }
                                }
                                .padding(.top, 30)
                                .padding(.horizontal, 40)
                            }
                        }
                }
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
            .customNavigationBar(centerView: {
                Text(StringLiterals.Home.Badge.title)
                    .font(.neo22)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
            }, leftView: {
                Button {
                    rootViewModel.transition(to: .badge)
                } label: {
                    Image(.leftWhiteArrow)
                }
            }, height: 42)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    BadgeView(rootViewModel: RootViewModel())
}
