//
//  UIApplication+.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/31/24.
//

import SwiftUI
import Combine

// 키보드 닫기 함수
extension UIApplication {
    func dismissKeyboard() {
        guard let windowScene = connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows
            .first { $0.isKeyWindow }?
            .endEditing(true)
    }
}
