//
//  MapView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/30/24.
//

import CoreLocation
import MapKit
import SwiftUI

@available(iOS 17, *)
struct MapViewiOS17 : View {
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State var mapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 37.542_634, longitude: 127.076_769), distance: 2000, heading: 0.0, pitch: 0))
    
    let mapCameraBounds: MapCameraBounds = MapCameraBounds(centerCoordinateBounds: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.542_634, longitude: 127.076_769), span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.012)), minimumDistance: 700, maximumDistance: 3000)
    
    private let soundManager = SoundManager.shared
    
    init(mapViewModel: MapViewModel, homeViewModel: HomeViewModel) {
        self.mapViewModel = mapViewModel
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        Map(initialPosition: mapCameraPosition, bounds: mapCameraBounds) {
            ForEach(Array(homeViewModel.landmarkList.enumerated()), id: \.offset) { index, landmark in
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: landmark.latitude, longitude: landmark.longitude)) {
                    Image(.landmarkFlag)
                        .onTapGesture {
                            homeViewModel.openLandmarkView(landmarkID: landmark.number)
                            soundManager.playSound(sound: .buttonClicked)
                        }
                }
            }
            
            Annotation("", coordinate: CLLocationCoordinate2D(latitude: mapViewModel.userLatitude, longitude: mapViewModel.userLongitude)) {
                Image(.userAnnotation)
            }
        }
        .onAppear {
            mapViewModel.startUpdatingLocation()
        }
        .onDisappear {
            mapViewModel.stopUpdatingLocation()
        }
    }
}

struct EquatableMKCoordinateRegion: Equatable {
    var region: MKCoordinateRegion

    static func == (lhs: EquatableMKCoordinateRegion, rhs: EquatableMKCoordinateRegion) -> Bool {
        return lhs.region.center.latitude == rhs.region.center.latitude &&
               lhs.region.center.longitude == rhs.region.center.longitude &&
               lhs.region.span.latitudeDelta == rhs.region.span.latitudeDelta &&
               lhs.region.span.longitudeDelta == rhs.region.span.longitudeDelta
    }
}

@available(iOS 16, *)
struct MapViewiOS16: View {
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    private let minLatitudeDelta: CLLocationDegrees = 0.002
    private let maxLatitudeDelta: CLLocationDegrees = 0.011
    private let kuBounds = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.541_384, longitude: 127.076_479),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @State private var region = EquatableMKCoordinateRegion(region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.542_634, longitude: 127.076_769), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)))
    @State private var annotationList: [AnnotationWrapper] = []
    
    private let soundManager = SoundManager.shared
    
    let landmarkList: [Landmark]
    
    init(mapViewModel: MapViewModel, homeViewModel: HomeViewModel) {
        self.mapViewModel = mapViewModel
        self.homeViewModel = homeViewModel
        
        let currentLanguage = Locale.current.language.languageCode?.identifier
        
        switch currentLanguage {
        case "ko":
            self.landmarkList = landmarkListKorean
        case "en":
            self.landmarkList = landmarkListEnglish
        case "zh":
            self.landmarkList = landmarkListChinese
        default:
            self.landmarkList = landmarkListKorean
        }
    }
    
    var body: some View {
        let sortedAnnList = annotationList.sorted { $0.landmark.number > $1.landmark.number }
        
        Map(coordinateRegion: $region.region, annotationItems: sortedAnnList) { annotation in
            if annotation.type == .landmark {
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: annotation.landmark.latitude, longitude: annotation.landmark.longitude)) {
                    // getAnnotation(annotation)
                    CustomMapAnnotationView(annotation: annotation, mapViewModel: mapViewModel)
                        .onTapGesture {
                            homeViewModel.openLandmarkView(landmarkID: annotation.landmark.number)
                            soundManager.playSound(sound: .buttonClicked)
                        }
                        .allowsHitTesting(true)
                }
            } else {
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: mapViewModel.userLatitude, longitude: mapViewModel.userLongitude)) {
                    CustomMapAnnotationView(annotation: annotation, mapViewModel: mapViewModel)
                        .onTapGesture { } // Not Used (MapKit 특성 상 대칭을 맞춰주어야 함)
                        .allowsHitTesting(false) // 덕쿠 터치 무시
                }
            }
        }
        .onChange(of: region) { newRegion in
            enforceZoomLimits()
            enforceRegionBounds()
        }
        .onAppear {
            mapViewModel.startUpdatingLocation()
            self.annotationList = self.getAnnotationList()
        }
        .onDisappear {
            mapViewModel.stopUpdatingLocation()
        }
    }
    
    private func enforceZoomLimits() {
        if region.region.span.latitudeDelta < minLatitudeDelta {
            region.region.span.latitudeDelta = minLatitudeDelta
        } else if region.region.span.longitudeDelta < minLatitudeDelta {
            region.region.span.longitudeDelta = minLatitudeDelta
        }
        
        if region.region.span.latitudeDelta > maxLatitudeDelta {
            region.region.span.latitudeDelta = maxLatitudeDelta
        } else if region.region.span.longitudeDelta > maxLatitudeDelta {
            region.region.span.longitudeDelta = maxLatitudeDelta
        }
    }
    
    private func enforceRegionBounds() {
        let latitude = min(max(region.region.center.latitude, kuBounds.center.latitude - kuBounds.span.latitudeDelta / 2), kuBounds.center.latitude + kuBounds.span.latitudeDelta / 2)
        let longitude = min(max(region.region.center.longitude, kuBounds.center.longitude - kuBounds.span.longitudeDelta / 2), kuBounds.center.longitude + kuBounds.span.longitudeDelta / 2)
        region.region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // iOS16의 MapKit에서 Landmark Ann과 User Ann을 하나로 합쳐주기 위한 wrapper 인터페이스
    private func getAnnotationList() -> [AnnotationWrapper] {
        var annotationList: [AnnotationWrapper] = [AnnotationWrapper(type: .user, landmark: landmarkList[0])]
        
        for landmark in landmarkList {
            // 예외 처리 (36번 삭제됨)
            if landmark.number != 36 {
                annotationList.append(AnnotationWrapper(type: .landmark, landmark: landmark))
            }
        }
        
        return annotationList
    }
}

#Preview {
    ZStack {
        if #available(iOS 17, *) {
            MapViewiOS17(mapViewModel: MapViewModel(rootViewModel: RootViewModel()), homeViewModel: HomeViewModel(rootViewModel: RootViewModel()))
        }
        else {
            MapViewiOS16(mapViewModel: MapViewModel(rootViewModel: RootViewModel()), homeViewModel: HomeViewModel(rootViewModel: RootViewModel()))
        }
    }
}
