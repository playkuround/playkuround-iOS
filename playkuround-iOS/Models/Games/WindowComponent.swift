//
//  WindowComponent.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/30/24.
//

import Foundation

struct WindowComponent: Identifiable, Hashable {
    var id = UUID()
    let windowState: WindowState
    var windowType: WindowDuckkuType
}
