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
        if 81 < moonTapped && moonTapped <= 100 {
            DispatchQueue.main.async {
                self.moonTapped -= 1
                self.moonState = .fullMoon
            }
        }
        else if 51 < moonTapped && moonTapped <= 81 {
            DispatchQueue.main.async {
                self.moonTapped -= 1
                self.moonState = .cracked
            }
        }
        else if 1 < moonTapped && moonTapped <= 51 {
            DispatchQueue.main.async {
                self.moonTapped -= 1
                self.moonState = .moreCracked
            }
        }
        else if moonTapped == 1 {
            DispatchQueue.main.async {
                self.moonTapped = 0
                self.moonState = .duck
                self.score = 20
            }
            finishGame()
        }
    }
    
    override func finishGame() {
        DispatchQueue.main.async {
            self.gameState = .finish
        }
        
        // 3초 뒤 서버로 점수 업로드
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            super.uploadResult(uploadScore: self.score)
        }
        
        self.checkOpenedGames()
    }
}
