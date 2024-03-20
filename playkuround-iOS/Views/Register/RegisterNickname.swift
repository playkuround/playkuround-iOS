//
//  RegisterNickname.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/21/24.
//

import SwiftUI

struct RegisterNickname: View {
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
                    if !isNicknameVaild {
                        Text(StringLiterals.Register.invalidNickname)
                            .font(.pretendard14R)
                            .foregroundStyle(.kuRed)
                    } else if isNicknameDuplicated {
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
                    .frame(width: .infinity)
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
                                .font(.pretendard15R)
                                .foregroundStyle(.kuText)
                                .padding()
                                .onChange(of: nickname) { newValue in
                                    if nicknameValidate(newValue) && newValue.count >= 2 && newValue.count <= 8 && !nickname.contains(" ") || nickname.isEmpty {
                                        withAnimation(.spring) {
                                            isNicknameVaild = true
                                        }
                                    } else {
                                        withAnimation(.spring) {
                                            isNicknameVaild = false
                                        }
                                    }
                                    
                                    // 닉네임 수정 시 초기화
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
                
                Button {
                    // 닉네임 올바른지 검사
                    if !isNicknameChecked {
                        isLoading = true
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
                } label: {
                    // .longButtonBlue : .longButtonGray
                    Image(isNicknameChecked ? (isNicknameDuplicated ? .longButtonGray : .longButtonBlue) : (isNicknameVaild && nickname.count >= 2 ? .longButtonBlue : .longButtonGray))
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .overlay {
                            if isLoading {
                                ProgressView()
                            } else {
                                Text("다음")
                                    .font(.neo15)
                                    .foregroundStyle(.kuText)
                            }
                        }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 10)
        }
    }
    
    func nicknameValidate(_ input: String) -> Bool {
        let pattern = "^[가-힣a-zA-Z\\s]*$"
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
    RegisterNickname()
}
