//
//  StoryViewModel.swift
//  playkuround-iOS
//
//  Created by Guryss on 8/22/24.
//

import Foundation

final class StoryViewModel: ObservableObject {
    @Published var currentStoryIndex: Int = 0
    
    var openedGameTypes = UserDefaults.standard.stringArray(forKey: "openedGameTypes") ?? []
    var stories: [Story]
    
    init(stories: [Story]) {
        self.stories = stories
    }
    
    func previousStory() {
        if currentStoryIndex > 0 {
            currentStoryIndex -= 1
        }
    }
    
    func nextStory() {
        if currentStoryIndex < stories.count - 1 {
            currentStoryIndex += 1
        }
    }
    
    // 게임 종류를 UserDefaults에 저장하는 함수
    func saveOpenedGameType(_ gameType: GameType) {
        if !openedGameTypes.contains(gameType.rawValue) {
            openedGameTypes.append(gameType.rawValue)
            
            UserDefaults.standard.set(openedGameTypes, forKey: "openedGameTypes")
        }
        
        unlockStoriesBasedOnGameTypes()
        print("저장된 UserDefaults: \(loadOpenedGameTypes())")
    }
    
    // UserDefaults에서 저장된 게임 종류를 불러오는 함수
    func loadOpenedGameTypes() -> [GameType] {
        guard let savedGameTypes = UserDefaults.standard.stringArray(forKey: "openedGameTypes") else {
            return []
        }
        
        return savedGameTypes.compactMap { GameType(rawValue: $0) }
    }
    
    // 게임 종류의 수에 따라 스토리를 잠금 해제하는 함수
    func unlockStoriesBasedOnGameTypes() {
        for i in 0..<openedGameTypes.count {
            if i < stories.count {
                stories[i].isLocked = false
            }
        }
    }
    
}
