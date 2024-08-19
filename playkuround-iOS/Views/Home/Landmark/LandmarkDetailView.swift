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
    
    let items: [Amenity] = [Amenity(type: .cafe, description: "카페"),
                            Amenity(type: .copy, description: "복사기"),
                            Amenity(type: .certificate, description: "증명서발급기"),
                            Amenity(type: .convenience, description: "편의점")]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            
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
                        
                        Text(homeViewModel.getSelectedLandmark().name)
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.bottom, 14)
                        
                        WrappingHStack(data: items, spacing: 8, lineSpacing: 8) { item in
                            AmenityBoxView(amenity: item)
                                // .padding()
                                // .background(Color.gray.opacity(0.2))
                                // .cornerRadius(5)
                        }
                        .padding(.horizontal, 36)
                        .border(Color.gray)
                    }
                }
        }
        .onAppear() {
            homeViewModel.selectedLandmarkID = 1
        }
    }
    
    enum AmenityType: String, Decodable, Hashable {
        case none
        case kCube = "kCubeIcon"// 케이큐브/케이허브
        case convenience = "convenienceIcon" // 편의점
        case cafe = "cafeIcon" // 카페
        case bike = "bikeIcon" // 따릉이
        case copy = "copyIcon" // 복사기
        case book = "bookIcon" // 도서반납기
        case certificate = "certificateIcon" // 증명서발급기
    }
    
    struct Amenity: Identifiable, Decodable, Hashable {
        var id = UUID()
        var type: AmenityType
        var description: String
    }
    
    @ViewBuilder
    func AmenityBoxView(amenity: Amenity) -> some View {
        HStack(spacing: 5) {
            if amenity.type == .none {
                Text(amenity.description)
                    .padding(.horizontal, 8)
                    .font(.neo13)
                    .foregroundColor(.kuText)
                    .kerning(-0.41)
            } else {
                Image(amenity.type.rawValue)
                    .padding(.leading, 8)
                
                Text(amenity.description)
                    .padding(.trailing, 8)
                    .font(.neo13)
                    .foregroundColor(.kuText)
                    .kerning(-0.41)
            }
        }
        .frame(height: 25)
        .background(Color.white)
        .border(Color.gray, width: 1)
        
    }
}

struct WrappingHStack<Data: RandomAccessCollection & BidirectionalCollection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let lineSpacing: CGFloat
    let content: (Data.Element) -> Content

    @State private var totalHeight: CGFloat = 0 // height of the HStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.contentLayer(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func contentLayer(in geometry: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var height: CGFloat = 0

        return ZStack(alignment: .topLeading) {
            ForEach(data, id: \.self) { item in
                content(item)
                    .padding(.horizontal, spacing / 2)
                    .alignmentGuide(.leading, computeValue: { dimensions in
                        if (abs(width - dimensions.width) > geometry.size.width) {
                            width = 0
                            height -= dimensions.height + lineSpacing // Add line spacing when moving to a new row
                        }
                        let result = width
                        if item == data.last {
                            width = 0 // last item
                        } else {
                            width -= dimensions.width + spacing
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { dimensions in
                        let result = height
                        if item == data.last {
                            height = 0 // reset
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    private func viewHeightReader(_ height: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                height.wrappedValue = geometry.frame(in: .local).size.height
            }
            return .clear
        }
    }
}

struct LandmarkDetailViewLegacy: View {
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
                                .lineSpacing(15 * 0.3)
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
        .onAppear() {
            homeViewModel.selectedLandmarkID = 1
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

#Preview {
    LandmarkDetailViewLegacy(homeViewModel: HomeViewModel(), isDescriptionShowing: .constant(true))
}
