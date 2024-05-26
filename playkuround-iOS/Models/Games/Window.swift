//
//  Window.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/23/24.
//

import SwiftUI

struct WindowComponent: Identifiable, Hashable {
    var id = UUID()
    let windowState: WindowState
    var windowType: WindowDuckkuType?
}

enum WindowState {
    case close
    case half
    case open
    case dummyLeft
    case dummyRight
    case dummyLeftBottom
    case dummyRightBottom
    case dummyBottom
}

enum WindowDuckkuType: String {
    case catchDuckkuWhite
    case catchDuckkuWhiteHit
    case catchDuckkuBlack
    case catchDuckkuBlackHit
}
