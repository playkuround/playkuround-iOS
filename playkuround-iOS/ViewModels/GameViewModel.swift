//
//  GameViewModel.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 4/1/24.
//

import Combine
import Foundation
import SwiftUI

enum GameState {
    // 시작 전 준비 상태
    case ready
    // 카운트다운 중
    case countdown
    // 게임 진행 중
    case playing
    // 게임 일시정지
    case pause
    // 게임 완료
    case finish
    // 중도 중단
    case stop
}

// 게임 타입 (서버에서 사용하는 명칭과 통일)
// RawValue는 API 요청시 필요한 게임 코드
enum GameType: String {
    // 10초를 맞춰봐
    case time = "TIME"
    // 문을 점령해
    case moon = "MOON"
    // 건쏠지식
    case quiz = "QUIZ"
    // 덕쿠를 잡아라 (catch가 예약어라 예외)
    case catchDucku = "CATCH"
    // 수강신청 All 클릭
    case allClear = "ALL_CLEAR"
    // 덕큐피트♥
    case cupid = "CUPID"
    // 책 뒤집기
    case book = "BOOK"
    // 일감호에서 살아남기
    case survive = "SURVIVE"
}

class GameViewModel: ObservableObject {
    @Published var rootViewModel: RootViewModel
    @Published var mapViewModel: MapViewModel
    
    // 게임 상태
    @Published var gameState: GameState = .ready
    
    // 시작 전 3초 카운트다운
    @Published var countdown: Int = 3
    @Published var isCountdownViewPresented: Bool = false
    
    // 타이머 남은 시간(시작 시간), 간격, 종료 시간
    @Published var timeRemaining: Double
    private let timeStart: Double
    private let timeEnd: Double
    private let isTimerDecreasing: Bool
    private let timeInterval: Double
    
    // 게임 타이머 관련 변수
    lazy var timer = Timer.publish(every: timeInterval, on: .main, in: .common).autoconnect()
    
    // 타이머 업데이트 여부
    @Published var isTimerUpdating: Bool = false
    
    // 보여주기용 타이머 값
    @Published var minute: String = "00"
    @Published var second: String = "00"
    
    // 게임 진행률
    @Published var progress: Double = 1.0
    
    // 일시정지 뷰 표시 여부
    @Published var isPauseViewPresented: Bool = false
    
    // 게임 결과창 표시 여부
    @Published var isResultViewPresented: Bool = false
    
    // 게임 타입 (개발 시 직접 지정)
    let gameType: GameType
    
    // 게임 점수
    @Published var score: Int = 0
    
    // 사용자의 해당 게임 최고점수
    @Published var bestScore: Int = 0
    // 사용자의 모험 점수
    @Published var adventureScore: Int = 0
    
    // MARK: - Initializer
    
    init(_ gameType: GameType,
         rootViewModel: RootViewModel,
         mapViewModel: MapViewModel,
         timeStart: Double,
         timeEnd: Double,
         timeInterval: Double) {
        
        // 게임 종류 지정
        self.gameType = gameType
        
        // View Model
        self.rootViewModel = rootViewModel
        self.mapViewModel = mapViewModel
        
        // 타이머 설정
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.timeRemaining = timeStart
        self.timeInterval = timeInterval
        
        // 타이머 증감 여부
        if self.timeStart > self.timeEnd {
            self.isTimerDecreasing = true
        } else {
            self.isTimerDecreasing = false
        }
        
        updateTimeString()
    }
    
    // MARK: - 게임 플레이 관련 함수
    
    // 시작 전 3초 카운트다운 시작 함수
    final func startCountdown() {
        DispatchQueue.main.async {
            self.gameState = .countdown
            
            withAnimation(.spring(duration: 0.1)) {
                self.isCountdownViewPresented = true
            }
            
            // 카운트다운 시작
            self.countdownProgress()
        }
    }
    
