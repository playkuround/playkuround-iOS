//
//  AdventureView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 6/24/24.
//

import SwiftUI

struct AdventureView: View {
    @ObservedObject var viewModel: RootViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            
            Image(.adventureBackground)
                .overlay {
                    VStack(spacing: 0) {
                        ZStack {
                            Image(.adventureFrame)
                                .resizable()
                                .frame(width: 98, height: 98)
                            Image("landmark\(homeViewModel.getSelectedLandmark().number)")
                                .resizable()
                                .frame(width: 90, height: 90)
                        }
                        .padding(.bottom, 14)
                        
                        Text(homeViewModel.getSelectedLandmark().name)
                            .font(.neo20)
                            .foregroundColor(.kuText)
                            .kerning(-0.41)
                            .padding(.bottom, 12)
                        
                        // TODO: 룰렛 구현
                        Image(.rouletteBackground)
                            .overlay {
                                Text("수강신청 올 클릭")
                                    .font(.neo22)
                                    .foregroundColor(.kuText)
                                    .kerning(-0.41)
                            }
                            .padding(.bottom, 25)
                        
                        Button {
                            // TODO: 선택된 게임으로 이동
                            // viewModel.transition(to: selectedGame)
                        } label: {
                            Image(.shortButtonBlue)
                                .overlay {
                                    Text("게임 시작")
                                        .font(.neo18)
                                        .foregroundColor(.kuText)
                                        .kerning(-0.41)
                                }
                        }
                    }
                }
        }
    }
}

#Preview {
    AdventureView(viewModel: RootViewModel(), homeViewModel: HomeViewModel())
}
