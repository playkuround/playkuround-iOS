//
//  Formatter+.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 6/12/24.
//

import Foundation

extension Formatter {
    static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var decimalFormatter: String {
        return Formatter.decimalFormatter.string(for: self) ?? ""
    }
}
