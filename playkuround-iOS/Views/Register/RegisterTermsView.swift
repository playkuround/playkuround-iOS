//
//  RegisterTermsView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/21/24.
//

import SwiftUI

struct RegisterTermsView: View {
    // 각 이용약관 동의 여부
    @State private var isServiceTermAgreed: Bool = false
    @State private var isPrivacyTermAgreed: Bool = false
    @State private var isLocationTermAgreed: Bool = false
    
    // 이용약관 뷰 sheet 표시 여부
    @State private var isTermsViewPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color.kuBackground.ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text(StringLiterals.Register.title)
                    .font(.neo24)
                    .foregroundStyle(.kuText)
                    .kerning(-0.41)
                    .padding(.bottom, 10)
                
                Text(StringLiterals.Register.termsDescription)
                    .font(.pretendard15R)
                    .foregroundStyle(.kuText)
                    .padding(.bottom, 30)
                
                // 전체 동의 버튼
                Button {
                    isServiceTermAgreed = true
                    isPrivacyTermAgreed = true
                    isLocationTermAgreed = true
                } label: {
                    Image(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .overlay {
                            HStack {
                                Image(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .blackCheck : .whiteCheck)
                                    .padding(.trailing, 10)
                                Text("서비스 이용약관 동의")
                                    .font(.neo15)
                                    .foregroundStyle(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .kuText : .white)
                                Spacer()
                            }
                            .padding(20)
                        }
                }
                .buttonStyle(PlainButtonStyle())
                
                Image(.grayLine)
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity)
                    .padding(.vertical, 3)
                
                // 서비스 이용 약관 동의 버튼
                Button {
                    isServiceTermAgreed.toggle()
                } label: {
                    Image(isServiceTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .overlay {
                            HStack {
                                Image(isServiceTermAgreed ? .blackCheck : .whiteCheck)
                                    .padding(.trailing, 10)
                                Text("개인정보 수집 및 이용 동의")
                                    .font(.neo15)
                                    .foregroundStyle(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .kuText : .white)
                                Spacer()
                                Image(isServiceTermAgreed ? .rightBlackArrow : .rightWhiteArrow)
                                    .onTapGesture {
                                        // TermsView 보여줌
                                        isTermsViewPresented = true
                                    }
                            }
                            .padding(20)
                        }
                }
                .buttonStyle(PlainButtonStyle())
                
                // 개인정보 수집 및 이용 동의
                Button {
                    isPrivacyTermAgreed.toggle()
                } label: {
                    Image(isPrivacyTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .overlay {
                            HStack {
                                Image(isPrivacyTermAgreed ? .blackCheck : .whiteCheck)
                                    .padding(.trailing, 10)
                                Text("개인정보 수집 및 이용 동의")
                                    .font(.neo15)
                                    .foregroundStyle(isPrivacyTermAgreed ? .kuText : .white)
                                Spacer()
                                Image(isPrivacyTermAgreed ? .rightBlackArrow : .rightWhiteArrow)
                                    .onTapGesture {
                                        // TermsView 보여줌
                                        isTermsViewPresented = true
                                    }
                            }
                            .padding(20)
                        }
                }
                .buttonStyle(PlainButtonStyle())
                
                // 위치기반 서비스 이용약관 동의
                Button {
                    isLocationTermAgreed.toggle()
                } label: {
                    Image(isLocationTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .overlay {
                            HStack {
                                Image(isLocationTermAgreed ? .blackCheck : .whiteCheck)
                                    .padding(.trailing, 10)
                                Text("위치기반 서비스 이용약관 동의")
                                    .font(.neo15)
                                    .foregroundStyle(isLocationTermAgreed ? .kuText : .white)
                                Spacer()
                                Image(isLocationTermAgreed ? .rightBlackArrow : .rightWhiteArrow)
                                    .onTapGesture {
                                        // TermsView 보여줌
                                        isTermsViewPresented = true
                                    }
                            }
                            .padding(20)
                        }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(isServiceTermAgreed && isPrivacyTermAgreed && isLocationTermAgreed ? .longButtonBlue : .longButtonGray)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .overlay {
                            Text("다음")
                                .font(.neo15)
                                .foregroundStyle(.kuText)
                        }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 10)
        }
        .fullScreenCover(isPresented: $isTermsViewPresented) {
            TermsView(title: StringLiterals.Register.termsTitle, termsType: .service)
        }
    }
}

#Preview {
    RegisterTermsView()
}
