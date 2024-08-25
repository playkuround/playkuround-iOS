//
//  RegisterNickname.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/21/24.
//

import SwiftUI

struct RegisterNickname: View {
    @ObservedObject var viewModel: RootViewModel
    
    // 닉네임이 올바른지 검사
    @State private var isNicknameVaild: Bool = true
    @State private var isNicknameDuplicated: Bool = false
    @State private var isNicknameChecked: Bool = false
    
    // 닉네임 텍스트
    @State private var nickname: String = ""
    
    // 서버 요청 대기
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            Color.kuBackground.ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text(StringLiterals.Register.title)
                    .font(.neo24)
                    .foregroundStyle(.kuText)
                    .kerning(-0.41)
                    .padding(.bottom, 10)
                
                Text(StringLiterals.Register.nicknameDescription)
                    .font(.pretendard15R)
                    .foregroundStyle(.kuText)
                    .padding(.bottom, 60)
                
                HStack {
                    // 닉네임이 올바르지 않은 경우
                    if !isNicknameVaild {
                        Text(StringLiterals.Register.invalidNickname)
                            .font(.pretendard14R)
                            .foregroundStyle(.kuRed)
                    } 
                    // 닉네임이 중복된 경우
                    else if isNicknameDuplicated {
                        Text(StringLiterals.Register.duplicatedNickname)
                            .font(.pretendard14R)
                            .foregroundStyle(.kuRed)
                    }
                    Spacer()
                }
                .frame(height: 20)
                
                Image(.menuButton)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        ZStack {
                            if nickname.isEmpty {
                                HStack {
                                    Text(StringLiterals.Register.nicknamePlaceholder)
                                        .font(.pretendard15R)
                                        .foregroundStyle(.kuGray2)
                                    Spacer()
                                }
                                .padding()
                            }
                            
                            TextField("", text: $nickname)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .font(.pretendard15R)
                                .foregroundStyle(.kuText)
                                .padding()
                                .onChange(of: nickname) { newValue in
                                    // 닉네임이 영문/한글로만 구성, 공백문자 없음, 2~8자 사이 (비어있는 경우는 제외)
                                    if nicknameValidate(newValue) && newValue.count >= 2 && newValue.count <= 8 && !nickname.contains(" ") || nickname.isEmpty {
                                        withAnimation(.spring) {
                                            isNicknameVaild = true
                                        }
                                    } else {
                                        withAnimation(.spring) {
                                            isNicknameVaild = false
                                        }
                                    }
                                    
                                    // 닉네임 수정 시 중복 체크 flag 초기화
                                    isNicknameChecked = false
                                    isNicknameDuplicated = false
                                }
                        }
                    }
                
                Text(StringLiterals.Register.nicknamePolicy)
                    .font(.pretendard12R)
                    .foregroundStyle(.kuGray2)
                    .padding(.top, 4)
                
                Spacer()
                
                // 다음 버튼
                // if 닉네임이 검사된 경우
                //     if 닉네임이 중복된 경우 deactivate
                //     else activate
                // else (닉네임이 검사되기 전)
                //     if 닉네임이 valid한 경우 active
                //     else deactivate
                Image(isNicknameChecked ? (isNicknameDuplicated ? .longButtonGray : .longButtonBlue) : (isNicknameVaild && nickname.count >= 2 ? .longButtonBlue : .longButtonGray))
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        if isLoading {
                            // API 요청한 경우
                            ProgressView()
                        } else {
                            Text(StringLiterals.Register.next)
                                .font(.neo15)
                                .kerning(-0.41)
                                .foregroundStyle(.kuText)
                        }
                    }
                    .onTapGesture {
                        // 닉네임 올바른지 검사
                        if !isNicknameChecked && isNicknameVaild && nickname.count >= 2 {
                            isLoading = true
                            // 서버에 API 요청해서 닉네임 올바른지 검사
                            checkNicknameAvailability()
                        }
                    }
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 10)
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.RegisterNicknameView)
        }
    }
    
    // 서버 API 통해 닉네임이 사용 가능한지 검사
    private func checkNicknameAvailability() {
        APIManager.callGETAPI(endpoint: .availability, querys: ["nickname": nickname]) { result in
            switch result {
            case .success(let data):
                if let response = data as? BoolResponse {
                    print("nickname availability: ", response.response)
                    if response.response {
                        // TODO: 다음 뷰로 이동
                        isLoading = false
                        print("nickname is available, transfer to next view")
                        // TODO: 회원가입 프로세스 진행
                        
                        let email = UserDefaults.standard.string(forKey: "email") ?? ""
                        let major = UserDefaults.standard.string(forKey: "major") ?? ""
                        let authVerifyToken = TokenManager.token(tokenType: .authVerify)
                        
                        if email.isEmpty || major.isEmpty || authVerifyToken.isEmpty {
                            print("email, major, authVerifyToken is empty")
                            
                            // 로그인 화면으로 다시 이동
                            viewModel.transition(to: .login)
                        } else {
                            // 회원가입 API 호출
                            register(email: email, major: major, token: authVerifyToken)
                        }
                    } else {
                        isNicknameDuplicated = true
                        isNicknameChecked = true
                        isLoading = false
                    }
                } else {
                    isNicknameDuplicated = true
                    isNicknameChecked = true
                    isLoading = false
                }
            case .failure(let error):
                print("Error in View: \(error)")
                isNicknameDuplicated = true
                isNicknameChecked = true
                isLoading = false
            }
        }
    }
    
    private func register(email: String, major: String, token: String) {
        APIManager.callPOSTAPI(endpoint: .register, parameters: ["email": email, "nickname": nickname, "major": major, "authVerifyToken": token]) { result in
            switch result {
            case .success(let data):
                // TODO: Token 저장 및 Home으로 전환
                print(data)
                
                if let apiResponse = data as? APIResponse {
                    if apiResponse.isSuccess {
                        if let response = apiResponse.response {
                            if let accessToken = response.accessToken, let refreshToken = response.refreshToken {
                                TokenManager.setToken(tokenType: .refresh, token: refreshToken)
                                TokenManager.setToken(tokenType: .access, token: accessToken)
                                
                                // 임시 저장한 데이터 제거
                                UserDefaults.standard.removeObject(forKey: "email")
                                UserDefaults.standard.removeObject(forKey: "major")
                                
                                // 뷰 전환
                                viewModel.transition(to: .home)
                            }
                        }
                    }
                    else {
                        // 회원가입 실패
                        if let error = apiResponse.errorResponse?.message {
                            print(error)
                        }
                    }
                }
            case .failure(let data):
                // 회원가입 실패 메시지 (서버 오류 등)
                print(data)
                isNicknameDuplicated = false
                isNicknameChecked = false
                isLoading = false
            }
        }
    }
    
    // 닉네임 체크 (한글, 영어만 가능)
    private func nicknameValidate(_ input: String) -> Bool {
        let pattern = "^[가-힣a-zA-Z0-9\\s]*$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: input.utf16.count)
            if regex.firstMatch(in: input, options: [], range: range) != nil {
                return true
            }
        }
        return false
    }
}

#Preview {
    RegisterNickname(viewModel: RootViewModel())
}
