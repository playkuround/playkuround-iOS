//
//  MapView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/30/24.
//

import CoreLocation
import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.542_634, longitude: 127.076_769), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
    @State private var annotationList: [AnnotationWrapper] = []
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotationList) { annotation in
            if annotation.type == .landmark {
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: annotation.landmark.latitude, longitude: annotation.landmark.longitude)) {
                    // getAnnotation(annotation)
                    CustomMapAnnotationView(annotation: annotation, mapViewModel: mapViewModel)
                        .onTapGesture {
                            homeViewModel.openLandmarkView(landmarkID: annotation.landmark.number)
                        }
                }
            } else {
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: mapViewModel.userLatitude, longitude: mapViewModel.userLongitude)) {
                    CustomMapAnnotationView(annotation: annotation, mapViewModel: mapViewModel)
                        .onTapGesture { } // Not Used (MapKit 특성 상 대칭을 맞춰주어야 함)
                }
            }
        }
        .onAppear {
            mapViewModel.startUpdatingLocation()
            self.annotationList = self.getAnnotationList()
        }
        .onDisappear {
            mapViewModel.stopUpdatingLocation()
        }
    }
    
    // iOS16의 MapKit에서 Landmark Ann과 User Ann을 하나로 합쳐주기 위한 wrapper 인터페이스
    private func getAnnotationList() -> [AnnotationWrapper] {
        var annotationList: [AnnotationWrapper] = [AnnotationWrapper(type: .user, landmark: landmarkList[0])]
        
        for landmark in landmarkList {
            annotationList.append(AnnotationWrapper(type: .landmark, landmark: landmark))
        }
        
        return annotationList
    }
}

#Preview {
    MapView(mapViewModel: MapViewModel(), homeViewModel: HomeViewModel())
}
