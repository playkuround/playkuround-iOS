//
//  RegisterTermsView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/21/24.
//

import SwiftUI

struct RegisterTermsView: View {
    @ObservedObject var viewModel: RootViewModel
    
    // 각 이용약관 동의 여부
    @State private var isServiceTermAgreed: Bool = false
    @State private var isPrivacyTermAgreed: Bool = false
    @State private var isLocationTermAgreed: Bool = false
    
    // 이용약관 뷰 sheet 표시 여부
    @State private var isServiceTermsViewPresented: Bool = false
    @State private var isPrivacyTermsViewPresented: Bool = false
    @State private var isLocationTermsViewPresented: Bool = false
    
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
                
                Text("Register.TermsDescription")
                    .font(.pretendard15R)
                    .foregroundStyle(.kuText)
                    .padding(.bottom, 30)
                
                // 전체 동의 버튼
                Button {
                    if isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed {
                        withAnimation(.spring(duration: 0.2)) {
                            isServiceTermAgreed = false
                            isPrivacyTermAgreed = false
                            isLocationTermAgreed = false
                        }
                    } else {
                        soundManager.playSound(sound: .buttonClicked)
                        withAnimation(.spring(duration: 0.2)) {
                            isServiceTermAgreed = true
                            isPrivacyTermAgreed = true
                            isLocationTermAgreed = true
                        }
                    }
                } label: {
                    Image(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            HStack {
                                Image(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .blackCheck : .whiteCheck)
                                    .padding(.trailing, 10)
                                Text("Register.AgreeAllTerms")
                                    .font(.neo15)
                                    .kerning(-0.41)
                                    .foregroundStyle(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .kuText : .white)
                                Spacer()
                            }
                            .padding(20)
                        }
                }
                
                Image(.grayLine)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 3)
                
                // 서비스 이용 약관 동의 버튼
                Button {
                    withAnimation(.spring(duration: 0.2)) {
                        isServiceTermAgreed.toggle()
                        soundManager.playSound(sound: .buttonClicked)
                    }
                } label: {
                    Image(isServiceTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            HStack {
                                Image(isServiceTermAgreed ? .blackCheck : .whiteCheck)
                                    .padding(.trailing, 10)
                                Text("Register.AgreeServiceTerms")
                                    .font(.neo15)
                                    .kerning(-0.41)
                                    .foregroundStyle(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .kuText : .white)
                                Spacer()
                                Button {
                                    // TermsView 보여줌
                                    isServiceTermsViewPresented = true
                                    soundManager.playSound(sound: .buttonClicked)
                                } label: {
                                    Image(isServiceTermAgreed ? .rightBlackArrow : .rightWhiteArrow)
                                        // 버튼 잘 눌릴 수 있게 왼쪽, 위아래로 패딩을 줌
                                        .padding(.leading, 15)
                                        .padding(.vertical, 6)
                                }
                            }
                            .padding(20)
                        }
                }
                
                // 개인정보 수집 및 이용 동의
                Button {
                    withAnimation(.spring(duration: 0.2)) {
                        isPrivacyTermAgreed.toggle()
                        soundManager.playSound(sound: .buttonClicked)
                    }
                } label: {
                    Image(isPrivacyTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            HStack {
                                Image(isPrivacyTermAgreed ? .blackCheck : .whiteCheck)
                                    .padding(.trailing, 10)
                                Text("Register.AgreePrivacyTerms")
                                    .font(.neo15)
                                    .kerning(-0.41)
                                    .foregroundStyle(isPrivacyTermAgreed ? .kuText : .white)
                                Spacer()
                                Button {
                                    // TermsView 보여줌
                                    isPrivacyTermsViewPresented = true
                                    soundManager.playSound(sound: .buttonClicked)
                                } label: {
                                    Image(isPrivacyTermAgreed ? .rightBlackArrow : .rightWhiteArrow)
                                        // 버튼 잘 눌릴 수 있게 왼쪽, 위아래로 패딩을 줌
                                        .padding(.leading, 15)
                                        .padding(.vertical, 6)
                                }
                            }
                            .padding(20)
                        }
                }
                
                // 위치기반 서비스 이용약관 동의
                Button {
                    withAnimation(.spring(duration: 0.2)) {
                        isLocationTermAgreed.toggle()
                        soundManager.playSound(sound: .buttonClicked)
                    }
                } label: {
                    Image(isLocationTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            HStack {
                                Image(isLocationTermAgreed ? .blackCheck : .whiteCheck)
                                    .padding(.trailing, 10)
                                Text("Register.AgreeLocationTerms")
                                    .font(.neo15)
                                    .kerning(-0.41)
                                    .foregroundStyle(isLocationTermAgreed ? .kuText : .white)
                                Spacer()
                                Button {
                                    // TermsView 보여줌
                                    isLocationTermsViewPresented = true
                                    soundManager.playSound(sound: .buttonClicked)
                                } label: {
                                    Image(isLocationTermAgreed ? .rightBlackArrow : .rightWhiteArrow)
                                        // 버튼 잘 눌릴 수 있게 왼쪽, 위아래로 패딩을 줌
                                        .padding(.leading, 15)
                                        .padding(.vertical, 6)
                                }
                            }
                            .padding(20)
                        }
                }
                
                Spacer()
                
                // 다음 버튼
                Button {
                    if isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed {
                        // 다음 뷰로 이동
                        // 뷰 전환
                        viewModel.transition(to: .registerMajor)
                        soundManager.playSound(sound: .buttonClicked)
                    }
                } label: {
                    Image(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Text("Register.Next")
                                .font(.neo15)
                                .kerning(-0.41)
                                .foregroundStyle(.kuText)
                        }
                }
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 10)
        }
        .fullScreenCover(isPresented: $isServiceTermsViewPresented) {
            TermsView(title: NSLocalizedString("Register.ServiceTermsTitle", comment: ""), termsType: .service)
        }
        .fullScreenCover(isPresented: $isPrivacyTermsViewPresented) {
            TermsView(title: NSLocalizedString("Register.PrivacyTermsTitle", comment: ""), termsType: .privacy)
        }
        .fullScreenCover(isPresented: $isLocationTermsViewPresented) {
            TermsView(title: NSLocalizedString("Register.LocationTermsTitle", comment: ""), termsType: .location)
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.RegisterTermsView)
        }
    }
}

#Preview {
    RegisterTermsView(viewModel: RootViewModel())
}
