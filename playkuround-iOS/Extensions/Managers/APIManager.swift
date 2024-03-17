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
        case dev = "http://plku.kro.kr:8080"
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
        case scoresRank = "api/scores/rank"
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
        // 로그아웃
        case logout = "/api/users/logout"
    }
    
    // 서버 요청 오류 시 반환 양식 struct
    struct APIErrorResponse {
        
    }
    
    // MARK: Initializer
    
    // static 인스턴스 생성자 (서버 타입 명시 필요)
    private init(serverType: ServerType) {
        self.serverType = serverType
        self.baseURL = serverType.rawValue
    }
    
    // MARK: - GET Request
    
    /// GET API 요청 함수
    static func fetchData<T: Decodable>(from endpoint: GETAPICollections, queryItems: [URLQueryItem]? = nil, landmarkID: Int? = nil) -> AnyPublisher<T, APIError> {
        // URL Component
        var components = URLComponents()
        
        // landmark 관련 API (landmakrHighest, scoresRankLandmark)는 landmark ID로 replace
        if endpoint == .landmarksHighest || endpoint == .scoresRankLandmark {
            // landmarkID가 nil이 아니라면
            if let landmarkID = landmarkID {
                if let urlComponents = URLComponents(string: "\(shared.baseURL)\(endpoint.rawValue)") {
                    components = urlComponents
                } else {
                    // URL을 생성할 수 없는 경우 오류 반환
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
            } else {
                // landmarkID가 nil이므로 오류 반환
                return Fail(error: APIError.unknown).eraseToAnyPublisher()
            }
        } else {
            // 일반 요청 URL
            if let urlComponents = URLComponents(string: "\(shared.baseURL)\(endpoint.rawValue)") {
                components = urlComponents
            } else {
                // URL을 생성할 수 없는 경우 오류 반환
                return Fail(error: APIError.unknown).eraseToAnyPublisher()
            }
        }
        
        // Query Item 추가
        if let queryItems = queryItems {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            let error = APIError.unknown
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        // TODO: Token Manager 구현 후 수정 필요
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: T.self, decoder: JSONDecoder())
                            .mapError { _ in APIError.decodingError }
                            .eraseToAnyPublisher()
                    } else {
                        let error = APIError.errorCode(response.statusCode)
                        return Fail(error: error).eraseToAnyPublisher()
                    }
                } else {
                    let error = APIError.unknown
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - POST Request
    
    /// POST API 요청 함수
    static func sendData<T: Encodable, U: Decodable>(endpoint: POSTAPICollections, body: T) -> AnyPublisher<U, APIError> {
        // 요청 URL
        guard let url = URL(string: "\(shared.baseURL)\(endpoint.rawValue)") else {
            let error = APIError.unknown
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        // TODO: Token Manager 구현 후 수정 필요
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<U, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: U.self, decoder: JSONDecoder())
                            .mapError { _ in APIError.decodingError }
                            .eraseToAnyPublisher()
                    } else {
                        let error = APIError.errorCode(response.statusCode)
                        return Fail(error: error).eraseToAnyPublisher()
                    }
                } else {
                    let error = APIError.unknown
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

/// API Manager Test View
struct APIManagerTestView: View {
    // 선택한 POST API
    @State private var selectedPOSTAPI: APIManager.POSTAPICollections = .adventures
    
    var body: some View {
        VStack {
            Button("test api") {
                //
            }
        }
    }
}

#Preview {
    APIManagerTestView()
}
