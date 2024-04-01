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
        static let authRemained = "오늘 인증 요청 횟수가 %@회 남았습니다."
        static let authIncorrect = "입력한 인증코드가 일치하지 않습니다."
        static let countOver = "금일 해당 이메일로 인증 가능한 횟수가 초과되었습니다."
        
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
    
    enum Network {
        static let message = "네트워크 오류가 발생했습니다.\n잠시만 기다려주세요!"
    }

    enum Permission {
        static let title = "위치 권한 허용하면\n플쿠 즐길 준비 완료!"
        static let description1 = "플레이쿠라운드는 GPS를 활용하여\n건국대학교를 탐험하는 게임이에요!"
        static let descriptionBold = "GPS를 활용"
        static let description2 = "게임 플레이를 위해서는\n사용자분의 위치 정보가 필요해요."
        static let description3 = "설정에서 위치 권한 허용 후\n플레이쿠라운드를 마음껏 즐겨주세요!"
        static let openSetting = "설정으로 이동"
    }

    enum MyPage {
        static let title = "마이페이지"
        static let currentScore = "현재 점수"
        static let highestScore = "최고 점수"
        static let instagramURL = "https://www.instagram.com/playkuround_/"
        static let feedbackURL = "https://docs.google.com/forms/d/e/1FAIpQLSeBLSqnN9bXpPW3e4FTJR5hrnzikxB-e9toW0FaiWUdbOmHgg/viewform"
        static let bugURL = "https://docs.google.com/forms/d/e/1FAIpQLScyarAmbF6VPUrRWQ-SNlNCi9WpezXhNj0ixVyeYo9L67oxog/viewform"
        
        enum Title {
            static let my = "마이"
            static let shortcut = "바로가기"
            static let instruction = "이용안내"
        }
        
        enum My: String, CaseIterable {
            case story = "스토리 다시보기"
            case logout = "로그아웃"
        }
        
        enum Shortcut: String, CaseIterable {
            case instagram = "플레이쿠라운드 인스타그램"
            case cheer = "플쿠팀 응원하기"
            case feedback = "피드백 보내기"
            case bug = "오류 / 버그 제보 및 정보 제공"
        }
        
        enum Instruction: String, CaseIterable {
            case version = "앱 버전"
            case privacy = "개인정보 처리 방침"
            case terms = "이용약관"
        }
        
        enum Logout {
            static let message = "로그아웃 하시겠습니까?"
            static let ok = "예"
            static let no = "아니오"
        }
    }
    
    enum Game {
        static let play = "계속하기"
        static let home = "홈"
        static let timerTitle = "TIME"
        
        enum Result {
            static let score = "점"
            static let bestScore = "최고 점수"
            static let adventureScore = "모험 점수"
            static let out = "나가기"
        }
        
        enum Time {
            static let title = "10초를 맞춰봐"
            static let description = "10초에 가까워졌을 때 버튼을 눌러 멈춰주세요!\n±0.1초까지 인정됩니다."
            static let success = "성공하셨습니다. 축하합니다!"
            static let failure = "실패하셨습니다. 다시 시도해보세요!"
        }
        
        enum Moon {
            static let title = "MOON을 점령해"
            static let description = "달을 터치해서 깨주세요!"
        }
        
        enum Card {
            static let title = "책 뒤집기"
        }
    }
}
