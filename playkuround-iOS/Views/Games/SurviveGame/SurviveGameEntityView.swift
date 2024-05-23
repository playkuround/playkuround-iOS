//
//  SurviveGameEntityView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/22/24.
//

import SwiftUI

struct SurviveGameEntityView: View {
    let type: SurviveGameEntityType
    @State private var posX: CGFloat = 0.0
    @State private var posY: CGFloat = 0.0
    @State private var angle: Angle = Angle(degrees: 0.0)
    
    var body: some View {
        switch type {
        case .boat:
            Image(.surviveBoat)
                .rotationEffect(angle)
        case .bug:
            Image(.surviveBug)
        }
    }
    
    func update() {
        // TODO: Update self Potision by Moving Policy
    }
}

#Preview {
    VStack {
        SurviveGameEntityView(type: .boat)
        SurviveGameEntityView(type: .bug)
    }
}

enum SurviveGameEntityType {
    case boat
    case bug
}
