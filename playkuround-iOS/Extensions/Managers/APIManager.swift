//
//  APIManager.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/16/24.
//

import Combine
import Foundation
import SwiftUI

/// 서버와의 API 요청 및 통신을 담당하는 Manager
final class APIManager {
    // static으로 선언하여, instantiation 없이도 사용 가능함
    // deploy시 서버 타입 변경 필요!!!
    static let shared = APIManager(serverType: .dev)
    private var cancellables = Set<AnyCancellable>()

    // API 서버 종류별 address
    enum ServerType: String {
        case dev = "http://141.164.41.233:8080"
        case prod = "http://15.164.211.101"
    }
    
    // 현재 APIManager가 사용할 서버 종류 및 주소
    private var serverType: ServerType
    private var baseURL: String
    
    // API Error 종류
    enum APIError: Error {
        case decodingError
        case errorCode(Int)
        case unknown
    }
    
    // API 요청 반환 종류
    enum APIResponseResult {
        // 요청 결과 반환 성공
        case success
        // 요청 결과 반환 실패 (오류)
        case fail
        // 서버와의 연결 불가
        case lossConnection
    }
    
    // MARK: API Collections
    
    // GET 요청 API Collections
    enum GETAPICollections: String {
        // 출석 조회하기
        case attendances = "/api/attendances"
        // 인증 코드 확인
        case emails = "/api/auth/emails"
        // 뱃지 조회
        case badges = "/api/badges"
        // 가장 가까운 랜드마크 찾기
        case landmarks = "/api/landmarks"
        // 해당 랜드마크의 최고점 사용자 찾기
        case landmarksHighest = "/api/landmarks/%@/highest"
        // 종합 점수 TOP 100 얻기
        case scoresRank = "/api/scores/rank"
        // 해당 랜드마크의 점수 TOP 100 얻기
        case scoresRankLandmark = "/api/scores/rank/%@"
        // 프로필 얻기
        case users = "/api/users"
        // 유저 알림 얻기
        case notification = "/api/users/notification"
        // 게임별 최고 점수 얻기
        case gameScore = "/api/users/game-score"
        // 해당 닉네임이 사용 가능한지 체크
        case availability = "/api/users/availability"
        // 이벤트(공지) 조회
        case events = "/api/events"
    }
    
    // POST 요청 API Collections
    enum POSTAPICollections: String {
        // 탐험하기
        case adventures = "/api/adventures"
        // 출석하기
        case attendances = "/api/attendances"
        // access token 재발급
        case reissue = "/api/auth/reissue"
        // 인증 메일 전송
        case emails = "/api/auth/emails"
        // 오리의꿈 뱃지 획득
        case dreamOfDuck = "/api/badges/dream-of-duck"
        // 광고보고 쿠라운드 응원하기 버튼 클릭
        case fakeDoor = "/api/fake-door"
        // 회원가입
        case register = "/api/users/register"
        // 프로필 뱃지 설정
        case profileBadge = "/api/users/profile-badge"
        // 로그아웃
        case logout = "/api/users/logout"
    }
    
    // MARK: Initializer
    
    // static 인스턴스 생성자 (서버 타입 명시 필요)
    private init(serverType: ServerType) {
        self.serverType = serverType
        self.baseURL = serverType.rawValue
    }
    
    // MARK: - GET Request
    
    /// GET API 요청 함수
    /// 정상 응답 시 response가 담긴 Dictionary를 반환하고, 오류 발생 시 nil을 반환합니다.
    private static func fetchDataGET(from endpoint: GETAPICollections, 
                                     querys: [String: Any]? = nil,
                                     landmarkID: Int? = nil,
                                     completion: @escaping (Result<Any, Error>) -> Void) {
        // URL과 쿼리 파라미터를 포함하여 URLRequest 생성
        var urlComponents: URLComponents
        
        // URL String
        var urlString = APIManager.shared.serverType.rawValue + endpoint.rawValue
        
        // 두 API는 landmarkID가 필요
        if endpoint == .landmarksHighest || endpoint == .scoresRankLandmark {
            if let landmarkID = landmarkID {
                urlString = String(format: urlString, "\(landmarkID)")
            }
        }
        print("URL String: " + urlString)
        
        // URL Component 생성
        if let component = URLComponents(string: urlString) {
            urlComponents = component
        } else {
            // URL Component 생성 실패
            completion(.failure(NSError(domain: "Invalied URL", code: 0)))
            return
        }
        
        // URL Component에 Param Query 추가
        var queryItemList: [URLQueryItem] = []
        if let querys = querys {
            for (key, value) in querys {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                queryItemList.append(queryItem)
            }
        }
        urlComponents.queryItems = queryItemList
        
        // URLComponents에서 완전한 URL을 가져와서 사용
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalied URL", code: 0)))
            return
        }
        
