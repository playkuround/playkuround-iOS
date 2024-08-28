//
//  RegisterView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/20/24.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RootViewModel
    
    // 단과대 및 학과 선택 여부
    @State private var isCollegeMenuPresented: Bool = false
    @State private var isMajorMenuPresented: Bool = false
    
    // 선택한 단과대 및 학과 struct를 저장
    @State private var selectedCollege: College? = nil
    @State private var selectedMajor: Major? = nil
    
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
                
                Text("Register.MajorSelectionDescription")
                    .font(.pretendard15R)
                    .foregroundStyle(.kuText)
                    .padding(.bottom, 47)
                
                Text("Register.College")
                    .font(.neo15)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
                
                // 단과대 Menu Button
                Button {
                    withAnimation(.spring) {
                        isCollegeMenuPresented.toggle()
                        soundManager.playSound(sound: .buttonClicked)
                    }
                } label: {
                    Image(.menuButton)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            HStack {
                                Text(selectedCollege?.name ?? NSLocalizedString("Register.CollegePlaceholder", comment: ""))
                                    .font(.pretendard15R)
                                    .foregroundStyle(selectedCollege == nil ? .kuGray2 : .kuText)
                                
                                Spacer()
                                
                                Image(isCollegeMenuPresented ? .menuUpArrow : .menuDownArrow)
                            }
                            .padding()
                        }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                    .frame(height: 70)
                
                Text("Register.Major")
                    .font(.neo15)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
                
                // 학과 Menu Button
                Button {
                    if selectedCollege != nil {
                        withAnimation(.spring) {
                            isMajorMenuPresented.toggle()
                            soundManager.playSound(sound: .buttonClicked)
                        }
                    }
                } label: {
                    Image(.menuButton)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            HStack {
                                Text(selectedMajor?.name ?? NSLocalizedString("Register.MajorPlaceholder", comment: ""))
                                    .font(.pretendard15R)
                                    .foregroundStyle(selectedCollege == nil ? .kuGray2 : .kuText)
                                
                                Spacer()
                                
                                Image(isMajorMenuPresented ? .menuUpArrow : .menuDownArrow)
                            }
                            .padding()
                        }
                }
                // 버튼 애니메이션 제거
                .buttonStyle(PlainButtonStyle())
                .disabled(selectedCollege == nil)
                
                Spacer()
                
                // 다음 버튼
                Image((selectedCollege != nil && selectedMajor != nil) ? .longButtonBlue : .longButtonGray)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        Text("Register.Next")
                            .font(.neo15)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }
                    .onTapGesture {
                        if let selectedMajor = selectedMajor {
                            soundManager.playSound(sound: .buttonClicked)
                            
                            // let major = selectedMajor.name
                            if let major = translateMajorToKor(selectedMajor) {
                                
                                // UserDefaults에 저장
                                UserDefaults.standard.set(major, forKey: "major")
                                
                                // 뷰 전환
                                viewModel.transition(to: .registerNickname)
                            }
                        }
                    }
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 10)
            
            // Menu Dropdown for College Selection
            VStack {
                Spacer()
                    .frame(height: 227)
                
                Image(.menuBackground)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(getLocalizedMajorList()) { college in
                                    Button {
                                        selectedCollege = college
                                        // 대학 선택 시 선택 학과 초기화
                                        selectedMajor = nil
                                        soundManager.playSound(sound: .buttonClicked)
                                        withAnimation(.spring) {
                                            isCollegeMenuPresented = false
                                        }
                                    } label: {
                                        Image(selectedCollege?.name == college.name ? .selectedMenuItem : .menuItem)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity)
                                            .overlay {
                                                HStack {
                                                    Text(college.name)
                                                        .font(.pretendard15R)
                                                        .foregroundStyle(.kuText)
                                                    Spacer()
                                                }
                                                .padding()
                                            }
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 3)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                    }
                
                Spacer()
            }
            .padding(.horizontal)
            .opacity(isCollegeMenuPresented ? 1.0 : 0.0)
            
            // Menu Dropdown for Major Selection
            if let college = selectedCollege {
                VStack {
                    Spacer()
                        .frame(height: 372)
                    
                    Image(.menuBackground)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .overlay {
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(college.majors) { major in
                                        Button {
                                            selectedMajor = major
                                            soundManager.playSound(sound: .buttonClicked)
                                            withAnimation(.spring) {
                                                isMajorMenuPresented = false
                                            }
                                        } label: {
                                            Image(selectedMajor?.name == major.name ? .selectedMenuItem : .menuItem)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxWidth: .infinity)
                                                .overlay {
                                                    HStack {
                                                        Text(major.name)
                                                            .font(.pretendard15R)
                                                            .foregroundStyle(.kuText)
                                                        Spacer()
                                                    }
                                                    .padding()
                                                }
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 3)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                        }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .opacity(isMajorMenuPresented ? 1.0 : 0.0)
            }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.RegisterMajorView)
        }
        // 다른 배경 누르면 menu 닫힘
        .onTapGesture {
            if isMajorMenuPresented {
                withAnimation(.spring) {
                    isMajorMenuPresented = false
                }
            }
            if isCollegeMenuPresented {
                withAnimation(.spring) {
                    isCollegeMenuPresented = false
                }
            }
        }
    }
    
    private func translateMajorToKor(_ major: Major) -> String? {
        let majorID = major.id
        
        for colleges in majorListKorean {
            for major in colleges.majors {
                if major.id == majorID {
                    return major.name
                }
            }
        }
        
        return nil
    }
    
    func getLocalizedMajorList() -> [College] {
        let currentLanguage = Locale.current.language.languageCode?.identifier

        switch currentLanguage {
        case "ko":
            return majorListKorean
        case "en":
            return majorListEnglish
        case "zh":
            return majorListChinese
        default:
            return majorListKorean
        }
    }
}

#Preview {
    RegisterView(viewModel: RootViewModel())
}
