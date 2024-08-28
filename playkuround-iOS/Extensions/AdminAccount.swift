//
//  Account.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/28/24.
//

import SwiftUI

struct AdminAccount: Codable {
    let email: String
    let password: String
}

let adminAccountInfo: [AdminAccount] = load("Admin.json")