        // Request Instance 생성
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)

        // 인증 헤더 추가
        // 닉네임 체크 availability API는 토큰 필요 X
        if endpoint != .availability && endpoint != .emails {
            let accessToken = TokenManager.token(tokenType: .access)
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }

        // HTTP 메소드 설정
        request.httpMethod = "GET"

        // 네트워크 요청 수행
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러 처리
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 응답 처리
            guard let httpResponse = response as? HTTPURLResponse else {
                // 응답이 올바르지 않은 경우
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            // access token 토큰 만료
            if httpResponse.statusCode == 401 {
                completion(.failure(NSError(domain: "Access Token is Fired, New Token is needed", code: 401)))
                return
            }
            
            // 데이터 파싱 및 출력
            guard let data = data else {
                // 데이터가 없는 경우
                completion(.failure(NSError(domain: "No data received", code: 0)))
                return
            }
            
            do {
                // JSON 디코딩
                let decoder = JSONDecoder()
                // let apiResponse = try decoder.decode([String: String].self, from: data)
                
                // MARK: 반환 결과가 특수한 API들 예외 처리
                
                // 뱃지 목록 조회 /api/badges
                if endpoint == .badges {
                    print("\n===== /api/badges ====\n")
                    let apiResponse = try decoder.decode(BadgeListResponse.self, from: data)
                    print("\(apiResponse)")
                    completion(.success(apiResponse))
                }
                
                // 유저 알림 조회 /api/users/notifications
                else if endpoint == .notification {
                    print("\n===== /api/users/notifications ====\n")
                    let apiResponse = try decoder.decode(NotificationAPIResponse.self, from: data)
                    print("\(apiResponse)")
                    completion(.success(apiResponse))
                }
                
                // 닉네임 사용 가능 여부 /api/users/availability
                else if endpoint == .availability {
                    print("\n===== /api/users/availability ====\n")
                    let apiResponse = try decoder.decode(BoolResponse.self, from: data)
                    print("\(apiResponse)")
                    completion(.success(apiResponse))
                }
                
                // 공지 이벤트 /api/events
                else if endpoint == .events {
                    print("\n===== /api/events ====\n")
                    let apiResponse = try decoder.decode(EventAPIResponse.self, from: data)
                    print("\(apiResponse)")
                    completion(.success(apiResponse))
                }
                
                // 기타 API들 처리
                else {
                    print("\n===== /api/\(endpoint.rawValue) ====\n")
                    let apiResponse = try decoder.decode(APIResponse.self, from: data)
                    print("\(apiResponse)")
                    completion(.success(apiResponse))
                }
                
                return
                
            } catch {
                // JSON 디코딩 오류 처리
                completion(.failure(error))
            }
        }
        
        // 네트워크 요청 시작
        task.resume()
    }
    
    // MARK: - POST Request
    
    /// POST API 요청 함수
    private static func fetchDataPOST(from endpoint: POSTAPICollections, 
                                      parameters: [String: Any]? = nil,
                                      completion: @escaping (Result<Any, Error>) -> Void) {
        // URL 생성
        let urlString = APIManager.shared.serverType.rawValue + endpoint.rawValue
        print("URL String: " + urlString)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalied URL", code: 0)))
            return
        }
        
        // URLRequest 생성
        var request = URLRequest(url: url)
        
        // HTTP 메소드 설정
        request.httpMethod = "POST"
        
        // 인증 헤더 추가
        // reissue, emails, register API는 토큰 필요 없음
        if endpoint != .reissue && endpoint != .emails && endpoint != .register {
            let accessToken = TokenManager.token(tokenType: .access)
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        // JSON으로 인코딩된 데이터 설정
        if let parameters = parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = jsonData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                // JSON Parsing 에러 발생
                completion(.failure(error))
                return
            }
        }
        
        // 네트워크 요청 수행
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러 처리
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 응답 처리
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            // reissue 했는데 토큰이 만료된 경우 refresh token을 재발급 받아야 함 (로그아웃)
            if httpResponse.statusCode == 401 && endpoint == .reissue {
                completion(.failure(NSError(domain: "Refresh Token is Fired, Do Logout Process", code: 998, userInfo: nil)))
                
                return
            }
            
            // Access Token이 만료된 경우
            else if httpResponse.statusCode == 401 {
                completion(.failure(NSError(domain: "Access Token is Fired", code: 401, userInfo: nil)))
                return
            }
            
            // 데이터 파싱 및 출력
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                // JSON 디코딩
                let decoder = JSONDecoder()
                
                // MARK: 반환 결과가 특수한 API들 예외 처리
                
                // 오리의꿈 뱃지 획득 /api/badges/dream-of-duck
                if endpoint == .dreamOfDuck {
                    print("\n===== /api/badges/dream-of-duck ====\n")
                    let apiResponse = try decoder.decode(BoolResponse.self, from: data)
                    print("\(apiResponse)")
                    completion(.success(apiResponse))
                }
                
                // 기타 API들 처리
                else {
                    print("\n===== /api/\(endpoint.rawValue) ====\n")
                    let apiResponse = try decoder.decode(APIResponse.self, from: data)
                    print("\(apiResponse)")
                    completion(.success(apiResponse))
                }
                
                return
                
            } catch {
                // JSON 디코딩 오류 처리
                completion(.failure(error))
            }
        }
        
        // 네트워크 요청 시작
        task.resume()
    }
}

