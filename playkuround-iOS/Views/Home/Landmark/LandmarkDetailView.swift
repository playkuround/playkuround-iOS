//
//  LandmarkDetailView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/31/24.
//

import SwiftUI

struct LandmarkDetailView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @Binding var isDescriptionShowing: Bool
    
    var body: some View {
        ZStack {
            Image(.landmarkDetailBackground)
                .overlay {
                    VStack(spacing: 0) {
                        ZStack {
                            Image(.landmarkIconBackground)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                            
                            Image("landmark\(homeViewModel.getSelectedLandmark().number)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                        }
                        .padding(.bottom, 12)
                        
                        Text(homeViewModel.getSelectedLandmark().name)
                            .font(.neo20)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.bottom, 14)
                        
                        ScrollView {
                            Text(getRandomDescription())
                                .font(.pretendard15R)
                                .foregroundStyle(.kuText)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 260, height: 60)
                        .padding(.bottom, 56)
                        
                        Button {
                            isDescriptionShowing = false
                        } label: {
                            Image(.smallButtonBlue)
                                .overlay {
                                    Text(StringLiterals.Home.Landmark.close)
                                        .font(.neo18)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                }
                        }
                    }
                    .offset(y: 44)
                }
        }
    }
    
    private func getRandomDescription() -> String {
        let landmarkIndex = homeViewModel.getSelectedLandmark().number
        let descriptions: [String] = homeViewModel.landmarkDescriptions[landmarkIndex].description
        
        if descriptions.isEmpty {
            return ""
        } else {
            let randomIdx = Int.random(in: 0..<descriptions.count)
            return descriptions[randomIdx]
        }
    }
}

#Preview {
    LandmarkDetailView(homeViewModel: HomeViewModel(), isDescriptionShowing: .constant(true))
}
