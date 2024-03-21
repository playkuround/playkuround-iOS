//
//  LoginBottomSheetView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/18/24.
//

import SwiftUI

struct LoginBottomSheetView: View {
    @Binding var isShown: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShown) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShown.toggle()
                    }
                
                VStack {
                    Text(StringLiterals.Login.BottomSheet.title)
                        .font(.neo20)
                        .foregroundStyle(.kuText)
                        .kerning(-0.41)
                        .padding(.top, 50)
                    
                    Text(StringLiterals.Login.BottomSheet.description)
                        .font(.pretendard15R)
                        .foregroundStyle(.kuGray2)
                        .padding(.top, 24)
                        .multilineTextAlignment(.center)
                    
                    Image(.longButtonBlue)
                        .overlay {
                            Text(StringLiterals.Login.BottomSheet.ok)
                                .font(.neo15)
                                .foregroundStyle(.kuText)
                                .kerning(-0.41)
                        }
                        .onTapGesture {
                            isShown.toggle()
                        }
                        .padding(.top, 41)
                }
                .padding(.bottom, 79)
                .transition(.move(edge: .bottom))
                .background(
                    Image(.bottomSheetBackground)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width)
                )
            }
        }
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShown)
    }
}

