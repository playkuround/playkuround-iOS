//
//  AnnotationWrapper.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/31/24.
//

import Foundation

struct AnnotationWrapper: Identifiable {
    var id = UUID()
    let type: AnnotationType
    let landmark: Landmark
}

enum AnnotationType {
    case user
    case landmark
}
