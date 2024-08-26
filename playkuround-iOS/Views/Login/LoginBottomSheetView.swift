//
//  LoginBottomSheetView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/18/24.
//

import SwiftUI

struct LoginBottomSheetView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            if (isPresented) {
                Spacer()
                
                VStack {
                    Text("Login.BottomSheet.Title")
                        .font(.neo20)
                        .foregroundStyle(.kuText)
                        .kerning(-0.41)
                        .padding(.top, 50)
                    
                    let description = NSLocalizedString("Login.BottomSheet.Description", comment: "")
                        .replacingOccurrences(of: "<br>", with: "\n")
                    
                    Text(description)
                        .font(.pretendard15R)
                        .foregroundStyle(.kuGray2)
                        .padding(.top, 24)
                        .multilineTextAlignment(.center)
                    
                    Image(.longButtonBlue)
                        .overlay {
                            Text("Login.BottomSheet.Ok")
                                .font(.neo15)
                                .foregroundStyle(.kuText)
                                .kerning(-0.41)
                        }
                        .onTapGesture {
                            isPresented.toggle()
                        }
                        .padding(.top, 41)
                }
                .padding(.bottom, 79)
                .background(
                    Image(.bottomSheetBackground)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width)
                )
            }
        }
        .ignoresSafeArea()
    }
}

