//
//  MoonGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/5/24.
//

import Foundation

final class MoonGameViewModel: GameViewModel {
    @Published var moonState: MoonState = .fullMoon
    @Published var moonTapped: Int = 100
    
    func moonClick() {
        if moonTapped <= 100 && moonTapped >= 81 {
            moonTapped -= 1
            moonState = .fullMoon
        }
        else if moonTapped <= 80 && moonTapped >= 51 {
            moonState = .cracked
            moonTapped -= 1
        }
        else if moonTapped <= 50 && moonTapped >= 1 {
            moonState = .moreCracked
            moonTapped -= 1
        }
        else if moonTapped == 0 {
            moonState = .duck
            finishGame()
        }
    }
    
    override func finishGame() {
        gameState = .finish
    }
}
