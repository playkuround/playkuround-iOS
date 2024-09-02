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
    @State private var isNicknameChecked: Bool = false
    
    // 닉네임 텍스트
    @State private var nickname: String = ""
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color.kuBackground.ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Register.Title")
                    .font(.neo24)
                    .foregroundStyle(.kuText)
                    .kerning(-0.41)
                    .padding(.bottom, 10)
                
                Text("Register.NicknameDescription")
                    .font(.pretendard15R)
                    .foregroundStyle(.kuText)
                    .padding(.bottom, 60)
                
                HStack {
                    // 닉네임이 올바르지 않은 경우
                    if !isNicknameVaild && !nickname.isEmpty {
                        Text("Register.InvalidNickname")
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
                                    Text("Register.NicknamePlaceholder")
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
                                .foregroundStyle(isNicknameVaild ? .kuText : .kuRed)
                                .padding()
                                .onChange(of: nickname) { newValue in
                                    if !newValue.isEmpty {
                                        checkNicknameAvailability(newValue)
                                    }
                                }
                        }
                    }
                
                let policy = NSLocalizedString("Register.NicknamePolicy", comment: "")
                    .replacingOccurrences(of: "<br>", with: "\n")
                
                Text(policy)
                    .font(.pretendard12R)
                    .foregroundStyle(.kuGray2)
                    .padding(.top, 4)
                
                Spacer()
                
                Button {
                    if !nickname.isEmpty && isNicknameVaild {
                        viewModel.openLoadingView()
                        soundManager.playSound(sound: .buttonClicked)
                        checkNicknameBeforeRegister()
                    }
                } label: {
                    // Image(isNicknameChecked ? (isNicknameDuplicated ? .longButtonGray : .longButtonBlue) : (isNicknameVaild && nickname.count >= 2 ? .longButtonBlue : .longButtonGray))
                    Image(nickname.isEmpty || !isNicknameVaild ? .longButtonGray : .longButtonBlue)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Text("Register.Done")
                                .font(.neo15)
                                .kerning(-0.41)
                                .foregroundStyle(.kuText)
                        }
                }
                .disabled(nickname.isEmpty || !isNicknameVaild)
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 10)
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.RegisterNicknameView)
        }
    }
    
    private func checkNicknameAvailability(_ newNickname: String) {
        print(newNickname)
        if newNickname.count < 2 || newNickname.count > 8 || newNickname.contains(" ") || newNickname.isEmpty {
            withAnimation(.spring(duration: 0.2)) {
                self.isNicknameVaild = false
            }
            print("nickname is invalid 1")
            return
        }
        
        if !nicknameValidate(newNickname) {
            withAnimation(.spring(duration: 0.2)) {
                self.isNicknameVaild = false
            }
            print("nickname is invalid 2")
            return
        }
        
        APIManager.shared.callGETAPI(endpoint: .availability, querys: ["nickname": newNickname]) { result in
            switch result {
            case .success(let data):
                print(data)
                if let response = data as? BoolResponse {
                    if response.response {
                        self.isNicknameVaild = true
                    } else {
                        self.isNicknameVaild = false
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // 서버 API 통해 닉네임이 사용 가능한지 검사
    private func checkNicknameBeforeRegister() {
        APIManager.shared.callGETAPI(endpoint: .availability, querys: ["nickname": nickname]) { result in
            switch result {
            case .success(let data):
                if let response = data as? BoolResponse {
                    print("nickname availability: ", response.response)
                    if response.response {
                        // TODO: 다음 뷰로 이동
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
                        viewModel.closeLoadingView()
                        isNicknameChecked = true
                        self.viewModel.openToastMessageView(message: NSLocalizedString("Register.ToastMessage.NicknameDuplicated", comment: ""))
                    }
                } else {
                    viewModel.closeLoadingView()
                    self.viewModel.openToastMessageView(message: NSLocalizedString("Network.ServerError", comment: ""))
                }
            case .failure(let error):
                print("Error in View: \(error)")
                viewModel.closeLoadingView()
                isNicknameChecked = true
                self.viewModel.openToastMessageView(message: NSLocalizedString("Network.ServerError", comment: ""))
                
            }
        }
    }
    
    private func register(email: String, major: String, token: String) {
        APIManager.shared.callPOSTAPI(endpoint: .register, parameters: ["email": email, "nickname": nickname, "major": major, "authVerifyToken": token]) { result in
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
                                
                                // 회원가입 성공 이벤트
                                GAManager.shared.logEvent(.REGISTER_SUCCESS)
                                
                                // 뷰 전환
                                viewModel.transition(to: .home)
                            } else {
                                self.viewModel.openToastMessageView(message: NSLocalizedString("Register.ToastMessage.RegisterFailed", comment: ""))
                                viewModel.closeLoadingView()
                            }
                            
                            // 뱃지 열기
                            var newBadgeNameList: [String] = []
                            
                            if let newBadges = response.newBadges {
                                for newBadge in newBadges {
                                    newBadgeNameList.append(newBadge.name)
                                }
                            }
                            
                            print("** newBadgeList: \(newBadgeNameList)")
                            
                            DispatchQueue.main.async {
                                self.viewModel.openNewBadgeView(badgeNames: newBadgeNameList)
                            }
                        } else {
                            viewModel.closeLoadingView()
                        }
                    }
                    else {
                        // 회원가입 실패
                        if let error = apiResponse.errorResponse?.message {
                            print(error)
                            viewModel.closeLoadingView()
                            self.viewModel.openToastMessageView(message: NSLocalizedString("Register.ToastMessage.RegisterFailed", comment: ""))
                        } else {
                            viewModel.closeLoadingView()
                        }
                    }
                }
            case .failure(let data):
                // 회원가입 실패 메시지 (서버 오류 등)
                print(data)
                viewModel.closeLoadingView()
                isNicknameChecked = false
                self.viewModel.openToastMessageView(message: NSLocalizedString("Register.ToastMessage.RegisterFailed", comment: ""))
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
