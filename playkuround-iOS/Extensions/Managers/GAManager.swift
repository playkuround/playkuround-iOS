//
//  GAManager.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/25/24.
//

import SwiftUI
import FirebaseAnalytics

final class GAManager {
    static let shared = GAManager()
    
    // 특정 이벤트 로깅
    func logEvent(_ logType: GALogType, parameters: [String: Any]? = nil) {
        if let parameters = parameters {
            print("LogEvent: \(logType.rawValue), params: \(parameters)")
        } else {
            print("LogEvent: \(logType.rawValue), params: nil")
        }
        
        Analytics.logEvent(logType.rawValue, parameters: parameters)
    }
    
    // 특정 스크린 열릴 때 로깅
    func logScreenEvent(_ screen: ScreenName, landmarkID: Int? = nil, badgeName: String? = nil) {
        // 특정 뱃지 선택되는 뷰
        if screen == .BadgeDetailView || screen == .NewBadgeView {
            if let badgeName = badgeName {
                print("ScreenOpenLogEvent: \(screen.rawValue), badgeName: \(badgeName)")
                Analytics.logEvent("OPEN_SCREEN", parameters: ["SCREEN_NAME": screen.rawValue, "BADGE_NAME": badgeName])
            }
        }
        // 특정 랜드마크 선택되는 뷰
        else if screen == .LandmarkView || screen == .LandmarkDetailView
                    || screen == .LandmarkRankingView || screen == .AdventureView {
            if let landmarkID = landmarkID {
                print("ScreenOpenLogEvent: \(screen.rawValue), landmarkID: \(landmarkID)")
                Analytics.logEvent("OPEN_SCREEN", parameters: ["SCREEN_NAME": screen.rawValue, "LANDMARK_ID": landmarkID])
            }
        }
        // 나머지 뷰
        else {
            print("ScreenOpenLogEvent: \(screen.rawValue)")
            Analytics.logEvent("OPEN_SCREEN", parameters: ["SCREEN_NAME": screen.rawValue])
        }
    }
    
    enum GALogType: String {
        // Main View
        case START_BUTTON_CLICK // 메인 화면 시작 버튼 클릭
        
        // Login
        case SEND_EMAIL // 이메일 전송
        case LOGIN_SUCCESS // 로그인 성공
        case LOGIN_FAIL // 로그인 실패
        case AUTO_LOGIN // 자동 로그인
        
        // Register
        case REGISTER_START // 회원가입 프로세스 시작
        case REGISTER_SUCCESS // 회원가입 성공
        
        // My Page View
        case REVIEW_STORY // 스토리 다시보기
        case LOGOUT // 로그아웃
        case OPEN_INSTAGRAM // 인스타그램 바로가기
        case CHEERING // 응원하기
        
        case OPEN_PRIVACY_POLICY // 개인정보 처리방침
        case TERM_OF_SERVICE // 서비스 이용약관
        case SEND_FEEDBACK // 피드백 보내기
        case ERROR_REPORT // 오류 제보
        
        // BadgeProfile View
        case BADGE_PROFILE_CHANGE // 뱃지 프로필 변경
        
        // Attendance View
        case ATTENDANCE_SUCCESS // 출석 성공
        case ATTENDANCE_FAIL // 출석 실패 (범위 밖)
        
        // Badge View
        case OPEN_BADGE_DETAIL // 열린 뱃지 설명 클릭
        case OPEN_LOCKED_BADGE // 잠긴 뱃지 클릭
        
        // Game Common
        case GAME_START // 게임 시작
        case GAME_FINISH // 게임 완료
        case GAME_PAUSE // 게임 일시정지
        case GAME_RESUME // 게임 이어서
        case GAME_QUIT // 게임 중단
        case UPLOAD_GAME_RESULT // 게임 결과 업로드
    }
    
    enum ScreenName: String {
        case MainView
        case LoginView
        case RegisterMajorView
        case RegisterTermsView
        case RegisterNicknameView
        case HomeView
        case MyPageView
        case BadgeProfileView
        case NewBadgeView
        case AttendanceView
        case AdventureView
        case BadgeView
        case BadgeDetailView
        case TotalRankingView
        case LandmarkView
        case LandmarkRankingView
        case LandmarkDetailView
        case NotificationWebView
        case StoryView
        
        case TermView
        
        // 게임
        case CatchGame
        case SurviveGame
        case AllClickGame
        case CardGame
        case CupidGame
        case QuizGame
        case MoonGame
        case TimerGame
        case GamePauseView
        case GameResultView
        
        case NetworkErrorView
        case RequestPermissionView
    }
}