// 아래 두 함수만 호출 가능
// 아래 두 함수는 Wrapping 함수로, 오류 발생, 토큰 만료 등을 처리합니다
extension APIManager {
    /// GET API를 호출합니다.
    /// access Token이 만료되었다면 재발급 후 API를 재요청합니다.
    static func callGETAPI(endpoint: GETAPICollections,
                           querys: [String: Any]? = nil,
                           depth: Int = 0,
                           landmarkID: Int? = nil,
                           completion: @escaping (Result<Any, Error>) -> Void) {
        // max depth reached return with error
        if depth >= 2 {
            completion(.failure(NSError(domain: "Reached to Max Depth of Call Recursion", code: 999)))
            return
        }
        
        // 토큰 불러오기
        // availability, emails API는 토큰 필요 없음
        if endpoint != .availability && endpoint != .emails {
            let accessToken = TokenManager.token(tokenType: .access)
            if accessToken.isEmpty {
                completion(.failure(NSError(domain: "No Access Token Found", code: 401)))
                return
            }
        }
        
        // API 요청 함수 호출
        fetchDataGET(from: endpoint, 
                     querys: querys,
                     landmarkID: landmarkID,
                     completion: { result in
            switch result {
            case .success(let data):
                // 성공 시 데이터 반환
                completion(.success(data))
            case .failure(let error):
                // 토큰 만료로 인한 거절 시, reissue API 호출하여 토큰 갱신 후 다시 API 호출
                // refresh token이 만료된 경우 로그아웃
                if let apiError = error as NSError?, apiError.code == 998 {
                    // 만료된 토큰 전부 삭제
                    TokenManager.reset()
                    completion(.failure(NSError(domain: "Refresh Token is Fired, Do Logout Process", code: 998)))
                    return
                }
                
                // access token이 만료된 경우 재발급 시도
                if let apiError = error as NSError?, apiError.code == 401 {
                    let refreshToken = TokenManager.token(tokenType: .refresh)
                    
                    if refreshToken.isEmpty {
                        completion(.failure(NSError(domain: "No Refresh Token Found, Do Logout Process", code: 998)))
                        return
                    }
                    
                    // reissue API 호출하여 token 재발급
                    fetchDataPOST(from: .reissue, 
                                  parameters: ["refreshToken": refreshToken],
                                  completion: { result in
                        switch result {
                        case .success(let tokenData):
                            // 토큰 갱신 후 다시 API 호출
                            if let response = tokenData as? APIResponse {
                                // 토큰 저장
                                if let accessToken = response.response?.accessToken {
                                    TokenManager.setToken(tokenType: .access, token: accessToken)
                                }
                                
                                if let refreshToken = response.response?.refreshToken {
                                    TokenManager.setToken(tokenType: .refresh, token: refreshToken)
                                }
                                
                                // 다시 API 호출
                                callGETAPI(endpoint: endpoint, 
                                           querys: querys,
                                           depth: depth + 1,
                                           completion: completion)
                            } else {
                                completion(.failure(NSError(domain: "Failed to Get New Tokens from Server", code: 0)))
                                return
                            }
                            
                        case .failure(let newError):
                            completion(.failure(newError))
                        }
                    })
                } else {
                    completion(.failure(error))
                }
            }
        })
    }
    
