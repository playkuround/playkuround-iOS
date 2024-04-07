//
//  MoonState.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/5/24.
//

import Foundation

enum MoonState {
    case fullMoon
    case cracked
    case moreCracked
    case duck
    
    var image: MoonImage {
        switch self {
        case .fullMoon: return .moon1
        case .cracked: return .moon2
        case .moreCracked: return .moon3
        case .duck: return .moon4
        }
    }
}

enum MoonImage: String {
    case moon1
    case moon2
    case moon3
    case moon4
}
