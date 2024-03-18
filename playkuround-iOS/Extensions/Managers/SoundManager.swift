//
//  SoundManager.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/17/24.
//

import AVKit
import SwiftUI

class SoundManager: ObservableObject {
    static let shared = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: Sound, loop: Bool = false) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            
            if loop {
                player?.numberOfLoops = -1
            }
            else {
                player?.numberOfLoops = 0
            }
            
            player?.play()
        } catch let error {
            print("재생하는데 오류가 발생했습니다. \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        player?.stop()
    }
}

enum Sound: String {
    // 배경음악
    case backgroundMusic
    // 버튼 클릭
    case buttonClicked
    
    // 달 깨기
    case moonClicked
    case moonHundredClicked
    
    // 덕쿠를 잡아라
    case blackDuckkuClicked
    case duckkuClicked
    case duckkuWindowOpenAndClose
    
    // 미생물 피하기
    case microbeEnd
    case microbeHit
    
    // 수강신청 올 클릭
    case classCorrect
    case classEnd
    case classMinusHeart
    
    // 카드 뒤집기
    case cardAllCorrect
    case cardClicked
    case cardCorrect
    case cardIncorrect
    
    // 퀴즈
    case quizCorrect
    case quizIncorrect
    
    // 홍큐피트
    case cupidBad
    case cupidGoodOrPerfect
    
    // 타이머
    case timerButtonClicked
    case timerCorrect
    case timerIncorrect
    }
