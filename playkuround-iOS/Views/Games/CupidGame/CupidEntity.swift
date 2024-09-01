//
//  CupidEntity.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 9/2/24.
//

import SwiftUI

struct CupidEntity: Hashable {
    let id: Int
    
    var posWhite: CGFloat
    var posBlack: CGFloat
    let frameMax: CGFloat
    let velocity: CGFloat
    var died: Bool
    
    init(id: Int, frameMax: CGFloat, velocity: CGFloat = 5.0) {
        self.id = id
        self.frameMax = frameMax
        self.velocity = velocity
        self.died = false
        
        self.posWhite = -self.frameMax / 2 + 40
        self.posBlack = self.frameMax / 2 - 40
    }
    
    mutating func updatePosition() {
        self.posWhite += self.velocity
        self.posBlack -= self.velocity
    }
    
    mutating func setDied() {
        self.died = true
    }
}
