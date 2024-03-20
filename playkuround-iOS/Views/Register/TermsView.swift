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
    private let markdown: String
    
    /// 이용 약관 종류, RawValue는 파일명
    enum TermsType: String {
        // 서비스 이용 약관
        case service = "service"
        // 아래 두 약관은 현재 정보가 없음
        // 개인정보 수집 및 이용 약관
        // case privacy = "privacy"
        // 위치기반 서비스 이용 약관
        // case location = "location"
    }
    
    // 이용 약관을 불러옴
    init(title: String, termsType: TermsType) {
        // md 파일을 읽어 텍스트를 불러옴
        if let fileURL = Bundle.main.url(forResource: termsType.rawValue, withExtension: "md") {
            do {
                markdown = try String(contentsOf: fileURL)
            } catch {
                markdown = "이용 약관을 불러올 수 없습니다."
                print("파일을 읽어오는 데 문제가 발생했습니다: \(error)")
            }
        } else {
            markdown = "이용 약관을 불러올 수 없습니다."
        }
        
        // 제목
        self.title = title
    }
    
    var body: some View {
        ZStack {
            Color.kuBackground.ignoresSafeArea(.all)
            
            VStack {
                // close button
                HStack {
                    Spacer()
                    Button {
                        // TODO: close this view
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
                    Text(markdown: markdown)
                        .font(.neo22)
                        .foregroundStyle(.kuText)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    // 다른 뷰에서 호출 시 termsType을 명시해줌
    TermsView(title: StringLiterals.Register.termsTitle, termsType: .service)
}

// MARK: - 아래는 markdown 텍스트에 format을 적용해주는 extension

extension String {
    func renderMarkdown() -> Text {
        var output = Text("")
        let lines = self.components(separatedBy: "\n")
        
        for line in lines {
            if line.hasPrefix("**") && line.hasSuffix("**") {
                output = output + Text(line.trimmingCharacters(in: .init(charactersIn: "*")))
                    .bold()
                    .font(.body)
            } else {
                output = output + Text(line)
                    .font(.body)
            }
            output = output + Text("\n")
        }
        
        return output
    }
}

extension Text {
    // Text에 markdown 인자로 문자열을 주면 파싱헤서 보옂
    init(markdown: String) {
        self = markdown.renderMarkdown()
    }
}