    /// POST API를 호출합니다.
    /// access Token이 만료되었다면 재발급 후 API를 재요청합니다.
    static func callPOSTAPI(endpoint: POSTAPICollections, 
                            parameters: [String: Any]? = nil,
                            depth: Int = 0,
                            completion: @escaping (Result<Any, Error>) -> Void) {
        // max depth reached return with error
        if depth >= 2 {
            completion(.failure(NSError(domain: "Reached to Max Depth of Call Recursion", code: 999)))
            return
        }
        
        // 토큰 불러오기
        // reissue, emails, register API는 토큰 없이 호출 가능
        if endpoint != .reissue && endpoint != .emails && endpoint != .register {
            let accessToken = TokenManager.token(tokenType: .access)
            print("accessToken: " + accessToken)
            if accessToken.isEmpty {
                completion(.failure(NSError(domain: "No Access Token Found", code: 401)))
                return
            }
        }
        
        // API 요청 함수 호출
        fetchDataPOST(from: endpoint, parameters: parameters, completion: { result in
            switch result {
            case .success(let data):
                // 성공 시 데이터 반환
                completion(.success(data))
            case .failure(let error):
                // 토큰 만료로 인한 거절 시, reissue API 호출하여 토큰 갱신 후 다시 API 호출
                // refresh token이 만료된 경우 로그아웃
                if let apiError = error as NSError?, apiError.code == 998 {
                    // 만료된 토큰 전부 삭제
                    TokenManager.reset()
                    completion(.failure(NSError(domain: "Refresh Token is Fired, Do Logout Process", code: 998)))
                    return
                }
                
                // access token이 만료된 경우 재발급 시도
                if let apiError = error as NSError?, apiError.code == 401 {
                    let refreshToken = TokenManager.token(tokenType: .refresh)
                    
                    if refreshToken.isEmpty {
                        completion(.failure(NSError(domain: "No Refresh Token Found, Do Logout Process", code: 998)))
                        return
                    }
                    
                    fetchDataPOST(from: .reissue, 
                                  parameters: ["refreshToken": refreshToken],
                                  completion: { result in
                        switch result {
                        case .success(let tokenData):
                            // 토큰 갱신 후 다시 API 호출
                            if let response = tokenData as? APIResponse {
                                // 토큰 저장
                                if let accessToken = response.response?.accessToken {
                                    TokenManager.setToken(tokenType: .access, token: accessToken)
                                }
                                
                                if let refreshToken = response.response?.refreshToken {
                                    TokenManager.setToken(tokenType: .refresh, token: refreshToken)
                                }
                                
                                // 다시 API 호출
                                callPOSTAPI(endpoint: endpoint, 
                                            parameters: parameters,
                                            depth: depth + 1,
                                            completion: completion)
                            } else {
                                completion(.failure(NSError(domain: "Failed to Get New Tokens from Server", code: 0)))
                                return
                            }
                            
                        case .failure(let newError):
                            completion(.failure(newError))
                        }
                    })
                } else {
                    completion(.failure(error))
                }
            }
        })
    }
}

