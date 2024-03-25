//
//  LoadingView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/25/24.
//

import SwiftUI

struct LoadingView: View {
    let loadingColor: LoadingColor
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                LoadingImage(loadingColor: loadingColor)
            }
        }
    }
}

struct LoadingImage: View {
    let loadingColor: LoadingColor
    
    var body: some View {
        switch loadingColor {
        case .white:
            AnimationCustomView(
                imageArray: loadingWhiteImage.allCases.map { $0.rawValue },
                delayTime: 0.7)
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .ignoresSafeArea(.all)
        case .black:
            AnimationCustomView(
                imageArray: loadingBlackImage.allCases.map { $0.rawValue },
                delayTime: 0.7)
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.3)
        LoadingView(loadingColor: .white)
    }
}
