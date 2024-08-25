//
//  NetworkErrorView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 3/25/24.
//

import SwiftUI

struct NetworkErrorView: View {
    let loadingColor: LoadingColor
    let errorType: NetworkErrorType
    
    init(loadingColor: LoadingColor, errorType: NetworkErrorType = .network) {
        self.loadingColor = loadingColor
        self.errorType = errorType
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                LoadingImage(loadingColor: loadingColor)
                
                Spacer()
                    .frame(height: 20)
                
                Text(errorType == .network ?
                     StringLiterals.Network.message : StringLiterals.Network.serverMessage)
                    .font(.pretendard15R)
                    .foregroundStyle(loadingColor == .white ? .white : .kuBrown)
                    .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            GAManager.shared.logScreenEvent(.NetworkErrorView)
        }
    }
    
    enum NetworkErrorType {
        case network
        case server
    }
}

#Preview {
    NetworkErrorView(loadingColor: .white, errorType: .server)
}

#Preview {
    NetworkErrorView(loadingColor: .black)
}

