//
//  UserEntity.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 3/30/24.
//

import Foundation

struct UserEntity {
    var nickname: String
    var major: String
    var myRank: MyRank // 전체 랭킹
    var landmarkRank: MyRank // 랜드마크별 랭킹
    var highestScore: Int
    var highestRank: Int
    var attendanceDays: Int
    var profileBadge: String
}
