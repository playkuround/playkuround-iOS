//
//  NetworkErrorView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/25/24.
//

import SwiftUI

enum loadingWhiteImage: String, CaseIterable {
    case loadingWhite1
    case loadingWhite2
    case loadingWhite3
}

enum loadingBlackImage: String, CaseIterable {
    case loadingBlack1
    case loadingBlack2
    case loadingBlack3
}

enum LoadingColor {
    case white
    case black
}

struct NetworkErrorView: View {
    let loadingColor: LoadingColor
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                LoadingImage(loadingColor: loadingColor)
                
                Spacer()
                    .frame(height: 20)
                
                Text(StringLiterals.Network.message)
                    .font(.pretendard15R)
                    .foregroundStyle(loadingColor == .white ? .white : .kuBrown)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    ZStack {
        MainView()
        NetworkErrorView(loadingColor: .white)
    }
}

#Preview {
    NetworkErrorView(loadingColor: .black)
}

