//
//  MyPageView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct MyPageView: View {
    @ObservedObject var viewModel: RootViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var isStoryViewPresented: Bool = false
    @State private var isLogoutPresented: Bool = false
    @State private var isDeleteAccountPresented: Bool = false
    @State private var isCheerPresented: Bool = false
    @State private var isServiceTermsViewPresented: Bool = false
    @State private var isPrivacyTermsViewPresented: Bool = false
    
    private let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color(.kuBackground).ignoresSafeArea(.all)
            
            VStack {
                MyPageProfileView(user: homeViewModel.userData)
                
                Rectangle()
                    .fill(.kuBlue3)
                    .frame(height: 11)
                    .padding(.top, 17)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        MyPageListSectionView(viewModel: viewModel,
                                              sectionType: .My)
                        
                        Rectangle()
                            .fill(.kuBlue3)
                            .frame(height: 1)
                            .padding(.top, 8)
                        
                        MyPageListSectionView(viewModel: viewModel,
                                              sectionType: .Setting)
                        
                        Rectangle()
                            .fill(.kuBlue3)
                            .frame(height: 1)
                            .padding(.top, 8)
                        
                        MyPageListSectionView(viewModel: viewModel,
                                              sectionType: .Shortcut)
                        
                        Rectangle()
                            .fill(.kuBlue3)
                            .frame(height: 1)
                            .padding(.top, 8)
                        
                        MyPageListSectionView(viewModel: viewModel,
                                              sectionType: .Instruction)
                    }
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 20)
                .scrollIndicators(.hidden)
            }
            .padding(.top, 100)
            
            if isStoryViewPresented {
                StoryView(rootViewModel: viewModel, showStoryView: $isStoryViewPresented)
            }
            else if isLogoutPresented {
                CheckLogoutView(viewModel: viewModel,
                                isLogoutPresented: $isLogoutPresented)
            }
            else if isCheerPresented {
                CheerPKTeamView()
            }
            else if isDeleteAccountPresented {
                CheckDeleteAccountView(viewModel: viewModel,
                                       isDeleteAccountPresented: $isDeleteAccountPresented)
            }
            
            Spacer()
                .customNavigationBar(
                    centerView: {
                        Text("MyPage.Title")
                            .font(.neo22)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }, leftView: {
                        Button(action: {
                            homeViewModel.transition(to: .home)
                            soundManager.playSound(sound: .buttonClicked)
                        }, label: {
                            Image(.leftBlackArrow)
                        })
                    }, height: 73)
        }
        .fullScreenCover(isPresented: $isServiceTermsViewPresented) {
            TermsView(title: NSLocalizedString("Register.ServiceTermsTitle", comment: "") , termsType: .service)
        }
        .fullScreenCover(isPresented: $isPrivacyTermsViewPresented) {
            TermsView(title: NSLocalizedString("Register.PrivacyTermsTitle", comment: ""), termsType: .privacy)
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("storyViewPresented"))) { _ in
            withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
                self.isStoryViewPresented = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("logoutViewPresented"))) { _ in
            withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
                self.isLogoutPresented = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("isDeleteAccountPresented"))) { _ in
            withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
                self.isDeleteAccountPresented = true
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
            GAManager.shared.logScreenEvent(.MyPageView)
        }
    }
}

enum MyPageSection {
    case My
    case Setting
    case Shortcut
    case Instruction
}
