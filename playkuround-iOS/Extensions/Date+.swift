//
//  Date+.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 5/29/24.
//

import Foundation
import SwiftUI

extension DateFormatter {
    static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter
    } ()

    static func getDateFormatter() -> DateFormatter {
        return self.dateFormatter
    }
}

extension Date {
    // 인자로 받은 dateFormat으로 변환해 반환
    func toFormattedString(_ dateFormat: String) -> String? {
        let dateFormatter = DateFormatter.getDateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    func toCalendarString() -> String {
        let dayComponent = Calendar.current.component(.day, from: self)
        
        // 월의 첫 날이면 월/일 로 반환
        if dayComponent == 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d"
            return dateFormatter.string(from: self)
        } else {
            return "\(dayComponent)"
        }
    }
    
    // 오늘인지 검사
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
}
