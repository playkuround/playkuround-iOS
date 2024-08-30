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
    
    init(errorType: NetworkErrorType = .network) {
        self.loadingColor = .white
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
                
                let errorMessage = errorType == .network ?
                NSLocalizedString("Network.Message", comment: "")
                    .replacingOccurrences(of: "<br>", with: "\n")
                : NSLocalizedString("Network.ServerMessage", comment: "")
                    .replacingOccurrences(of: "<br>", with: "\n")
                
                Text(errorMessage)
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
    NetworkErrorView(errorType: .server)
}

#Preview {
    NetworkErrorView()
}

