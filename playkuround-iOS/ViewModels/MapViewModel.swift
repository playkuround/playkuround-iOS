//
//  MapViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/25/24.
//

import Combine
import CoreLocation
import Foundation
import MapKit
import SwiftUI

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?

    @Published var isAuthorized: CLAuthorizationStatus = .notDetermined
    
    // 사용자의 최신 위치 데이터
    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    @Published var userHeading: Double = 0
    
    // MapViewModel Instance화 시 권한 요청하려면 아래 initializer 사용
    /* override init() {
        super.init()
        requestLocationAuthorization()
    }*/
    
    // 사용자의 랜드마크
    @Published var userLandmarkID: Int?
    
    @ObservedObject var rootViewModel: RootViewModel
    
    init(rootViewModel: RootViewModel) {
        self.rootViewModel = rootViewModel
    }
    
    func requestLocationAuthorization() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        DispatchQueue.global().async {
            guard let locationManager = self.locationManager else { return }
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        print("location manager status: \(locationManager.authorizationStatus)")
        isAuthorized = locationManager.authorizationStatus

        switch locationManager.authorizationStatus {
        case .notDetermined:
            print("not determined")
            requestLocationAuthorization()
        case .restricted:
            print("restricted")
            requestLocationAuthorization()
        case .denied:
            print("denied")
            requestLocationAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("allowed")
            break
        @unknown default:
            break
        }

        isAuthorized = locationManager.authorizationStatus
        print("isAuthorized: \(isAuthorized)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    // 이 함수 호출 시 사용자 위치 정보 업데이트 시작
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
        self.locationManager?.startUpdatingHeading()
    }
    
    // 이 함수 호출 시 사용자 위치 정보 업데이트 중지
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
        self.locationManager?.stopUpdatingHeading()
    }
    
    // 사용자의 위치 정보 실시간으로 업데이트
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        userHeading = heading.trueHeading
    }
    
    // 사용자가 권한 거부 시 설정으로 직접 이동하는 함수
    // Apple 정책 상 사용자가 한 번 위치 권한 거절 시 앱에서 재요청 불가, 사용자가 직접 설정 가서 켜야 함
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    // 사용자 랜드마크 업데이트
    func updateLandmark() {
        APIManager.callGETAPI(endpoint: .landmarks,
                              querys: ["latitude": userLatitude,
                                       "longitude": userLongitude]) { result in
            switch result {
            case .success(let data):
                if let response = data as? APIResponse {
                    self.userLandmarkID = response.response?.landmarkId ?? nil
                    print("userLandmarkID: \(self.userLandmarkID ?? -1)")
                }
            case .failure(let error):
                print("Error in View: \(error)")
                self.userLandmarkID = nil
            }
        }
    }
}

struct MapViewTestView: View {
    @ObservedObject var vm: MapViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("isAuthorized: \(vm.isAuthorized.rawValue.description)")
            Text("Location: (\(vm.userLatitude), \(vm.userLongitude))")
            Text("Heading: \(vm.userHeading)")
            
            if let landmarkID = vm.userLandmarkID {
                // 인덱스는 1부터 시작하며, 0번째는 더미 노드가 있으므로 인덱스를 그래도 사용 가능
                let landmark = landmarkList[landmarkID]
                Text("근처 랜드마크: \(landmark.name)(\(landmark.number))")
            } else {
                Text("근처 랜드마크: 없음(nil)")
            }
            
            Button("권한 체크 및 요청") {
                // 위치 권한 체크, 권한 없는 경우 요청
                vm.requestLocationAuthorization()
            }
            .buttonStyle(.borderedProminent)
            
            Button("업데이트 시작") {
                vm.startUpdatingLocation()
            }
            .buttonStyle(.borderedProminent)
            
            Button("업데이트 중지") {
                vm.stopUpdatingLocation()
            }
            .buttonStyle(.borderedProminent)
            
            Button("설정으로") {
                vm.openSettings()
            }
            .buttonStyle(.borderedProminent)
            
            Button("랜드마크 업데이트") {
                vm.updateLandmark()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    @ObservedObject var vm = MapViewModel(rootViewModel: RootViewModel())
    
    return Group {
        MapViewTestView(vm: vm)
    }
}
