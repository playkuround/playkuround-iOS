//
//  MyPageListSectionView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageListSectionView: View {
    let sectionTitle: String
    let rowTitle: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sectionTitle)
                .font(.neo18)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .padding(.top, 18)
            
            ForEach(rowTitle, id: \.self) { title in
                // 스토리 다시보기
                if title == StringLiterals.MyPage.My.story.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            
                        }
                }
                
                // 로그아웃
                if title == StringLiterals.MyPage.My.logout.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name("logoutViewPresented"), object: nil)
                        }
                }
                
                // 플레이쿠라운드 인스타그램
                if title == StringLiterals.MyPage.Shortcut.instagram.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            linkInstagramURL()
                        }
                }
                
                // 플쿠팀 응원하기
                if title == StringLiterals.MyPage.Shortcut.cheer.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name("cheerViewPresented"), object: nil)
                            callPostAPIfakeDoor()
                        }
                }
                
                if title == StringLiterals.MyPage.Instruction.version.rawValue {
                    MyPageListRowView(rowTitle: title)
                }
                
                // 개인정보 처리 방침
                if title == StringLiterals.MyPage.Instruction.privacy.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name("privacyTermsViewPresented"), object: nil)
                        }
                }
                
                // 이용약관
                if title == StringLiterals.MyPage.Instruction.terms.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name("serviceTermsViewPresented"), object: nil)
                        }
                }
            }
        }
    }
    
    private func linkInstagramURL() {
        if let instagramURL = URL(string: StringLiterals.MyPage.instagramURL) {
            UIApplication.shared.open(instagramURL)
        }
    }
    
    private func callPostAPIfakeDoor() {
        APIManager.callPOSTAPI(endpoint: .fakeDoor) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
    }
}