/// API Manager Test View
struct APIManagerTestView: View {
    var body: some View {
        ZStack {
            VStack {
                List {
                    // MARK: - GET
                    
                    Section("GET") {
                        Button("가장 가까운 랜드마크 - /api/landmarks") {
                            APIManager.callGETAPI(endpoint: .landmarks, querys: ["latitude": 37.54040, "longitude": 127.07920]) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("뱃지 조회하기 - /api/badegs") {
                            APIManager.callGETAPI(endpoint: .badges) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("출석 조회하기 - /api/attendances") {
                            APIManager.callGETAPI(endpoint: .attendances) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                    
                                }
                            }
                        }
                        
                        Button("랜드마크 최고점 사용자 - /api/landmarks/25/highest") {
                            APIManager.callGETAPI(endpoint: .landmarksHighest, landmarkID: 25) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("종합 TOP100 - /api/scores/rank") {
                            APIManager.callGETAPI(endpoint: .scoresRank) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("랜드마크 TOP100 - /api/scores/rank/25") {
                            APIManager.callGETAPI(endpoint: .scoresRankLandmark, landmarkID: 25) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("유저 프로필 - /api/users") {
                            APIManager.callGETAPI(endpoint: .users) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("유저 알림 - /api/users/notifications") {
                            APIManager.callGETAPI(endpoint: .notification, querys: ["version": "2.0.2"]) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("닉네임 사용가능 - /api/users/availability") {
                            APIManager.callGETAPI(endpoint: .availability, querys: ["nickname": "leehe228"]) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("게임별 최고 점수 - /api/users/game-score") {
                            APIManager.callGETAPI(endpoint: .gameScore) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("인증 코드 확인 - /api/auth/emails") {
                            APIManager.callGETAPI(endpoint: .emails, querys: ["code": "dflMt5", "email": "leehe228@konkuk.ac.kr"]) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("이벤트 받아오기 - /api/events") {
                            APIManager.callGETAPI(endpoint: .events) { result in
                                switch result {
                                case .success(let data):
                                    print("/api/events data: \(data)")
                                case .failure(let error):
                                    print("/api/events error: \(error)")
                                }
                            }
                        }
                    }
                    
                    // MARK: - POST
                    
                    Section("POST") {
                        Button("탐험하기 - /api/adventures") {
                            APIManager.callPOSTAPI(endpoint: .adventures, parameters: ["landmarkId": 25, "latitude": 37.54040, "longitude": 127.07920, "score": 100, "scoreType": "QUIZ"]) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("출석하기 - /api/attendances") {
                            APIManager.callPOSTAPI(endpoint: .attendances, parameters: ["latitude": 37.54040, "longitude": 127.07920]) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("오리의꿈 뱃지 - /api/badges/dream-of-duck") {
                            APIManager.callPOSTAPI(endpoint: .dreamOfDuck) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("인증코드 재발급 - /api/auth/reissue") {
                            let refreshToken = TokenManager.token(tokenType: .refresh)
                            APIManager.callPOSTAPI(endpoint: .reissue, parameters: ["refreshToken": refreshToken]) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("인증메일 전송 - /api/auth/emails") {
                            APIManager.callPOSTAPI(endpoint: .emails, parameters: ["target": "leehe228@konkuk.ac.kr"]) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("회원가입 - /api/users/register") {
                            let authVerifyToken = TokenManager.token(tokenType: .authVerify)
                            APIManager.callPOSTAPI(endpoint: .register, parameters: ["email": "leehe228@konkuk.ac.kr", "nickname": "leehe228", "major": "컴퓨터공학부", "authVerifyToken": authVerifyToken]) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                        
                        Button("프로필 뱃지 설정 - /api/users/profile-badge") {
                            APIManager.callPOSTAPI(endpoint: .profileBadge, parameters: ["profileBadge": "ATTENDANCE_1"]) { result in
                                switch result {
                                case .success(let data):
                                    print("(success) /api/users/profile-badge: \(data)")
                                case .failure(let error):
                                    print("(fail) /api/users/profile-badge: \(error)")
                                }
                            }
                        }
                        
                        Button("로그아웃 - /api/users/logout") {
                            APIManager.callPOSTAPI(endpoint: .logout) { result in
                                switch result {
                                case .success(let data):
                                    print("Data received in View: \(data)")
                                case .failure(let error):
                                    print("Error in View: \(error)")
                                }
                            }
                        }
                    }
                }
            }
        }
        /* .onAppear {
            // 테스트 하기 위해 토큰을 제거
            TokenManager.reset()
        } */
    }
}

#Preview {
    APIManagerTestView()
}

// MARK: API Response 구조화

struct APIResponse: Codable {
    let isSuccess: Bool
    let response: Response?
    let errorResponse: ErrorResponse?
}

// 정상 응답 시 response 구조화
struct Response: Codable {
    // 출석 조회 (/api/attendances)
    let attendances: [String]?
    
    // 회원가입용 인증 토큰 (/api/emails)
    let authVerifyToken: String?
    
    // 토큰 정보 (/api/reissue, /api/users/register)
    let grantType: String?
    let accessToken: String?
    let refreshToken: String?
    
    // 이메일 인증 관련 (/api/emails)
    let expireAt: String?
    let sendingCount: Int?
    
    // 가장 가까운 랜드마크 (/api/landmarks)
    let name: String?
    let distance: Double?
    let landmarkId: Int? // 서버 API 반환 타입명과 맞추어야 하므로 컨벤션 예외
    
    // 랜드마크 최고점 사용자 (/api/landmarks/0)
    let nickname: String?
    let score: Int?
    
    // 종합 점수 탑100 (/api/scores/rank)
    let myRank: MyRank?
    let rank: [Ranking]?
    
    // 사용자 프로필 (/api/users)
    let email: String?
    let major: String?
    let highestScore: Int?
    let highestRank: String?
    let attendanceDays: Int?
    let profileBadge: String?
    
    // 게임별 최고 점수 얻기 (/api/users/game-score)
    let highestTotalScore: Int?
    let highestQuizScore: Int?
    let highestTimeScore: Int?
    let highestMoonScore: Int?
    let highestCardScore: Int?
    let highestCatchScore: Int?
    let highestHongBridgeScore: Int?
    let highestAllClearScore: Int?
    let highestMicrobeScore: Int?
    
    // 뱃지 (newBadges)
    let newBadges: [BadgeResponse]?
}


// 오류 발생 시 errorResponse 구조화
struct ErrorResponse: Codable {
    let status: Int
    let code: String
    let message: String
}

// MARK: - 구조체 안에 사용되는 특이한 struct들

// 뱃지 리스트
struct BadgeResponse: Codable {
    let name: String
    let description: String
}

// 랭킹
struct MyRank: Codable {
    var score: Int
    var ranking: Int
    var profileBadge: String
}

struct Ranking: Codable {
    let nickname: String
    let score: Int
    let profileBadge: String
}

// MARK: - 특이한 반환을 가진 API용 struct 따로 구현

// 뱃지 조회 (/api/badges)
struct BadgeListResponse: Codable {
    let isSuccess: Bool
    let response: [BadgeResponse]
}

// 오리의 꿈 뱃지 획득, 닉네임 가능한지 체크 (/api/badges/dream-of-duck, availability)
// 아래 두 API는 response가 Bool type임
struct BoolResponse: Codable {
    let isSuccess: Bool
    let response: Bool
}

struct NotificationVariableResponse: Codable {
    let name: String
    let description: String
}

// 사용자 알림 (/api/users/notifications)
struct NotificationAPIResponse: Codable {
    let isSuccess: Bool
    let response: [NotificationVariableResponse]?
    let errorResponse: ErrorResponse?
}

// 공지 알림 (/api/events)
struct Event: Codable {
    let id: Int
    let title: String
    let imageUrl: String?
    let description: String?
    let referenceUrl: String?
}

struct EventAPIResponse: Codable {
    let isSuccess: Bool
    let response: [Event]?
    let errorResponse: ErrorResponse?
}
