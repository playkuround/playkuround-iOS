//
//  SurviveGameViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/22/24.
//

import Combine
import CoreGraphics
import CoreMotion
import SwiftUI

final class SurviveGameViewModel: GameViewModel {
    // 덕쿠 위치
    @Published var duckkuPosX: CGFloat = 0.0
    @Published var duckkuPosY: CGFloat = 0.0
    
    // 덕쿠 이동 범위 제한
    private var frameMaxX: CGFloat = 0.0
    private var frameMaxY: CGFloat = 0.0
        
    // 덕쿠 속도 및 가속도
    private var velocityX: CGFloat = 0.0
    private var velocityY: CGFloat = 0.0
    private var accelerationX: CGFloat = 0.0
    private var accelerationY: CGFloat = 0.0
    
    // 자이로스코프 누적 값
    private var gyroCummX: Double = 0.0
    private var gyroCummY: Double = 0.0
    
    // motion Manager
    private var motionManager: MotionManager
    private var cancellables = Set<AnyCancellable>()
    
    // 미생물 개수
    @Published var numBug: Int = 10
    
    @Published var bugList: [SurviveGameEntity] = []
    @Published var boatList: [SurviveGameEntity] = []
    
    // 피격 시 무적 flag
    @Published var isImmuned: Bool = true
    // 피격 시 반투명해짐
    @Published var isTransparent: Bool = false
    
    // 생명
    @Published var life: Int = 3
    
    let soundManager = SoundManager.shared
    
    init(rootViewModel: RootViewModel, mapViewModel: MapViewModel) {
        self.motionManager = MotionManager()
        super.init(.catchDucku, rootViewModel: rootViewModel, mapViewModel: mapViewModel, timeStart: 60.0, timeEnd: 0.0, timeInterval: 0.01)
        setupGyroUpdates()
    }
    
    override func startGame() {
        self.addBug(10)
        self.addBoat(2)
        
        super.startGame()
        super.startTimer()
        self.isImmuned = false
    }
    
    override func timerDone() {
        finishGame()
    }
    
    override func finishGame() {
        super.pauseOrRestartTimer()
        DispatchQueue.main.async {
            self.isTimerUpdating = false
            self.gameState = .finish
            
            // 서버로 점수 업로드
            super.uploadResult(uploadScore: self.score)
        }
    }
    
    func setFrameXY(x: CGFloat, y: CGFloat) {
        self.frameMaxX = x
        self.frameMaxY = y
    }
    
    private func updateDuckkuPos(x: Double, y: Double, z: Double) {
        if !self.isTimerUpdating {
            return
        }
        
        DispatchQueue.main.async {
            self.gyroCummX += x * 0.1
            self.gyroCummY += y * 0.1
            
            self.gyroCummX = min(max(self.gyroCummX, -2), 2)
            self.gyroCummY = min(max(self.gyroCummY, -2), 2)
            
            // Gyro data scaling factor
            let scalingFactor: CGFloat = 1.0
            let damping: CGFloat = 0.5
            
            // Update acceleration based on gyro data
            self.accelerationX = CGFloat(self.gyroCummY) * scalingFactor
            self.accelerationY = CGFloat(self.gyroCummX) * scalingFactor
            
            // Update velocity with damping to simulate friction
            self.velocityX += self.accelerationX
            self.velocityY += self.accelerationY
            self.velocityX *= damping
            self.velocityY *= damping
            
            // Update positions
            let newX = self.duckkuPosX + self.velocityX
            let newY = self.duckkuPosY + self.velocityY
            
            // Constrain positions within frame
            self.duckkuPosX = min(max(newX, -self.frameMaxX / 2), self.frameMaxX / 2)
            self.duckkuPosY = min(max(newY, -self.frameMaxY / 2), self.frameMaxY / 2)
        }
    }
    
    private func setupGyroUpdates() {
        motionManager.$gyroData
            .compactMap { $0 }
            .sink { [weak self] data in
                self?.updateDuckkuPos(x: data.rotationRate.x, y: data.rotationRate.y, z: data.rotationRate.z)
            }
            .store(in: &cancellables)
    }
    
    func updateEntityPos() {
        for i in bugList.indices {
            bugList[i].updatePosition()
        }
        
        for i in boatList.indices {
            boatList[i].updatePosition()
        }
        
        if !self.isImmuned {
            checkHit()
        }
    }
    
