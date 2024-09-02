//
//  MotionManager.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/24/24.
//

import SwiftUI
import CoreMotion
import Combine

class MotionManager: ObservableObject {
    private var motionManager: CMMotionManager
    private var timer: Timer?
    
    @Published var gyroData: CMGyroData?
    @Published var accelerometerData: CMAccelerometerData?
    
    init() {
        self.motionManager = CMMotionManager()
        
        guard motionManager.isGyroAvailable else {
            print("Gyroscope is not available")
            return
        }
        
        motionManager.gyroUpdateInterval = 0.01
        motionManager.startGyroUpdates()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            if let data = self?.motionManager.gyroData {
                DispatchQueue.main.async {
                    self?.gyroData = data
                }
            }
        }
        
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer is not available")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
            [weak self] _ in
            if let data = self?.motionManager.accelerometerData {
                DispatchQueue.main.async {
                    self?.accelerometerData = data
                }
            }
        }
    }
    
    deinit {
        motionManager.stopGyroUpdates()
        timer?.invalidate()
    }
}
