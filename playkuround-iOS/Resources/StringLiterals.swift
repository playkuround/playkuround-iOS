//
//  StringLiterals.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/15/24.
//

import SwiftUI

enum StringLiterals {
    enum Main {
        static let introduction = "건국대 안의 놀이터,"
        static let login = "로그인"
    }
    
    enum Login {
        static let description = "안녕하세요!\n건국대학교 이메일을 인증해주세요."
        static let requestCode = "인증코드 요청"
    }
    
    enum Register {
        static let title = "회원가입"
        static let termsDescription = "서비스 이용을 위한 약관에 동의해주세요."
        static let agreeAllTerms = "약관 전체 동의"
        static let agreeTerms = "이용약관 동의"
        static let agreePrivacyTerms = "개인정보 수집 및 이용 동의"
        static let agreeLocationTerms = "위치기반 서비스 이용약관 동의"
        static let majorSelectionDescription = "소속 대학 및 학과를 선택해주세요."
        static let collegePlaceholder = "소속 대학을 선택해주세요."
        static let majorPlaceholder = "소속 학과를 선택해주세요."
        static let nicknameDescription = "닉네임을 설정해주세요."
        static let nicknamePolicy = "- 닉네임은 한/영 2자에서 8자 사이로 설정 가능합니다.\n- 띄어쓰기와 특수문자 사용이 불가합니다.\n- 부적절한 단어 사용 시 추후 사용이 정지될 수 있습니다."
        static let nicknamePlaceholder = "닉네임을 입력해주세요."
        static let invalidNickname = "사용할 수 없는 닉네임입니다."
        static let duplicatedNickname = "중복되는 닉네임입니다."
        static let next = "다음"
        static let termsTitle = "이용약관"
    }
}
