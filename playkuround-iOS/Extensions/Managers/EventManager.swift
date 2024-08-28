//
//  EventManager.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/28/24.
//

import Foundation

final class EventManager {
    // Static Class로 사용
    static let shared = EventManager()
    
    // 확인한 공지 중 가장 큰 ID를 갱신
    func updateEventID(_ notiID: Int) -> Bool {
        let topID = UserDefaults.standard.integer(forKey: "NOTI_TOP_ID")
        print("topID: \(topID), newID: \(notiID)")
        
        if topID < notiID {
            UserDefaults.standard.setValue(notiID, forKey: "NOTI_TOP_ID")
            return true
        } else {
            return false
        }
    }
    
    // 확인한 공지 중 가장 큰 ID를 반환
    func getTopEventID() -> Int {
        return UserDefaults.standard.integer(forKey: "NOTI_TOP_ID")
    }
}
