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
    
    init(rootViewModel: RootViewModel, mapViewModel: MapViewModel) {
        self.motionManager = MotionManager()
        super.init(.catchDucku, rootViewModel: rootViewModel, mapViewModel: mapViewModel, timeStart: 60.0, timeEnd: 0.0, timeInterval: 0.01)
        setupGyroUpdates()
    }
    
    override func startGame() {
        super.startGame()
        super.startTimer()
        self.isImmuned = false
        
        self.addBug(10)
        self.addBoat(2)
        // self.boatList.append(SurviveGameEntity(type: .boat, velocity: 2, frameMaxX: self.frameMaxX, frameMaxY: self.frameMaxY))
    }
    
    override func timerDone() {
        finishGame()
    }
    
    override func finishGame() {
        super.pauseOrRestartTimer()
        self.isTimerUpdating = false
        gameState = .finish
    
        // 서버로 점수 업로드
        uploadResult()
    }
    
    func setFrameXY(x: CGFloat, y: CGFloat) {
        self.frameMaxX = x
        self.frameMaxY = y
    }
    
    private func updateDuckkuPos(x: Double, y: Double, z: Double) {
        if !isTimerUpdating {
            return
        }
        
        self.gyroCummX += x * 0.1
        self.gyroCummY += y * 0.1
        
        self.gyroCummX = min(max(self.gyroCummX, -2), 2)
        self.gyroCummY = min(max(self.gyroCummY, -2), 2)
        
        // Gyro data scaling factor
        let scalingFactor: CGFloat = 1.0
        let damping: CGFloat = 0.5
        
        // print("x: \(String(format: "%+02.5f", x)), y: \(String(format: "%+02.5f", y)), z: \(String(format: "%+02.5f", z))")
    
        // Update acceleration based on gyro data
        accelerationX = CGFloat(gyroCummY) * scalingFactor
        accelerationY = CGFloat(gyroCummX) * scalingFactor
        
        // Update velocity with damping to simulate friction
        velocityX += accelerationX
        velocityY += accelerationY
        velocityX *= damping
        velocityY *= damping
        
        // Update positions
        let newX = duckkuPosX + velocityX
        let newY = duckkuPosY + velocityY
        
        // Constrain positions within frame
        duckkuPosX = min(max(newX, -frameMaxX / 2), frameMaxX / 2)
        duckkuPosY = min(max(newY, -frameMaxY / 2), frameMaxY / 2)
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
            // 연산량을 줄이기 위해 L1 거리가 200 이하인 경우만 계산
            if distanceL1(x1: self.duckkuPosX, x2: bugList[i].posX, y1: self.duckkuPosY, y2: bugList[i].posY) > 200 {
                continue
            }
            
            let bugRect = CGRect(x: bugList[i].posX - (13 / 2), y: bugList[i].posY - (21 / 2), width: 13, height: 21)
            
            if duckkuRect.intersects(bugRect) {
                print("hit with bug rect \(bugRect)")
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
            
            let boatPoint1 = CGPoint(x: Int(boatList[i].posX - (82 / 2)), y: Int(boatList[i].posY - (27 / 2)))
            let boatPoint2 = CGPoint(x: Int(boatList[i].posX + (82 / 2)), y: Int(boatList[i].posY + (27 / 2)))
            let (rotatedBoatPoint1, rotatedBoatPoint2) = rotateRectanglePoints(boatPoint1, boatPoint2, by: boatList[i].angle.degrees)

            let boatRectPoints = [CGPoint(x: rotatedBoatPoint1.x, y: rotatedBoatPoint1.y),
                                  CGPoint(x: rotatedBoatPoint1.x, y: rotatedBoatPoint2.y),
                                  CGPoint(x: rotatedBoatPoint2.x, y: rotatedBoatPoint2.y),
                                  CGPoint(x: rotatedBoatPoint2.x, y: rotatedBoatPoint1.y)]
            
            let isOverlapping = polygonsOverlap(vertices1: duckkuRectPoints, vertices2: boatRectPoints)
            if isOverlapping {
                print("duckku pos (\(duckkuPosX), \(duckkuPosY))")
                print("hit with boat rect (\(boatPoint1)), (\(boatPoint2))")
                print("rotated rect (\(rotatedBoatPoint1)), (\(rotatedBoatPoint2)) by \(boatList[i].angle.degrees)")
                print("hit with boat \(boatList[i].id)")
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
        
        print("** update \(remainingSecond)sec - numbug: \(newNumBug)")
        DispatchQueue.main.async {
            self.numBug = newNumBug
        }
    }
    
    func addBug(_ num: Int) {
        for _ in 0..<num {
            let newBug = SurviveGameEntity(type: .bug, velocity: 1, frameMaxX: self.frameMaxX, frameMaxY: self.frameMaxY)
            self.bugList.append(newBug)
        }
        print("\(num) bugs added")
    }
    
    func addBoat(_ num: Int) {
        for _ in 0..<num {
            let newBoat = SurviveGameEntity(type: .boat, velocity: 2, frameMaxX: self.frameMaxX, frameMaxY: self.frameMaxY)
            self.boatList.append(newBoat)
        }
        print("\(num) boats added")
    }
    
    func duckkuHit() {
        self.life -= 1
        
        if self.life == 0 {
            finishGame()
        }
        
        DispatchQueue.main.async {
            print("hit, isImmuned set True")
            self.isImmuned = true
            self.isTransparent = true
            self.toggleTransparency(0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("hit, isImmuned set False")
            self.isTransparent = false
            self.isImmuned = false
        }
    }
    
    private func toggleTransparency(_ count: Int) {
        if !isImmuned {
            self.isTransparent = false
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
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

    func rotatePoint(_ point: CGPoint, around center: CGPoint, by angle: CGFloat) -> CGPoint {
        let radians = angle * .pi / 180
        let dx = point.x - center.x
        let dy = point.y - center.y
        
        let rotatedX = center.x + dx * cos(radians) - dy * sin(radians)
        let rotatedY = center.y + dx * sin(radians) + dy * cos(radians)
        
        return CGPoint(x: rotatedX, y: rotatedY)
    }

    func rotateRectanglePoints(_ point1: CGPoint, _ point2: CGPoint, by angle: CGFloat) -> (CGPoint, CGPoint) {
        let centerX = (point1.x + point2.x) / 2
        let centerY = (point1.y + point2.y) / 2
        let center = CGPoint(x: centerX, y: centerY)
        
        let rotatedPoint1 = rotatePoint(point1, around: center, by: angle)
        let rotatedPoint2 = rotatePoint(point2, around: center, by: angle)
        
        return (rotatedPoint1, rotatedPoint2)
    }
    
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

    func isSeparatingAxis(_ axis: CGPoint, vertices1: [CGPoint], vertices2: [CGPoint]) -> Bool {
        let projection1 = projectPolygon(vertices: vertices1, axis: axis)
        let projection2 = projectPolygon(vertices: vertices2, axis: axis)
        return projection1.max < projection2.min || projection2.max < projection1.min
    }

    func polygonsOverlap(vertices1: [CGPoint], vertices2: [CGPoint]) -> Bool {
        // 모든 변에 대해 수직축을 검사합니다.
        let axes = [
            (vertices1[1] - vertices1[0]).perpendicular(),
            (vertices1[2] - vertices1[1]).perpendicular(),
            (vertices2[1] - vertices2[0]).perpendicular(),
            (vertices2[2] - vertices2[1]).perpendicular()
        ]
        
        for axis in axes {
            if isSeparatingAxis(axis.normalized(), vertices1: vertices1, vertices2: vertices2) {
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
