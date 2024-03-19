//
//  LoginBottomSheetView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/18/24.
//

import SwiftUI

struct LoginBottomSheetView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
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
                            isShowing.toggle()
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
        .animation(.easeInOut, value: isShowing)
    }
}

