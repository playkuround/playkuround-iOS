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
}
