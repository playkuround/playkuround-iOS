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
    
    // 3초 대기창
    @Published var isNextWaiting: Bool = false // 다음 문제 대기 중
    @Published var isQuizWaitingViewPresented: Bool = false
    @Published var isFirstQuestion: Bool = true
    
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
        if !self.isNextWaiting {
            DispatchQueue.main.async {
                self.isNextWaiting = true
                
                if self.currentQuestionIndex < self.shuffledQuizData.count {
                    // 첫 번째 문제 제외
                    if self.isFirstQuestion {
                        self.isFirstQuestion = false
                        self.afterLoadNextQuestion()
                    } else {
                        self.isQuizWaitingViewPresented = true
                        self.countdown = 3
                        self.startQuizCountdownProcess()
                    }
                } else {
                    self.finishGame()
                }
            }
        }
    }
    
    func startQuizCountdownProcess() {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: .now() + 1) {
            if self.countdown > 1 {
                self.countdown -= 1
                self.startQuizCountdownProcess()
            }
            else if self.countdown == 1 {
                self.isQuizWaitingViewPresented = false
                self.afterLoadNextQuestion()
            }
        }
    }
    
    func afterLoadNextQuestion() {
        DispatchQueue.main.async {
            self.isBlockEnabled = true
            self.isCorrectAnswer = nil
            self.currentQuestionIndex += 1
            self.isNextWaiting = false
        }
    }
    
    func blockClick() {
        DispatchQueue.main.async {
            guard let isCorrectAnswer = self.isCorrectAnswer else { return }
            
            self.isBlockEnabled = false  // 블록을 비활성화
            
            if isCorrectAnswer {
                self.correctAnswersCount += 1
                self.soundManager.playSound(sound: .quizCorrect)
                self.calculateScore()
                
                self.loadNextQuestion()
            } else {
                self.soundManager.playSound(sound: .quizIncorrect)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.finishGame()
                }
            }
        }
    }
    
    override func finishGame() {
        if self.gameState != .finish {
            DispatchQueue.main.async {
                self.gameState = .finish
                self.calculateScore()
                
                self.isWaitingViewPresented = true
                self.countdown = 3
                
                self.startResultCountdownProgress()
            }
        }
    }
    
    private func calculateScore() {
//        if correctAnswersCount == 0 {
//            score = 5
//        }
//        else if correctAnswersCount >= 1 && correctAnswersCount <= 15 {
//            score = 10 * correctAnswersCount
//        }
//        else if correctAnswersCount >= 16 && correctAnswersCount <= 25 {
//            score = 10 * ( 2 * correctAnswersCount - 14 )
//        }
//        else if correctAnswersCount >= 26 {
//            score = 400
//        }
        
        if correctAnswersCount == 0 {
            self.score = 5
        }
        else if correctAnswersCount <= 15 {
            self.score = 10 * correctAnswersCount
        }
        else if correctAnswersCount <= 25 {
            self.score = 20 * (correctAnswersCount - 16) + 180
        } else {
            score = 400
        }
    }
    
    override func afterEndCountdown() {
        DispatchQueue.main.async {
            super.uploadResult(uploadScore: self.score)
        }
    }
}
