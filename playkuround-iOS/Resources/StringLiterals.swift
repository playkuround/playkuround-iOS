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
        static let hello = "안녕하세요!"
        static let description = "건국대학교 이메일을 인증해주세요."
        static let placeHolder = "포탈 아이디"
        static let requestCode = "인증코드 요청"
        static let reRequestCode = "인증코드 재요청"
        static let email = "@konkuk.ac.kr"
        
        static let goEmail = "건국대학교 이메일 바로가기"
        static let mailSystemURL = "https://kumail.konkuk.ac.kr/adfs/ls/?lc=1042&wa=wsignin1.0&wtrealm=urn%3afederation%3aMicrosoftOnline"
        
        static let authenticationCode = "인증코드"
        static let authentication = "인증하기"
        static let authIncorrect = "입력하신 인증코드가 일치하지 않습니다."
        static let authRemainingNumber = "오늘 인증 요청 횟수가 3회 남았습니다."
        
        enum BottomSheet {
            static let title = "인증코드 입력 시간 초과"
            static let description = "인증코드 입력 시간이 초과되었습니다.\n인증코드를 다시 요청해주세요."
            static let ok = "확인"
        }
    }
    
    enum Register {
        static let title = "회원가입"
        static let termsDescription = "서비스 이용을 위한 약관에 동의해주세요."
        static let agreeAllTerms = "약관 전체 동의"
        static let agreeServiceTerms = "이용약관 동의"
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
        static let serviceTermsTitle = "이용약관"
        static let privacyTermsTitle = "개인정보 수집 및 이용약관"
        static let locationTermsTitle = "위치기반 서비스 이용약관"
        static let college = "대학"
        static let major = "학과"
        static let termsErrorMessage = "이용약관을 불러올 수 없습니다."
    }
}
