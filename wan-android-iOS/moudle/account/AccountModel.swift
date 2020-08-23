//
//  AccountModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/23.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class UserInfo: NSObject, Codable {
    let admin: Bool
    let coinCount: Int
    let collectIDS: [Int]
    let email, icon: String
    let id: Int
    let nickname, password, publicName, token: String
    let type: Int
    let username: String

    enum CodingKeys: String, CodingKey {
        case admin, coinCount
        case collectIDS = "collectIds"
        case email, icon, id, nickname, password, publicName, token, type, username
    }

    init(admin: Bool, coinCount: Int, collectIDS: [Int], email: String, icon: String, id: Int, nickname: String, password: String, publicName: String, token: String, type: Int, username: String) {
        self.admin = admin
        self.coinCount = coinCount
        self.collectIDS = collectIDS
        self.email = email
        self.icon = icon
        self.id = id
        self.nickname = nickname
        self.password = password
        self.publicName = publicName
        self.token = token
        self.type = type
        self.username = username
    }
}
