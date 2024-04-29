//
//  AllClickGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/27/24.
//

import SwiftUI

struct AllClickGameView: View {
    @ObservedObject var viewModel: AllClickGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    @State private var userText: String = ""
    @FocusState private var focusField: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.allClickBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                let shouldFontResize = geometry.size.width <= 375
                
                VStack {
                    HStack {
                        Text(StringLiterals.Game.AllClick.score)
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.trailing, 5)
                        
                        Text("123")
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                        
                        Spacer()
                        
                        HStack(spacing: 2){
                            Image(.allClickHeart)
                            Image(.allClickHeart)
                            Image(.allClickHeart)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 50)
                        .overlay(alignment: .center) {
                            HStack {
                                Text(StringLiterals.Game.AllClick.classRegistration)
                                    .font(shouldFontResize ? .neo17 : .neo20)
                                    .kerning(-0.41)
                                    .foregroundStyle(.allClickGreen)
                                    .padding(.trailing, 5)
                                
                                Image(.allClickWritingBox)
                                    .overlay(alignment: .leading) {
                                        TextField(StringLiterals.Game.AllClick.writeSubject, text: $userText)
                                            .font(.neo18)
                                            .kerning(-0.41)
                                            .foregroundStyle(.kuText)
                                            .padding(.horizontal, 10)
                                            .focused($focusField)
                                    }
                                    .padding(.trailing, 5)
                                
                                Image(.allClickRegister)
                                    .overlay {
                                        Text(StringLiterals.Game.AllClick.register)
                                            .font(.neo18)
                                            .kerning(-0.41)
                                            .foregroundStyle(.white)
                                    }
                            }
                        }
                        .padding(.bottom, 270)
                        .padding(.top, -15)
                }
                .customNavigationBar(centerView: {
                    Text(StringLiterals.Game.AllClick.title)
                        .font(.neo22)
                        .kerning(-0.41)
                        .foregroundStyle(.kuText)
                }, rightView: {
                    Button(action: {
                        
                    }, label: {
                        Image(.brownPauseButton)
                    })
                }, height: 67)
                .padding(.top, -10)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.focusField = true
            }
        }
    }
}

#Preview {
    AllClickGameView(viewModel: AllClickGameViewModel(.allClear, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}