    func checkHit() {
        let duckkuRect = CGRect(x: self.duckkuPosX - (33 / 2), y: self.duckkuPosY - (33 / 2), width: 33, height: 33)
        // print("check hitting \(duckkuRect)")
        
        for i in bugList.indices {
            // 연산량을 줄이기 위해 L1 거리가 100 이하인 경우만 계산
            if distanceL1(x1: self.duckkuPosX, x2: bugList[i].posX, y1: self.duckkuPosY, y2: bugList[i].posY) > 100 {
                continue
            }
            
            let bugRect = CGRect(x: bugList[i].posX - (13 / 2), y: bugList[i].posY - (21 / 2), width: 13, height: 21)
            
            if duckkuRect.intersects(bugRect) {
                duckkuHit()
                return
            }
        }
        
        let duckkuRectPoints = [CGPoint(x: self.duckkuPosX - (33 / 2), y: self.duckkuPosY - (33 / 2)),
                                CGPoint(x: self.duckkuPosX - (33 / 2), y: self.duckkuPosY + (33 / 2)),
                                CGPoint(x: self.duckkuPosX + (33 / 2), y: self.duckkuPosY + (33 / 2)),
                                CGPoint(x: self.duckkuPosX + (33 / 2), y: self.duckkuPosY - (33 / 2))]
        
        for i in boatList.indices {
            // 연산량을 줄이기 위해 L1 거리가 200 이하인 경우만 계산
            if distanceL1(x1: self.duckkuPosX, x2: boatList[i].posX, y1: self.duckkuPosY, y2: boatList[i].posY) > 200 {
                continue
            }
            
            // 보트 좌표
            let boatPoint1 = CGPoint(x: Int(boatList[i].posX - (82 / 2)), y: Int(boatList[i].posY - (27 / 2)))
            let boatPoint2 = CGPoint(x: Int(boatList[i].posX + (82 / 2)), y: Int(boatList[i].posY + (27 / 2)))
            
            // 회전된 보트 좌표를 계산
            let (rotatedP1, rotatedP2, rotatedP3, rotatedP4) = rotatedRectangle(boatPoint1, boatPoint2, by: boatList[i].angle.degrees)
            
            // 회전된 보트 좌표 리스트
            let boatRectPoints = [rotatedP1, rotatedP2, rotatedP3, rotatedP4]
            
            // 보트와 덕쿠 겹치는지 검사
            let isOverlapping = polygonsOverlap(duckkuRectPoints, boatRectPoints)
            
            if isOverlapping {
                // MARK: 디버깅용, merge 전 삭제 예정
                print("duckku pos (\(duckkuPosX), \(duckkuPosY))")
                print("hit with boat rect (\(boatPoint1)), (\(boatPoint2))")
                print("rotated rect (\(boatRectPoints)) by \(boatList[i].angle.degrees)")
                duckkuHit()
                return
            }
        }
    }
    
    func updateNumBug() {
        let remainingSecond = Int(self.timeRemaining * 100) / 100
        var newNumBug = 10
        
        // 남은 초별로 num을 업데이트
        if remainingSecond == 50 {
            newNumBug = 5
        } else if remainingSecond == 40 {
            newNumBug = 10
        } else if remainingSecond == 30 {
            newNumBug = 15
        } else if remainingSecond <= 20 {
            newNumBug = 20
        }
        
        DispatchQueue.main.async {
            self.numBug = newNumBug
        }
    }
    
    func addBug(_ num: Int) {
        for _ in 0..<num {
            let newBug = SurviveGameEntity(type: .bug, velocity: 1, frameMaxX: self.frameMaxX, frameMaxY: self.frameMaxY)
            self.bugList.append(newBug)
        }
    }
    
    func addBoat(_ num: Int) {
        for _ in 0..<num {
            let newBoat = SurviveGameEntity(type: .boat, velocity: 2, frameMaxX: self.frameMaxX, frameMaxY: self.frameMaxY)
            self.boatList.append(newBoat)
        }
    }
    
