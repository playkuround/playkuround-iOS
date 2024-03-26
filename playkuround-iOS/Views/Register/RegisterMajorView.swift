//
//  RegisterView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/20/24.
//

import SwiftUI

struct RegisterView: View {
    // 단과대 및 학과 선택 여부
    @State private var isCollegeMenuPresented: Bool = false
    @State private var isMajorMenuPresented: Bool = false
    
    // 선택한 단과대 및 학과 struct를 저장
    @State private var selectedCollege: College? = nil
    @State private var selectedMajor: Major? = nil
    
    @Binding var currentView: ViewType
    
    var body: some View {
        ZStack {
            Color.kuBackground.ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text(StringLiterals.Register.title)
                    .font(.neo24)
                    .foregroundStyle(.kuText)
                    .kerning(-0.41)
                    .padding(.bottom, 10)
                
                Text(StringLiterals.Register.majorSelectionDescription)
                    .font(.pretendard15R)
                    .foregroundStyle(.kuText)
                    .padding(.bottom, 47)
                
                Text(StringLiterals.Register.college)
                    .font(.neo15)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
                
                // 단과대 Menu Button
                Button {
                    withAnimation(.spring) {
                        isCollegeMenuPresented.toggle()
                    }
                } label: {
                    Image(.menuButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .overlay {
                            HStack {
                                Text(selectedCollege?.name ?? StringLiterals.Register.collegePlaceholder)
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
                
                Text(StringLiterals.Register.major)
                    .font(.neo15)
                    .kerning(-0.41)
                    .foregroundStyle(.kuText)
                
                // 학과 Menu Button
                Button {
                    if selectedCollege != nil {
                        withAnimation(.spring) {
                            isMajorMenuPresented.toggle()
                        }
                    }
                } label: {
                    Image(.menuButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .overlay {
                            HStack {
                                Text(selectedMajor?.name ?? StringLiterals.Register.majorPlaceholder)
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
                    .frame(width: .infinity)
                    .overlay {
                        Text(StringLiterals.Register.next)
                            .font(.neo15)
                            .kerning(-0.41)
                            .foregroundStyle(.kuText)
                    }
                    .onTapGesture {
                        // TODO: 다음으로 넘어가는 transition 구현
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
                    .frame(width: .infinity)
                    .overlay {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(majorList) { college in
                                    Button {
                                        selectedCollege = college
                                        // 대학 선택 시 선택 학과 초기화
                                        selectedMajor = nil
                                        withAnimation(.spring) {
                                            isCollegeMenuPresented = false
                                        }
                                    } label: {
                                        Image(selectedCollege?.name == college.name ? .selectedMenuItem : .menuItem)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: .infinity)
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
                                    .frame(width: .infinity)
                                }
                            }
                            .frame(width: .infinity)
                            .padding(.horizontal, 3)
                        }
                        .frame(width: .infinity)
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
                        .frame(width: .infinity)
                        .overlay {
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(college.majors) { major in
                                        Button {
                                            selectedMajor = major
                                            withAnimation(.spring) {
                                                isMajorMenuPresented = false
                                            }
                                        } label: {
                                            Image(selectedMajor?.name == major.name ? .selectedMenuItem : .menuItem)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: .infinity)
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
                                        .frame(width: .infinity)
                                    }
                                }
                                .frame(width: .infinity)
                                .padding(.horizontal, 3)
                            }
                            .frame(width: .infinity)
                            .padding(.vertical, 5)
                        }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .opacity(isMajorMenuPresented ? 1.0 : 0.0)
            }
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
}

#Preview {
    RegisterView()
    RegisterView(currentView: .constant(.registerMajor))
}
