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
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.My.Story", comment: ""))
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("storyViewPresented"),
                                                        object: nil)
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 스토리 다시보기 이벤트
                        GAManager.shared.logEvent(.REVIEW_STORY)
                    }
                
                // 로그아웃
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.My.Logout", comment: ""))
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("logoutViewPresented"),
                                                        object: nil)
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 로그아웃 이벤트
                        GAManager.shared.logEvent(.LOGOUT)
                    }
                
                // 계정 삭제
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.DeleteAccount", comment: ""))
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("isDeleteAccountPresented"),
                                                        object: nil)
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 로그아웃 이벤트
                        GAManager.shared.logEvent(.DELETE_ACCOUNT)
                    }
            }
            
            // 설정
            else if sectionType == .Setting {
                // 언어
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.Setting.Language", comment: ""))
                    .overlay {
                        HStack {
                            Spacer()
                            
                            Text("MyPage.Setting.CurrentLanguage")
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
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.Shortcut.Instagram", comment: ""))
                    .onTapGesture {
                        linkInstagramURL()
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 인스타그램 열기 이벤트
                        GAManager.shared.logEvent(.OPEN_INSTAGRAM)
                    }
                
                // 플쿠팀 응원하기
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.Shortcut.Cheer", comment: ""))
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("cheerViewPresented"),
                                                        object: nil)
                        callPostAPIfakeDoor()
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 응원하기 이벤트
                        GAManager.shared.logEvent(.CHEERING)
                    }

                // 피드백 보내기
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.Shortcut.Feedback", comment: ""))
                    .onTapGesture {
                        linkFeedbackURL()
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 피드백 보내기 이벤트
                        GAManager.shared.logEvent(.SEND_FEEDBACK)
                    }
                
                // 오류 제보
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.Shortcut.Bug", comment: ""))
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
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.Instruction.Version", comment: ""))
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
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.Instruction.Privacy", comment: ""))
                    .onTapGesture {
                        NotificationCenter.default.post(name: NSNotification.Name("privacyTermsViewPresented"),
                                                        object: nil)
                        soundManager.playSound(sound: .buttonClicked)
                        
                        // 개인정보 처리방침 열기 이벤트
                        GAManager.shared.logEvent(.OPEN_PRIVACY_POLICY)
                    }
                
                // 이용약관
                MyPageListRowView(rowTitle: NSLocalizedString("MyPage.Instruction.Terms", comment: ""))
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
        if let instagramURL = URL(string: "https://www.instagram.com/playkuround_/") {
            UIApplication.shared.open(instagramURL)
        }
    }
    
    private func linkFeedbackURL() {
        if let feedbackURL = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSeBLSqnN9bXpPW3e4FTJR5hrnzikxB-e9toW0FaiWUdbOmHgg/viewform") {
            UIApplication.shared.open(feedbackURL)
        }
    }
    
    private func linkBugURL() {
        if let bugURL = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScyarAmbF6VPUrRWQ-SNlNCi9WpezXhNj0ixVyeYo9L67oxog/viewform") {
            UIApplication.shared.open(bugURL)
        }
    }
    
    private func callPostAPIfakeDoor() {
        APIManager.shared.callPOSTAPI(endpoint: .fakeDoor) { result in }
    }
    
    private func getTitle() -> String {
        switch self.sectionType {
        case .My:
            return NSLocalizedString("MyPage.Title.My", comment: "")
        case .Setting:
            return NSLocalizedString("MyPage.Title.Setting", comment: "")
        case .Shortcut:
            return NSLocalizedString("MyPage.Title.Shortcut", comment: "")
        case .Instruction:
            return NSLocalizedString("MyPage.Title.Instruction", comment: "")
        }
    }
}
