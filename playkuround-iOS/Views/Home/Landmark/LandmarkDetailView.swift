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
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    isDescriptionShowing = false
                }
            
            Image(.landmarkDetailLongBackground)
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
                        .padding(.top, 112)
                        
                        Text(homeViewModel.getSelectedLandmark().name)
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.bottom, 8)
                        
                        let landmarkIndex = homeViewModel.getSelectedLandmark().number
                        let amenities: [String] = homeViewModel.landmarkDescriptions[landmarkIndex].amenity
                        
                        LeadingFlexBox(horizontalSpacing: 8.0, verticalSpacing: 8.0) {
                            ForEach(Array(amenities.enumerated()), id: \.offset) { index, amenity in
                                AmenityBoxView(amenity)
                            }
                        }
                        .padding(.horizontal, 36)
                        .padding(.bottom, 16)
                        
                        Image(.middleLine)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 36)
                        
                        ScrollView(.vertical) {
                            VStack(spacing: 8) {
                                Text("Home.Landmark.BuildingDescriptionTitle")
                                    .font(.neo18)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuText)
                                
                                let description = homeViewModel.landmarkDescriptions[landmarkIndex].description
                                
                                Text(description)
                                    .font(.pretendard15R)
                                    .foregroundStyle(.kuText)
                                    .multilineTextAlignment(.center)
                                
                                let information = homeViewModel.landmarkDescriptions[landmarkIndex].information
                                
                                ForEach(Array(information.enumerated()), id: \.offset) { index, info in
                                    Text(info.title)
                                        .font(.neo18)
                                        .kerning(-0.41)
                                        .foregroundStyle(.kuText)
                                        .padding(.top, 12)
                                    
                                    Text(info.content)
                                        .font(.pretendard15R)
                                        .foregroundStyle(.kuText)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .padding(.vertical, 18)
                        }
                        .padding(.horizontal, 36)
                        
                        Button {
                            isDescriptionShowing = false
                            soundManager.playSound(sound: .buttonClicked)
                        } label: {
                            Image(.smallButtonBlue)
                                .overlay {
                                    Text("Home.Landmark.Close")
                                        .font(.neo18)
                                        .kerning(-0.41)
                                        .foregroundStyle(.kuText)
                                }
                        }
                        .padding(.top, 4)
                        .padding(.bottom, 40)
                    }
                }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.LandmarkDetailView,
                                            landmarkID: homeViewModel.getSelectedLandmark().number)
        }
    }
    
    @ViewBuilder
    func AmenityBoxView(_ amenity: String) -> some View {
        HStack(spacing: 5) {
            // 종류: {'도서반납기', '복사실', '케이큐브', '증명발급서비스', '복사기', '증명서발급기', '편의점', '카페', '따릉이'}
            if (amenity == "복사실" || amenity == "복사기") {
                Image(.copyIcon)
                    .padding(.leading, 8)
            } else if (amenity == "도서반납기") {
                Image(.bookIcon)
                    .padding(.leading, 8)
            } else if (amenity == "케이큐브" || amenity == "케이허브") {
                Image(.kCubeIcon)
                    .padding(.leading, 8)
            } else if (amenity == "증명발급서비스" || amenity == "증명서발급기") {
                Image(.certificateIcon)
                    .padding(.leading, 8)
            } else if (amenity == "편의점") {
                Image(.convenienceIcon)
                    .padding(.leading, 8)
            } else if (amenity == "카페") {
                Image(.cafeIcon)
                    .padding(.leading, 8)
            } else if (amenity == "따릉이") {
                Image(.bikeIcon)
                    .padding(.leading, 8)
            }
            
            Text(amenity)
                .padding(.trailing, 8)
                .font(.neo13)
                .foregroundColor(.kuText)
                .kerning(-0.41)
        }
        .frame(height: 25)
        .background(Color.white)
        .border(Color.gray, width: 1)
    }
}

#Preview {
    LandmarkDetailView(homeViewModel: HomeViewModel(rootViewModel: RootViewModel()), isDescriptionShowing: .constant(true))
}
