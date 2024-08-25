//
//  MyPageListSectionView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageListSectionView: View {
    @ObservedObject var viewModel: RootViewModel
    let sectionTitle: String
    let rowTitle: [String]
    
    private let soundManager = SoundManager.shared
    
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
                            NotificationCenter.default.post(name: NSNotification.Name("storyViewPresented"),
                                                            object: nil)
                            soundManager.playSound(sound: .buttonClicked)
                        }
                }
                
                // 로그아웃
                if title == StringLiterals.MyPage.My.logout.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name("logoutViewPresented"), 
                                                            object: nil)
                            soundManager.playSound(sound: .buttonClicked)
                        }
                }
                
                // 플레이쿠라운드 인스타그램
                if title == StringLiterals.MyPage.Shortcut.instagram.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            linkInstagramURL()
                            soundManager.playSound(sound: .buttonClicked)
                        }
                }
                
                // 플쿠팀 응원하기
                if title == StringLiterals.MyPage.Shortcut.cheer.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name("cheerViewPresented"), 
                                                            object: nil)
                            callPostAPIfakeDoor()
                            soundManager.playSound(sound: .buttonClicked)
                        }
                }
                
                // 피드백 보내기
                if title == StringLiterals.MyPage.Shortcut.feedback.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            linkFeedbackURL()
                            soundManager.playSound(sound: .buttonClicked)
                        }
                }
                
                // 오류 제보
                if title == StringLiterals.MyPage.Shortcut.bug.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            linkBugURL()
                            soundManager.playSound(sound: .buttonClicked)
                        }
                }
                
                // 앱 버전
                if title == StringLiterals.MyPage.Instruction.version.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .overlay {
                            HStack {
                                Spacer()
                                
                                Text(viewModel.currentAppVersion())
                                    .font(.pretendard15R)
                                    .foregroundStyle(.kuText)
                                    .padding(.top, 18)
                            }
                        }
                }
                
                // 개인정보 처리 방침
                if title == StringLiterals.MyPage.Instruction.privacy.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name("privacyTermsViewPresented"), 
                                                            object: nil)
                            soundManager.playSound(sound: .buttonClicked)
                        }
                }
                
                // 이용약관
                if title == StringLiterals.MyPage.Instruction.terms.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name("serviceTermsViewPresented"), 
                                                            object: nil)
                            soundManager.playSound(sound: .buttonClicked)
                        }
                }
                
                // 언어
                if title == StringLiterals.MyPage.Setting.language.rawValue {
                    MyPageListRowView(rowTitle: title)
                        .overlay {
                            HStack {
                                Spacer()
                                
                                Text(StringLiterals.MyPage.Setting.currentLanguage.rawValue)
                                    .font(.pretendard15R)
                                    .foregroundStyle(.kuText)
                                    .padding(.top, 18)
                            }
                        }
                        .onTapGesture {
                            viewModel.openSettings()
                            soundManager.playSound(sound: .buttonClicked)
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
    
    private func linkFeedbackURL() {
        if let feedbackURL = URL(string: StringLiterals.MyPage.feedbackURL) {
            UIApplication.shared.open(feedbackURL)
        }
    }
    
    private func linkBugURL() {
        if let bugURL = URL(string: StringLiterals.MyPage.bugURL) {
            UIApplication.shared.open(bugURL)
        }
    }
    
    private func callPostAPIfakeDoor() {
        APIManager.callPOSTAPI(endpoint: .fakeDoor) { result in }
    }
}
