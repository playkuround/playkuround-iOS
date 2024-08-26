//
//  MyPageListSectionView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageListSectionView: View {
    @ObservedObject var viewModel: RootViewModel
    let sectionType: MyPageSection
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(getTitle())
                .font(.neo18)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .padding(.top, 18)
            
            // 마이
            if sectionType == .My {
                // 스토리 다시보기
                MyPageListRowView(rowTitle: StringLiterals.MyPage.My.story.rawValue)
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("storyViewPresented"),
                                                        object: nil)
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 스토리 다시보기 이벤트
                        GAManager.shared.logEvent(.REVIEW_STORY)
                    }
                
                // 로그아웃
                MyPageListRowView(rowTitle: StringLiterals.MyPage.My.logout.rawValue)
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("logoutViewPresented"),
                                                        object: nil)
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 로그아웃 이벤트
                        GAManager.shared.logEvent(.LOGOUT)
                    }
            }
            
            // 설정
            else if sectionType == .Setting {
                // 언어
                MyPageListRowView(rowTitle: StringLiterals.MyPage.Setting.language.rawValue)
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
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 설정 열기
                        viewModel.openSetting()
                        
                        // 언어 변경 (설정 열기) 이벤트
                        GAManager.shared.logEvent(.CHANGE_LANGUAGE)
                    }
            }
            
            // 바로가기
            else if sectionType == .Shortcut {
                // 플레이쿠라운드 인스타그램
                MyPageListRowView(rowTitle: StringLiterals.MyPage.Shortcut.instagram.rawValue)
                    .onTapGesture {
                        linkInstagramURL()
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 인스타그램 열기 이벤트
                        GAManager.shared.logEvent(.OPEN_INSTAGRAM)
                    }
                
                // 플쿠팀 응원하기
                MyPageListRowView(rowTitle: StringLiterals.MyPage.Shortcut.cheer.rawValue)
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("cheerViewPresented"),
                                                        object: nil)
                        callPostAPIfakeDoor()
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 응원하기 이벤트
                        GAManager.shared.logEvent(.CHEERING)
                    }

                // 피드백 보내기
                MyPageListRowView(rowTitle: StringLiterals.MyPage.Shortcut.feedback.rawValue)
                    .onTapGesture {
                        linkFeedbackURL()
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 피드백 보내기 이벤트
                        GAManager.shared.logEvent(.SEND_FEEDBACK)
                    }
                
                // 오류 제보
                MyPageListRowView(rowTitle: StringLiterals.MyPage.Shortcut.bug.rawValue)
                    .onTapGesture {
                        linkBugURL()
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 오류 제보 이벤트
                        GAManager.shared.logEvent(.ERROR_REPORT)
                    }
            }
             
            // 이용안내
            else if sectionType == .Instruction {
                // 앱 버전
                MyPageListRowView(rowTitle: StringLiterals.MyPage.Instruction.version.rawValue)
                    .overlay {
                        HStack {
                            Spacer()
                            
                            Text(viewModel.currentAppVersion())
                                .font(.pretendard15R)
                                .foregroundStyle(.kuText)
                                .padding(.top, 18)
                        }
                    }
                
                // 개인정보 처리 방침
                MyPageListRowView(rowTitle: StringLiterals.MyPage.Instruction.privacy.rawValue)
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("privacyTermsViewPresented"),
                                                        object: nil)
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 개인정보 처리방침 열기 이벤트
                        GAManager.shared.logEvent(.OPEN_PRIVACY_POLICY)
                    }
                
                // 이용약관
                MyPageListRowView(rowTitle: StringLiterals.MyPage.Instruction.terms.rawValue)
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("serviceTermsViewPresented"),
                                                        object: nil)
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 이용약관 열기 이벤트
                        GAManager.shared.logEvent(.TERM_OF_SERVICE)
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
    
    private func getTitle() -> String {
        switch self.sectionType {
        case .My:
            return StringLiterals.MyPage.Title.my
        case .Setting:
            return StringLiterals.MyPage.Title.setting
        case .Shortcut:
            return StringLiterals.MyPage.Title.shortcut
        case .Instruction:
            return StringLiterals.MyPage.Title.instruction
        }
    }
}
