//
//  QuizGameViewModel.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/8/24.
//

import Foundation

final class QuizGameViewModel: GameViewModel {
    @Published var isCorrectAnswer: Bool?
    @Published var selectedIndex: Int?
    @Published var isBlockEnabled: Bool = true
    
    var currentQuestionIndex: Int = 0
    var correctAnswersCount: Int = 0
    var shuffledQuizData: [Quiz] = []  // Shuffle된 퀴즈 데이터를 저장할 배열
    
    let quizData: [Quiz]
    
    let soundManager = SoundManager.shared
    
    override init(_ gameType: GameType = .quiz,
                  rootViewModel: RootViewModel,
                  mapViewModel: MapViewModel,
                  timeStart: Double,
                  timeEnd: Double,
                  timeInterval: Double) {
        
        let currentLanguage = Locale.current.language.languageCode?.identifier
        
        switch currentLanguage {
        case "ko":
            self.quizData = load("QuizData.json")
        case "en":
            self.quizData = load("QuizDataEnglish.json")
        case "zh":
            self.quizData = load("QuizDataChinese.json")
        default:
            self.quizData = load("QuizData.json")
        }
        
        super.init(.quiz,
                   rootViewModel: rootViewModel,
                   mapViewModel: mapViewModel,
                   timeStart: timeStart,
                   timeEnd: timeEnd,
                   timeInterval: timeInterval)
    }
    
    override func startGame() {
        currentQuestionIndex = 0
        correctAnswersCount = 0
        
        shuffledQuizData = quizData.shuffled()
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        if currentQuestionIndex < shuffledQuizData.count {
            isCorrectAnswer = nil
            currentQuestionIndex += 1
        } else {
            finishGame()
        }
    }
    
    func blockClick() {
        guard let isCorrectAnswer = isCorrectAnswer else { return }
        
        isBlockEnabled = false  // 블록을 비활성화
        
        if isCorrectAnswer {
            correctAnswersCount += 1
            score += correctAnswersCount * 10
            soundManager.playSound(sound: .quizCorrect)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.loadNextQuestion()
                self.isBlockEnabled = true
            }
        } else {
            self.soundManager.playSound(sound: .quizIncorrect)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.finishGame()
            }
        }
    }
    
    override func finishGame() {
        gameState = .finish
        self.calculateScore()
        
        // 3초 뒤 서버로 점수 업로드
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            super.uploadResult(uploadScore: self.score)
        }
    }
    
    private func calculateScore() {
        if correctAnswersCount == 0 {
            score = 5
        }
        else if correctAnswersCount >= 1 && correctAnswersCount <= 15 {
            score = 10 * correctAnswersCount
        }
        else if correctAnswersCount >= 16 && correctAnswersCount <= 25 {
            score = 10 * ( 2 * correctAnswersCount - 14 )
        }
        else if correctAnswersCount >= 26 {
            score = 400
        }
    }
}
