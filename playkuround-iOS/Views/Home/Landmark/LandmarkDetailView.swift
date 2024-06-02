//
//  LandmarkDetailView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/31/24.
//

import SwiftUI

struct LandmarkDetailView: View {
    // @ObservedObject var homeViewModel: HomeViewModel
    @Binding var isDescriptionShowing: Bool
    
    var body: some View {
        ZStack {
            Image(.landmarkDetailBackground)
            Image(systemName: "star")
                .overlay {
                    VStack(spacing: 0) {
                        ZStack {
                            Image(.landmarkIconBackground)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                            
                            // Image("landmark\(homeViewModel.getSelectedLandmark().number)")
                            Image("landmark\(1)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                        }
                        .padding(.bottom, 12)
                        
                        // Text(homeViewModel.getSelectedLandmark().name)
                        Text(landmarkList[1].name)
                            .font(.neo20)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.bottom, 14)
                        
                        ScrollView {
                            // Text(getRandomDescription())
                            Text("Landmark Description Here")
                                .font(.pretendard15R)
                                .foregroundStyle(.kuText)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 260, height: 60)
                        .padding(.bottom, 56)
                        
                        Button {
                            withAnimation(.spring(duration: 0.2, bounce: 0.3)) {
                                isDescriptionShowing = false
                            }
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
    
    /* private func getRandomDescription() -> String {
        let landmarkIndex = homeViewModel.getSelectedLandmark().number
        var descriptions: [String] = homeViewModel.landmarkDescriptions[landmarkIndex].description
        
        if descriptions.isEmpty {
            return ""
        } else {
            descriptions.shuffle()
            return descriptions[0]
        }
    }*/
}

#Preview {
    // LandmarkDetailView(homeViewModel: HomeViewModel(), isDescriptionShowing: .constant(true))
    LandmarkDetailView(isDescriptionShowing: .constant(true))
}
