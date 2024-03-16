//
//  ScoreType.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/16/24.
//

/// 점수의 종류 enum 구조화, RawValue는 명칭
/// 백엔드 서버와 코드 명칭을 통일함
enum ScoreType: String {
    // 출석 점수
    case ATTENDANCE = "출석 점수"
    
    // 게임 점수 (RawValue는 게임 이름)
    case QUIZ = "건쏠지식"
    case TIME = "10초를 맞춰봐"
    case MOON = "문을 점령해"
    case BOOK = "책 뒤집기"
    case CATCH = "덕쿠를 잡아라"
    case CUPID = "덕큐피트♥"
    case ALL_CLEAR = "수강신청 ALL 클릭"
    case SURVIVE = "일감호에서 살아남기"
}