    final private func countdownProgress() {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: .now() + 1) {
            if self.countdown > 1 {
                self.countdown -= 1
                self.countdownProgress()
            }
            else if self.countdown == 1 {
                withAnimation(.spring(duration: 0.1)) {
                    self.isCountdownViewPresented = false
                }
                // 게임 시작
                self.startGame()
            }
        }
    }
    
    // 게임 시작 시 호출 함수
    func startGame() {
        // TODO: 게임 시작 프로세스 호출
        DispatchQueue.main.async {
            self.gameState = .playing
        }
        print("Game is started")
    }
    
    // 게임 완료 (사용자가 끝까지 마친 경우)
    func finishGame() {
        DispatchQueue.main.async {
            self.gameState = .finish
        }
        print("Game is finished")
        // TODO: 게임 종료 처리 (점수 계산 등)
        
        // 서버로 점수 업로드
        uploadResult(uploadScore: 0)
    }
    
    // 게임 중도 중지 후 홈으로 이동
    func stopGame() {
        // TODO: 게임 중단 프로세스
        DispatchQueue.main.async {
            self.gameState = .stop
        }
        print("Game is stopped")
        
        // 홈으로 이동
        rootViewModel.transition(to: .home)
    }
 
    // MARK: - 타이머 관련 함수
    
    // 게임 타이머 시작
    final func startTimer() {
        print("timer is started")
        DispatchQueue.main.async {
            self.isTimerUpdating = true
        }
    }
    
    // 타이머 일시정지 및 재시작
    func pauseOrRestartTimer() {
        print("timer is paused")
        DispatchQueue.main.async {
            self.isTimerUpdating.toggle()
        }
    }
    
    // 타이머 삭제
    final func cancelTimer() {
        print("timer is stopped")
        DispatchQueue.main.async {
            self.isTimerUpdating = false
            self.timer.upstream.connect().cancel()
        }
    }
    
    // 타이머 초기화
    final func resetTimer() {
        print("timer is reseted")
        DispatchQueue.main.async {
            self.isTimerUpdating = false
            self.timeRemaining = self.timeStart
            self.progress = 1.0
        }
        updateTimeString()
    }
    
    // 타이머가 끝난 경우 호출되는 함수
    // 사용자가 재정의
    func timerDone() {
        DispatchQueue.main.async {
            self.finishGame()
        }
    }
    
    // 타이머 업데이트
    final func updateTimer() {
        if isTimerUpdating {
            // 감소
            if self.isTimerDecreasing && self.timeRemaining > self.timeEnd {
                DispatchQueue.main.async {
                    self.timeRemaining -= self.timeInterval
                    self.progress = self.timeRemaining / self.timeStart
                }
                self.updateTimeString()
            }
            // 증가
            else if !self.isTimerDecreasing && self.timeRemaining < self.timeEnd {
                // 증가하는 경우 progress 계산 X
                DispatchQueue.main.async {
                    self.timeRemaining += self.timeInterval
                }
                self.updateTimeString()
            }
            // 시간 다 된 경우
            else {
                self.pauseOrRestartTimer()
                self.timerDone()
            }
        }
    }
    
    final func updateTimer2() {
        if isTimerUpdating {
            // 감소
            if self.isTimerDecreasing && self.timeRemaining > self.timeEnd {
                DispatchQueue.main.async {
                    self.timeRemaining -= self.timeInterval
                    self.progress = self.timeRemaining / self.timeStart
                }
                self.updateTimeString()
            }
            // 증가
            else if !self.isTimerDecreasing && self.timeRemaining < self.timeEnd {
                // 증가하는 경우 progress 계산 X
                DispatchQueue.main.async {
                    self.timeRemaining += self.timeInterval
                }
                self.updateTimeString()
            }
            // 시간 다 된 경우
            else {
                self.pauseOrRestartTimer()
                //self.timerDone()
            }
        }
    }
    
    // 시계에 표시할 분:초 문자열 업데이트
    final func updateTimeString() {
        let minute = Int(timeRemaining) / 60
        let second = Int(timeRemaining) % 60
        DispatchQueue.main.async {
            self.minute = String(format: "%02d", minute)
            self.second = String(format: "%02d", second)
        }
    }
    
    // MARK: - 일시정지 뷰
    
    // 일시정지 뷰 토글
    final func togglePauseView() {
        DispatchQueue.main.async {
            withAnimation(.spring(duration: 0.1)) {
                self.isPauseViewPresented.toggle()
            }
            
            if self.isPauseViewPresented {
                self.gameState = .pause
                self.isTimerUpdating = false
            } else {
                self.gameState = .playing
                self.isTimerUpdating = true
            }
        }
    }
    
    // 모든 API 호출 이후 호출되는 함수
    func afterFetch() {
        DispatchQueue.main.async {
            withAnimation(.spring) {
                self.isResultViewPresented = true
            }
        }
    }
    
    // MARK: - 서버 API 관련 함수
    
    // 서버로 점수 업로드 함수
    final func uploadResult(uploadScore: Int) {
//        // 사용자 위치 정보
//        let latitude = mapViewModel.userLatitude
//        let longitude = mapViewModel.userLongitude
//        
        let latitude: Double = 37.54040
        let longitude: Double = 127.07920
        let landmarkID = 25 // 신공학관
        
        print("** ready to upload score: \(uploadScore)점")
        
        // 게임 점수 업로드 이벤트
        GAManager.shared.logEvent(.UPLOAD_GAME_RESULT,
                                  parameters: ["GameType": self.gameType.rawValue, "Score": uploadScore])
        
//        if let landmarkID = mapViewModel.userLandmarkID {
            // Adventure API 호출
            // 전송 실패하더라도 callPOSTAPI 함수 내부에서 재전송 처리
            APIManager.callPOSTAPI(endpoint: .adventures,
                                   parameters: ["landmarkId": landmarkID,
                                                "latitude": latitude,
                                                "longitude": longitude,
                                                "score": uploadScore,
                                                "scoreType": gameType.rawValue])
            { result in
                switch result {
                case .success(let data):
                    print("Data received in View: \(data)")
                    // 게임 종료 처리 (결과 표시)
                    self.fetchBestScore()
                case .failure(let error):
                    print("Error in View: \(error)")
                }
            }
//        } else {
//            // 랜드마크 아이디 없는 경우
//            // 실제 게임은 랜드마크 아이디가 부여된 경우에만 시작되므로 발생X
//            print("Error: No Landmark ID")
//        }
    }
    
    // 사용자의 게임 최고 점수 가져오는 함수
    func fetchBestScore() {
        APIManager.callGETAPI(endpoint: .gameScore) { result in
            switch result {
            case .success(let data):
                if let apiResponse = data as? APIResponse {
                    if let response = apiResponse.response {
                        DispatchQueue.main.async {
                            switch self.gameType {
                            case .time:
                                self.bestScore = response.highestTimeScore ?? 0
                            case .moon:
                                self.bestScore = response.highestMoonScore ?? 0
                            case .quiz:
                                self.bestScore = response.highestQuizScore ?? 0
                            case .catchDucku:
                                self.bestScore = response.highestCatchScore ?? 0
                            case .allClear:
                                self.bestScore = response.highestAllClearScore ?? 0
                            case .cupid:
                                self.bestScore = response.highestHongBridgeScore ?? 0
                            case .book:
                                self.bestScore = response.highestCardScore ?? 0
                            case .survive:
                                self.bestScore = response.highestMicrobeScore ?? 0
                            }
                        }
                    }
                }
                print("Best Score: \(self.bestScore)")
                self.fetchAdventureScore()
            case .failure(let error):
                print("Error in View: \(error)")
                DispatchQueue.main.async {
                    self.bestScore = 0
                }
                self.fetchAdventureScore()
            }
        }
    }
    
    // 사용자의 모험 점수(총점) 가져오는 함수
    func fetchAdventureScore() {
        APIManager.callGETAPI(endpoint: .scoresRank) { result in
            switch result {
            case .success(let data):
                if let response = data as? APIResponse {
                    if let myRank = response.response?.myRank {
                        DispatchQueue.main.async {
                            self.adventureScore = myRank.score
                            self.afterFetch()
                        }
                    }
                }
                print("Adventure Score: \(self.adventureScore)")
            case .failure(let error):
                print("Error in View: \(error)")
                // 에러 떠도 일단 넘어가도록
                DispatchQueue.main.async {
                    self.adventureScore = 0
                }
                self.afterFetch()
            }
        }
    }
}


