//
//  CheerPKTeamView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/27/24.
//

import SwiftUI

struct CheerPKTeamView: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.66)
                .ignoresSafeArea(.all)
            
            AnimationCustomView(imageArray: myPageCheer.allCases.map { $0.rawValue },
                                delayTime: 0.5)
            
            .scaledToFit()
            .frame(width: 180)
        }
    }
}

#Preview {
    CheerPKTeamView()
}
