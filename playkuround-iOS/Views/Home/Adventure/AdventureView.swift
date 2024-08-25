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
    
    private let soundManager = SoundManager.shared
    
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
                        
                        Image(.rouletteBackground)
                            .overlay {
                                Text(homeViewModel.gameName)
                                    .font(.neo22)
                                    .foregroundColor(.kuText)
                                    .kerning(-0.41)
                                    .opacity(homeViewModel.isGameNameShowing ? 1.0 : 0.0)
                            }
                            .padding(.bottom, 25)
                        
                        Button {
                            let selectedGame: ViewType? = homeViewModel.getSelectedGameStatus()
                            
                            homeViewModel.transition(to: .home)
                            
                            if let selectedGame = selectedGame {
                                viewModel.transition(to: selectedGame)
                            }
                            
                            soundManager.playSound(sound: .buttonClicked)
                        } label: {
                            Image(homeViewModel.isStartButtonEnabled ? .shortButtonBlue : .shortButtonGray)
                                .overlay {
                                    Text(StringLiterals.Home.startGame)
                                        .font(.neo18)
                                        .foregroundColor(.kuText)
                                        .kerning(-0.41)
                                }
                        }
                        .disabled(!homeViewModel.isStartButtonEnabled)
                    }
                }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.AdventureView, landmarkID: homeViewModel.getSelectedLandmark().number)
        }
    }
}

#Preview {
    AdventureView(viewModel: RootViewModel(), homeViewModel: HomeViewModel())
}
