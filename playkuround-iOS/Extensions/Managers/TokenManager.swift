//
//  TokenManager.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/17/24.
//

import SwiftUI

final class TokenManager {
    // Static Class로 사용
    static let shared = TokenManager()
    
    // 현재 토큰 정보를 반환합니다
    static func token(tokenType: TokenType) -> String {
        switch tokenType {
        case .authVerify:
            // auth verify token을 반환
            if let token = UserDefaults.standard.string(forKey: "AUTH_VERIFY_TOKEN") {
                return token
            } else {
                // 값이 없다면 빈 값을 반환합니다
                return ""
            }
        case .access:
            // access token을 반환
            if let token = UserDefaults.standard.string(forKey: "ACCESS_TOKEN") {
                return token
            } else {
                // 값이 없다면 빈 값을 반환합니다
                return ""
            }
        case .refresh:
            // refresh token을 반환
            if let token = UserDefaults.standard.string(forKey: "REFRESH_TOKEN") {
                return token
            } else {
                // 값이 없다면 빈 값을 반환합니다
                return ""
            }
        }
    }
    
    // 토큰 정보를 새로 저장합니다
    // 토큰 정보를 지우려면 빈 문자열 ""를 저장하면 됩니다
    static func setToken(tokenType: TokenType, token: String) {
        switch tokenType {
        case .authVerify:
            // auth verify token을 저장
            UserDefaults.standard.setValue(token, forKey: "AUTH_VERIFY_TOKEN")
        case .access:
            // access token을 저장
            UserDefaults.standard.setValue(token, forKey: "ACCESS_TOKEN")
        case .refresh:
            // refresh token을 저장
            UserDefaults.standard.setValue(token, forKey: "REFRESH_TOKEN")
        }
    }
    
    // 로그아웃 시 모든 토큰 정보 삭제
    // 특정 토큰 타입을 명시할 경우 해당 토큰 데이터만 삭제
    static func reset(tokenType: TokenType?) {
        switch tokenType {
        case .authVerify:
            // auth verify token을 저장
            UserDefaults.standard.removeObject(forKey: "AUTH_VERIFY_TOKEN")
        case .access:
            // access token을 저장
            UserDefaults.standard.removeObject(forKey: "ACCESS_TOKEN")
        case .refresh:
            // refresh token을 저장
            UserDefaults.standard.removeObject(forKey: "REFRESH_TOKEN")
        case nil:
            // token type이 명시되지 않아 nil인 경우 모든 토큰 정보 삭제
            UserDefaults.standard.removeObject(forKey: "AUTH_VERIFY_TOKEN")
            UserDefaults.standard.removeObject(forKey: "ACCESS_TOKEN")
            UserDefaults.standard.removeObject(forKey: "REFRESH_TOKEN")
        }
    }
}

/// 토큰 종류를 나타내는 enum, RawValue는 Description
enum TokenType: String {
    // 이메일 인증 시 사용되는 auth verify token
    case authVerify = "authVerify"
    // access token
    case access = "access"
    // refresh token
    case refresh = "refresh"
}

/// Token Manager 테스트용 뷰
struct TokenManagerTestView: View {
    @State private var selectedTokenType: TokenType = .authVerify
    @State private var selectedTokenValue: String = ""
    
    var body: some View {
        VStack {
            Text("Token")
                .font(.title)
            
            // Token Type 선택
            Menu("token type: " + selectedTokenType.rawValue) {
                Button("authVerify") {
                    selectedTokenType = .authVerify
                }
                Button("access") {
                    selectedTokenType = .access
                }
                Button("refresb") {
                    selectedTokenType = .refresh
                }
            }
            
            // Token 입력 Text Field
            TextField("enter token value:", text: $selectedTokenValue)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
            
            // 저장 버튼 (토큰을 저장 후 Text Field를 초기화
            Button("save") {
                TokenManager.setToken(tokenType: selectedTokenType, token: selectedTokenValue)
                selectedTokenValue = ""
            }
            
            // 선택된 Token Type의 저장된 값을 불러옴
            Button("Load") {
                selectedTokenValue = TokenManager.token(tokenType: selectedTokenType)
            }
            
            // Text Field를 지움
            Button("Clear") {
                selectedTokenValue = ""
            }
        }
    }
}

#Preview {
    TokenManagerTestView()
}