    func duckkuHit() {
        if self.life == 0 {
            soundManager.playSound(sound: .microbeEnd)
            finishGame()
        }
        else {
            self.life -= 1
            soundManager.playSound(sound: .microbeHit)
        }
        
        DispatchQueue.main.async {
            self.isImmuned = true
            self.isTransparent = true
            self.toggleTransparency(0)
        }
        
        // 3초 후 무적 해제
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isTransparent = false
            self.isImmuned = false
        }
    }
    
    private func toggleTransparency(_ count: Int) {
        // 무적 시간 끝났으면 중지
        if !isImmuned {
            self.isTransparent = false
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isTransparent.toggle()
            self.toggleTransparency(count + 1)
        }
    }
    
    func updateScore() {
        let remainingSecond = Int(self.timeRemaining * 100) / 100
        print("*** time Remaining: \(remainingSecond)sec")
        
        // 50초 이상
        if remainingSecond >= 50 {
            self.score += 1
        }
        // 50초 미만 40초 이상
        else if remainingSecond >= 40 {
            self.score += 2
        }
        // 40초 미만 30초 이상
        else if remainingSecond >= 30 {
            self.score += 3
        }
        // 30초 미만
        else {
            self.score += 4
        }
    }
    
    func distanceL1(x1: CGFloat, x2: CGFloat, y1: CGFloat, y2: CGFloat) -> CGFloat {
        let dx = abs(x2 - x1)
        let dy = abs(y2 - y1)
        return dx + dy
    }

    // 점을 중심점을 기준으로 회전시키는 함수
    func rotatePoint(_ point: CGPoint, around center: CGPoint, by angle: CGFloat) -> CGPoint {
        let radians = angle * .pi / 180
        let translatedX = point.x - center.x
        let translatedY = point.y - center.y
        
        let rotatedX = translatedX * cos(radians) - translatedY * sin(radians)
        let rotatedY = translatedX * sin(radians) + translatedY * cos(radians)
        
        return CGPoint(x: rotatedX + center.x, y: rotatedY + center.y)
    }

    // 두 좌표를 받아서 사각형의 네 꼭짓점을 반환하는 함수
    func rotatedRectangle(_ point1: CGPoint, _ point2: CGPoint, by angle: CGFloat) -> (CGPoint, CGPoint, CGPoint, CGPoint) {
        // 사각형의 네 꼭짓점을 계산합니다.
        let topLeft = point1
        let topRight = CGPoint(x: point2.x, y: point1.y)
        let bottomRight = point2
        let bottomLeft = CGPoint(x: point1.x, y: point2.y)
        
        // 사각형의 중심점을 계산합니다.
        let centerX = (point1.x + point2.x) / 2
        let centerY = (point1.y + point2.y) / 2
        let center = CGPoint(x: centerX, y: centerY)
        
        // 네 꼭짓점을 회전시킵니다.
        let rotatedTopLeft = rotatePoint(topLeft, around: center, by: angle)
        let rotatedTopRight = rotatePoint(topRight, around: center, by: angle)
        let rotatedBottomRight = rotatePoint(bottomRight, around: center, by: angle)
        let rotatedBottomLeft = rotatePoint(bottomLeft, around: center, by: angle)
        
        return (rotatedTopLeft, rotatedTopRight, rotatedBottomRight, rotatedBottomLeft)
    }
    
    // 다각형을 주어진 축에 투영하는 함수
    func projectPolygon(vertices: [CGPoint], axis: CGPoint) -> (min: CGFloat, max: CGFloat) {
        var minProj = CGPoint.dot(vertices[0], axis)
        var maxProj = minProj
        for vertex in vertices[1...] {
            let proj = CGPoint.dot(vertex, axis)
            if proj < minProj {
                minProj = proj
            }
            if proj > maxProj {
                maxProj = proj
            }
        }
        return (minProj, maxProj)
    }

    // 주어진 축이 두 다각형 사이의 분리 축인지 검사하는 함수
    func isSeparatingAxis(_ axis: CGPoint, vertices1: [CGPoint], vertices2: [CGPoint]) -> Bool {
        let projection1 = projectPolygon(vertices: vertices1, axis: axis)
        let projection2 = projectPolygon(vertices: vertices2, axis: axis)
        return projection1.max < projection2.min || projection2.max < projection1.min
    }
    
    // 두 다각형이 겹치는지 검사하는 함수
    func polygonsOverlap(_ vertices1: [CGPoint], _ vertices2: [CGPoint]) -> Bool {
        // 모든 변에 대해 수직축을 검사합니다.
        let axes1 = (0..<vertices1.count).map { (i) -> CGPoint in
            let nextIndex = (i + 1) % vertices1.count
            return (vertices1[nextIndex] - vertices1[i]).perpendicular().normalized()
        }
        
        let axes2 = (0..<vertices2.count).map { (i) -> CGPoint in
            let nextIndex = (i + 1) % vertices2.count
            return (vertices2[nextIndex] - vertices2[i]).perpendicular().normalized()
        }
        
        for axis in axes1 + axes2 {
            if isSeparatingAxis(axis, vertices1: vertices1, vertices2: vertices2) {
                return false
            }
        }
        
        return true
    }
}

extension CGPoint {
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func dot(_ v1: CGPoint, _ v2: CGPoint) -> CGFloat {
        return v1.x * v2.x + v1.y * v2.y
    }
    
    func perpendicular() -> CGPoint {
        return CGPoint(x: -self.y, y: self.x)
    }
    
    func length() -> CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }
    
    func normalized() -> CGPoint {
        let len = self.length()
        return CGPoint(x: self.x / len, y: self.y / len)
    }
}
