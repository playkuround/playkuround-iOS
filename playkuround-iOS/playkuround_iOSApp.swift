//
//  playkuround_iOSApp.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/14/24.
//

import SwiftUI

@main
struct playkuround_iOSApp: App {
    // 다른 효과음과 동시에 나오기 위해 백경음악 인스턴스 생성
    private let soundManager = SoundManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear {
                    //soundManager.playSound(sound: .backgroundMusic, loop: true)
                }
        }
    }
}
