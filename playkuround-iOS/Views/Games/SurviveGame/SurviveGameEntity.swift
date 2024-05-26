//
//  SurviveGameEntityView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/22/24.
//

import SwiftUI

struct SurviveGameEntity: Hashable {
    let id = UUID()
    let type: SurviveGameEntityType
    let velocity: Double
    var angle: Angle
    var posX: CGFloat
    var posY: CGFloat
    
    let frameMaxX: CGFloat
    let frameMaxY: CGFloat
    
    init(type: SurviveGameEntityType, velocity: Double, angle: Double=0, frameMaxX: CGFloat, frameMaxY: CGFloat) {
        self.type = type
        self.velocity = velocity
        self.angle = Angle(degrees: angle)
        self.posX = 0.0
        self.posY = 0.0
        self.frameMaxX = frameMaxX
        self.frameMaxY = frameMaxY
        
        newPosition()
    }
    
    mutating func newPosition() {
        let quadrant = Int.random(in: 0..<4)
        
        if quadrant == 0 {
            // (x, -frameMaxY/2)
            let newX = Int.random(in: -Int(frameMaxX / 4)..<Int(frameMaxX / 4))
            let newY = -frameMaxY / 2 - 30
            let newAngle = Double(Int.random(in: 60..<120))
            
            self.posX = CGFloat(newX)
            self.posY = newY
            self.angle = Angle(degrees: newAngle)
        } else if quadrant == 1 {
            // (x, frameMaxY/2)
            let newX = Int.random(in: -Int(frameMaxX / 4)..<Int(frameMaxX / 4))
            let newY = frameMaxY / 2 + 30
            let newAngle = Double(Int.random(in: 240..<300))
            
            self.posX = CGFloat(newX)
            self.posY = newY
            self.angle = Angle(degrees: newAngle)
        } else if quadrant == 2 {
            // (-frameMaxX/2, y)
            let newX = -frameMaxX / 2 - 30
            let newY = Int.random(in: -Int(frameMaxY / 4)..<Int(frameMaxY / 4))
            let newAngle = Double(Int.random(in: 300..<420) % 360)
            
            self.posX = newX
            self.posY = CGFloat(newY)
            self.angle = Angle(degrees: newAngle)
        } else {
            // (frameMaxX/2, y)
            let newX = frameMaxX / 2 + 30
            let newY = Int.random(in: -Int(frameMaxY / 4)..<Int(frameMaxY / 4))
            let newAngle = Double(Int.random(in: 120..<240))
            
            self.posX = newX
            self.posY = CGFloat(newY)
            self.angle = Angle(degrees: newAngle)
        }
    }
    
    mutating func updatePosition() {
        if self.type == .bug {
            if Double.random(in: 0...1) < 0.5 {
                let randomAngle = angle.degrees + Double.random(in: -10..<10)
                withAnimation(.linear) {
                    self.angle = Angle(degrees: randomAngle)
                }
            }
        }
            
        let radians = angle.radians
        
        withAnimation(.linear(duration: 0.1)) {
            self.posX += CGFloat(velocity * cos(radians))
            self.posY += CGFloat(velocity * sin(radians))
        }
        
        // 만약 범위를 벗어났다면 새로운 위치로 이동
        if posX < -(frameMaxX / 2) - 40 || posX > (frameMaxX / 2) + 40 || posY < (-frameMaxY / 2) - 40 || posY > (frameMaxY / 2) + 40 {
            newPosition()
        }
    }
}

enum SurviveGameEntityType {
    case boat
    case bug
}
