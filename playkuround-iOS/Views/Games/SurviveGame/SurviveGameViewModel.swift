//
//  SurviveGameViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/22/24.
//

import SwiftUI

final class SurviveGameViewModel: GameViewModel {
    @Published var duckkuPosX: CGFloat = 0.0
    @Published var duckkuPosY: CGFloat = 0.0
    
    // 덕쿠 이동 범위 제한
    private var frameMaxX: CGFloat = 0.0
    private var frameMaxY: CGFloat = 0.0
    
    func setFrameXY(x: CGFloat, y: CGFloat) {
        self.frameMaxX = x
        self.frameMaxY = y
    }
}
