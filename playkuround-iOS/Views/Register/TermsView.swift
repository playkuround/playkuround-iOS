//
//  TermsView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/20/24.
//

import SwiftUI

struct TermsView: View {
    // 이용 약관 내용
    private let title: String
    private let termsType: TermsType
    @State private var text: String = ""
    
    // environment dismiss
    @Environment(\.dismiss) var dismiss
    
    private let soundManager = SoundManager.shared
    
    // 이용 약관을 불러옴
    init(title: String, termsType: TermsType) {
        // 제목
        self.title = title
        self.termsType = termsType
    }
    
    var body: some View {
        ZStack {
            Color.kuBackground.ignoresSafeArea(.all)
            
            VStack {
                // close button
                HStack {
                    Spacer()
                    Button {
                        // close this view
                        dismiss()
                        soundManager.playSound(sound: .buttonClicked)
                    } label: {
                        Image(.closeButton)
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                    .padding(.horizontal)
                }
                
                ScrollView {
                    // title
                    HStack {
                        Text(title)
                            .font(.neo38)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    
                    // Terms Text
                    Text(text)
                        .font(.pretendard15R)
                        .foregroundStyle(.kuText)
                        .padding()
                }
                // bar와 가리지 않도록 패딩 줌
                .padding(.bottom)
            }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.TermView)
            self.text = getResourceText(self.termsType)
        }
    }
    
    private func getResourceText(_ type: TermsType) -> String {
        var fileName: String = ""
        var text: String = ""
        
        switch type {
        case .service:
            fileName = NSLocalizedString("Terms.Service", comment: "")
        case .privacy:
            fileName = NSLocalizedString("Terms.Privacy", comment: "")
        case .location:
            fileName = NSLocalizedString("Terms.Location", comment: "")
        }
        
        // md 파일을 읽어 텍스트를 불러옴
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") {
            do {
                text = try String(contentsOf: fileURL)
            } catch {
                text = NSLocalizedString("Register.TermsErrorMessage", comment: "")
                print("txt 파일 읽는 도중 오류 발생")
            }
        } else {
            text = NSLocalizedString("Register.TermsErrorMessage", comment: "")
            print("파일을 찾을 수 없음")
        }
        
        return text
    }
}

#Preview {
    // 다른 뷰에서 호출 시 termsType을 명시해줌
    TermsView(title: NSLocalizedString("Register.ServiceTermsTitle", comment: ""), termsType: .service)
}

#Preview {
    // 다른 뷰에서 호출 시 termsType을 명시해줌
    TermsView(title: NSLocalizedString("Register.PrivacyTermsTitle", comment: ""), termsType: .privacy)
}

#Preview {
    // 다른 뷰에서 호출 시 termsType을 명시해줌
    TermsView(title: NSLocalizedString("Register.LocationTermsTitle", comment: ""), termsType: .location)
}

/// 이용 약관 종류, RawValue는 파일명
enum TermsType: String {
    // 서비스 이용 약관
    case service = "service"
    // 개인정보 수집 및 이용 약관
    case privacy = "privacy"
    // 위치기반 서비스 이용 약관
    case location = "location"
}
