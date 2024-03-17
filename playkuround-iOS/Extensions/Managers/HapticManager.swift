//
//  HapticManager.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/17/24.
//

import UIKit

class HapticManager {
    // 싱글톤 생성
    static let shared = HapticManager()
    
    // warning, error, success
    func hapticNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    // heavy, light, meduium, rigid, soft
    func hapticImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
