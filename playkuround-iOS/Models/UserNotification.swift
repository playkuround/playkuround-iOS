//
//  UserNotification.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/16/24.
//

/// UserNotification enum 구조화, RawValue는 Description
enum UserNotification {
    // 뱃지 관련 알림
    // MONTHLY_RANKING_1 : 월간 랭킹 1등 뱃지
    // MONTHLY_RANKING_2 : 월간 랭킹 2등 뱃지
    // MONTHLY_RANKING_3 : 월간 랭킹 3등 뱃지
    // COLLEGE_OF_BUSINESS_ADMINISTRATION_100_AND_FIRST_PLACE : 경영대학 100회 이상 탐험 및 1등 달성 뱃지
    case newBadge
    // 앱 업데이트 알림
    // application is must update 강제 업데이트 필요
    case update
    // 기타
    // 개인 알림 내용, 해당 유저에게 알려줄 내용(경고 메시지, 이벤트 내용 등)
    case alarm
}
