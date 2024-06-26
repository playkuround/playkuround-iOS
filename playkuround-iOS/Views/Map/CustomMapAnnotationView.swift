//
//  CustomMapAnnotationView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/31/24.
//

import SwiftUI

struct CustomMapAnnotationView: View {
    let annotation: AnnotationWrapper
    @ObservedObject var mapViewModel: MapViewModel
    
    var body: some View {
        if annotation.type == .landmark {
            Image(.landmarkFlag)
        } else {
            Image(.userAnnotation)
        }
    }
}
