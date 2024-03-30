//
//  MyPageView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageView: View {
    @ObservedObject var viewModel: RootViewModel
    @State private var user: UserEntity = UserEntity(nickname:  "", major: "",
                                                     myRank: MyRank(score: 0, ranking: 0),
                                                     highestScore: 0, highestRank: "")
    
    @State private var isLogoutPresented: Bool = false
    @State private var isCheerPresented: Bool = false
    @State private var isServiceTermsViewPresented: Bool = false
    @State private var isPrivacyTermsViewPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color(.kuBackground).ignoresSafeArea(.all)
            
            VStack {
                MyPageProfileView(user: user)
                
                Rectangle()
                    .fill(.kuBlue3)
                    .frame(height: 11)
                    .padding(.top, 17)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        MyPageListSectionView(viewModel: viewModel,
                                              sectionTitle: StringLiterals.MyPage.Title.my,
                                              rowTitle: StringLiterals.MyPage.My.allCases.map { $0.rawValue })
                        
                        Rectangle()
                            .fill(.kuBlue3)
                            .frame(height: 1)
                            .padding(.top, 8)
                        
                        MyPageListSectionView(viewModel: viewModel,
                                              sectionTitle: StringLiterals.MyPage.Title.shortcut,
                                              rowTitle: StringLiterals.MyPage.Shortcut.allCases.map { $0.rawValue })
                        
                        Rectangle()
                            .fill(.kuBlue3)
                            .frame(height: 1)
                            .padding(.top, 8)
                        
                        MyPageListSectionView(viewModel: viewModel,
                                              sectionTitle: StringLiterals.MyPage.Title.instruction,
                                              rowTitle: StringLiterals.MyPage.Instruction.allCases.map { $0.rawValue })
                    }
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 20)
                .scrollIndicators(.hidden)
            }
            .padding(.top, 100)
            
            if isLogoutPresented {
                CheckLogoutView(viewModel: viewModel,
                                isLogoutPresented: $isLogoutPresented)
            }
            else if isCheerPresented {
                CheerPKTeamView()
            }
            
            Spacer()
                .customNavigationBar(
                    centerView: {
                        Text(StringLiterals.MyPage.title)
                            .font(.neo22)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }, leftView: {
                        Button(action: {
                            viewModel.transition(to: .home)
                        }, label: {
                            Image(.leftBlackArrow)
                        })
                    }, height: 73)
        }
        .fullScreenCover(isPresented: $isServiceTermsViewPresented) {
            TermsView(title: StringLiterals.Register.serviceTermsTitle, termsType: .service)
        }
        .fullScreenCover(isPresented: $isPrivacyTermsViewPresented) {
            TermsView(title: StringLiterals.Register.privacyTermsTitle, termsType: .privacy)
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("logoutViewPresented"))) { _ in
            withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
                self.isLogoutPresented = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("cheerViewPresented"))) { _ in
            withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
                self.isCheerPresented = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.isCheerPresented = false
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("privacyTermsViewPresented"))) { _ in
            self.isPrivacyTermsViewPresented = true
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("serviceTermsViewPresented"))) { _ in
            self.isServiceTermsViewPresented = true
        }
        .onAppear {
            callGetAPIUsers()
        }
    }
    
    private func callGetAPIUsers() {
        APIManager.callGETAPI(endpoint: .users) { result in
            switch result {
            case .success(let data):
                print("Data received in View: \(data)")
                
                if let response = data as? APIResponse {
                    if response.isSuccess {
                        user.nickname = response.response?.nickname ?? "-"
                        user.major = response.response?.major ?? "-"
                        user.highestScore = response.response?.highestScore ?? 0
                        user.highestRank = response.response?.highestRank ?? "-"
                    }
                }
                
            case .failure(let error):
                print("Error in View: \(error)")
            }
        }
        
        APIManager.callGETAPI(endpoint: .scoresRank) { result in
            switch result {
            case .success(let data):
                print("🍪🍪🍪 Data received in View: \(data)")
                
                if let response = data as? APIResponse {
                    if response.isSuccess {
                        user.myRank.score = response.response?.myRank?.score ?? 0
                        user.myRank.ranking = response.response?.myRank?.ranking ?? 0
                    }
                }
                
            case .failure(let error):
                print("🧡🧡🧡Error in View: \(error)")
            }
        }
    }
}
