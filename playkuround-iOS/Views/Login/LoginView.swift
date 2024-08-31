//
//  LoginView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/15/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: RootViewModel
    
    // 포탈 아이디
    @State private var userId: String = ""
    // @FocusState private var focusField: Bool
    
    // 인증코드 요청
    @State private var mailButtonTitle = NSLocalizedString("Login.RequestCode", comment: "")
    @State private var mailButtonClicked: Bool = false
    
    // 인증시간 초과 바텀시트
    @State private var isBottomSheetPresented: Bool = false
    
    // 인증코드 검사
    @State private var isMaximumCount: Bool = false
    @State private var userSendingCount: Int?
    @State private var isAuthCodeViewVisible: Bool = false
    
    @State private var keyboardOffset: CGFloat = 0
    @FocusState private var focusedField: FieldFocus?
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color.kuBackground.ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Login.Hello")
                    .font(.neo24)
                    .foregroundStyle(.kuText)
                    .kerning(-0.41)
                    .padding(.bottom, 10)
                
                Text("Login.Description")
                    .font(.pretendard15R)
                    .foregroundStyle(.kuText)
                    .padding(.bottom, 48)
                
                Image(.longButtonWhite)
                    .overlay {
                        TextField(NSLocalizedString("Login.PlaceHolder", comment: ""), text: $userId)
                            .font(.pretendard15R)
                            .kerning(-0.41)
                            // .focused($focusField)
                            .focused($focusedField, equals: .userId)
                            .padding(.leading, 20)
                            .overlay {
                                Text("Login.Email")
                                    .font(.pretendard15R)
                                    .foregroundStyle(.gray)
                                    .opacity(userId.isEmpty && focusedField != .userId ? 0 : 1)
                                    .padding(.leading, 190)
                            }
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                
                Button(action: {
                    mailButtonClicked.toggle()
                    soundManager.playSound(sound: .buttonClicked)
                    
                    // 이메일 전송 버튼 이벤트
                    GAManager.shared.logEvent(.SEND_EMAIL)
                    
                    if mailButtonClicked {
                        mailButtonTitle = userId.isEmpty ? NSLocalizedString("Login.RequestCode", comment: "")
                        : NSLocalizedString("Login.ReRequestCode", comment: "")
                    }
                    
                    callPOSTAPIemails(target: userId + NSLocalizedString("Login.Email", comment: ""))
                    
                    focusedField = .authCode
                    
                    if !isMaximumCount {
                        self.isAuthCodeViewVisible = true
                    }
                }, label: {
                    Image(userId.isEmpty ? .longButtonGray : .longButtonBlue)
                        .overlay {
                            Text(mailButtonTitle)
                                .font(.neo15)
                                .foregroundStyle(.kuText)
                                .kerning(-0.41)
                        }
                })
                .disabled(userId.isEmpty)
                
                if isMaximumCount {
                    Text("Login.CountOver")
                        .font(.pretendard12R)
                        .kerning(-0.41)
                        .foregroundStyle(.kuRed)
                        .padding(.top, 7)
                }
                
                if isAuthCodeViewVisible {
                    AuthenticationCodeView(viewModel: viewModel, 
                                           userSendingCount: $userSendingCount,
                                           isTimerFinished: $isBottomSheetPresented,
                                           userEmail: userId + NSLocalizedString("Login.Email", comment: ""))
                    .focused($focusedField, equals: .authCode)
                }
                
                Spacer()
            }
            .padding(.top, 80)
            .offset(y: -keyboardOffset)
            
            // 인증 시간 초과 되었을 때
            if isBottomSheetPresented {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isBottomSheetPresented.toggle()
                    }
                
                LoginBottomSheetView(isPresented: $isBottomSheetPresented)
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        isAuthCodeViewVisible = false
                    }
            }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.LoginView)
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    if focusedField == .authCode {
                        withAnimation(.easeInOut) {
                            keyboardOffset = keyboardFrame.height / 4
                        }
                    }
                }
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                withAnimation(.easeInOut) {
                    keyboardOffset = 0
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
    }
    
    private func callPOSTAPIemails(target: String) {
        // Save target email to UserDefaults
        UserDefaults.standard.set(target, forKey: "email")
        
        // 심사용 계정 예외 처리
        for account in adminAccountInfo {
            if target.lowercased() == account.email {
                APIManager.shared.changeServerType(to: .dev) // 개발 서버로 전환
                UserDefaults.standard.setValue(true, forKey: "IS_ADMIN")
            }
        }
        
        APIManager.shared.callPOSTAPI(endpoint: .emails,
                               parameters: ["target" : target.lowercased()]) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                
                if let response = data as? APIResponse {
                    if response.isSuccess {
                        if let count = response.response?.sendingCount {
                            isAuthCodeViewVisible = true
                            isMaximumCount = false
                            userSendingCount = count
                        }
                    }
                    else {
                        if UserDefaults.standard.bool(forKey: "IS_ADMIN") {
                            isAuthCodeViewVisible = true
                            isMaximumCount = false
                            userSendingCount = 0
                        }
                        // 하루 인증 횟수를 초과했을 때
                        else if response.errorResponse?.code == "E004" {
                            isAuthCodeViewVisible = false
                            isMaximumCount = true
                            mailButtonClicked = false
                            self.viewModel.openToastMessageView(message: NSLocalizedString("Login.ToastMessage.overNumMail", comment: ""))
                        }
                    }
                }
            case .failure(let error):
                print("Error in View: \(error)")
                self.viewModel.openToastMessageView(message: NSLocalizedString("Login.ToastMessage.EmailSendFail", comment: ""))
            }
        }
    }
}

enum FieldFocus: Hashable {
    case userId
    case authCode
}

#Preview {
    LoginView(viewModel: RootViewModel())
}
