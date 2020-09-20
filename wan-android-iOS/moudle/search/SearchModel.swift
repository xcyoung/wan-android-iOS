//
//  SearchModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/9/19.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
struct HotSearchModel: Codable {
    let id: Int
    let link, name: String
    let order, visible: Int
}