struct GameViewModelTextView: View {
    @ObservedObject var viewModel = GameViewModel(.time,
                                                  rootViewModel: RootViewModel(),
                                                  mapViewModel: MapViewModel(),
                                                  timeStart: 5,
                                                  timeEnd: 0,
                                                  timeInterval: 0.01)
    
    var body: some View {
        ZStack {
            VStack {
                TimerBarView(progress: $viewModel.progress, color: .black)
                    .onReceive(viewModel.timer) { _ in
                        viewModel.updateTimer()
                    }
                
                Text("\(viewModel.minute):\(viewModel.second)")
                
                Text("타이머 시간: \(viewModel.timeRemaining)s")
                
                Button(viewModel.isTimerUpdating ? "타이머 일시정지" : "타이머 재시작") {
                    viewModel.pauseOrRestartTimer()
                }
                .buttonStyle(.borderedProminent)
                
                Button("타이머 초기화") {
                    viewModel.resetTimer()
                }
                .buttonStyle(.borderedProminent)
                
                Divider()
                    .padding(.vertical, 30)
                
                Text("게임")
                    .font(.headline)
                
                Text("게임 상태: \(viewModel.gameState)")
                
                Button("게임 시작") {
                    viewModel.startCountdown()
                }
                .buttonStyle(.borderedProminent)
                
                Button("일시정지") {
                    viewModel.togglePauseView()
                }
                .buttonStyle(.borderedProminent)
                
                Divider()
                    .padding(.vertical, 30)
                
                Text("게임: \(viewModel.gameType.rawValue)")
                
                Text("이 게임 최고 점수: \(viewModel.bestScore)")
                Text("모험 점수: \(viewModel.adventureScore)")
                
                Button("최고 점수 불러오기") {
                    viewModel.fetchBestScore()
                }
                .buttonStyle(.borderedProminent)
                
                Button("모험 점수 불러오기") {
                    viewModel.fetchAdventureScore()
                }
                .buttonStyle(.borderedProminent)
                
                Divider()
                    .padding(.vertical, 30)
            }
            
            if viewModel.isCountdownViewPresented {
                CountdownView(countdown: $viewModel.countdown)
            } else if viewModel.isPauseViewPresented {
                GamePauseView(viewModel: viewModel)
            } else if viewModel.isResultViewPresented {
                GameResultView(rootViewModel: RootViewModel(), gameViewModel: self.viewModel)
            }
        }
    }
}

#Preview {
    GameViewModelTextView()
}
