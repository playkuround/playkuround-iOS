//
//  TotalRankingView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 6/5/24.
//

import SwiftUI

struct TotalRankingView: View {
    @ObservedObject var rootViewModel: RootViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var showmain: Bool = false
    
    var body: some View {
        ZStack {
            Image(.rankingBackground)
                .resizable()
                .ignoresSafeArea(.all)
            
            Color.black.opacity(0.2)
                .ignoresSafeArea(.all)
            
            VStack {
                Image(.rankingTable)
            }
            .customNavigationBar(centerView: {
                Text(StringLiterals.Home.TotalRanking.title)
                    .font(.neo22)
                    .kerning(-0.41)
                    .foregroundStyle(.white)
            }, leftView: {
                Button {
                    homeViewModel.transition(to: .home)
                } label: {
                    Image(.leftWhiteArrow)
                }
            }, rightView: {
                Button {
                    showmain.toggle()
                } label: {
                    Image(.rankingInformationButton)
                }
            }, height: 50)
            
            if showmain {
                TotalRankingInformationView(backToMain: $showmain)
            }
        }
    }
}

#Preview {
    TotalRankingView(rootViewModel: RootViewModel(), homeViewModel: HomeViewModel())
}
