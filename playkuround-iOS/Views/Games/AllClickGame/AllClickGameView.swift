//
//  AllClickGameView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/27/24.
//

import SwiftUI
import Combine

struct AllClickGameView: View {
    @ObservedObject var viewModel: AllClickGameViewModel
    @ObservedObject var rootViewModel: RootViewModel
    
    @State private var userText: String = ""
    @State private var userHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    Image(.allClickBackground)
                        .resizable()
                        .ignoresSafeArea(edges: .all)
                    
                    Image(.allClickDuckku)
                        .offset(y: -20)
                }
                .ignoresSafeArea(.keyboard)
                
                let shouldFontResize = geometry.size.width <= 375
                
                VStack {
                    HStack {
                        Text(StringLiterals.Game.AllClick.score)
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                            .padding(.trailing, 5)
                        
                        //TODO: - Score 연결
                        Text("123")
                            .font(.neo22)
                            .foregroundStyle(.kuText)
                            .kerning(-0.41)
                        
                        Spacer()
                        
                        //TODO: - Heart 개수 연결
                        HStack(spacing: 2){
                            Image(.allClickHeart)
                            Image(.allClickHeart)
                            Image(.allClickHeart)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Text(StringLiterals.Game.AllClick.classRegistration)
                            .font(shouldFontResize ? .neo17 : .neo20)
                            .kerning(-0.41)
                            .foregroundStyle(.allClickGreen)
                        
                        Spacer()
                        
                        Image(.allClickWritingBox)
                            .overlay(alignment: .leading) {
                                AllClickCustomTextView(text: $userText, height: $userHeight)
                                    .frame(height: 30, alignment: .center)
                                    .frame(width: 200)
                                    .padding(.leading, 8)
                            }
                        
                        Spacer()
                        
                        Image(.allClickRegister)
                            .overlay {
                                Text(StringLiterals.Game.AllClick.register)
                                    .font(.neo18)
                                    .kerning(-0.41)
                                    .foregroundStyle(.white)
                            }
                        
                        Spacer()
                    }
                    .padding(.vertical, 6)
                    .background(.white)
                    .offset(y: 8)
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
                }, height: 57)
            }
        }
    }
}

#Preview {
    AllClickGameView(viewModel: AllClickGameViewModel(.allClear, rootViewModel: RootViewModel(), mapViewModel: MapViewModel(), timeStart: 30.0, timeEnd: 0.0, timeInterval: 0.01), rootViewModel: RootViewModel())
}
