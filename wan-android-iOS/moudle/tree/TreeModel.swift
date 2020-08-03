//
//  TreeModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/3.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
struct TreeListModel: Codable {
    let children: [TreeListModel]
    let courseID, id: Int
    let name: String
    let order, parentChapterID: Int
    let userControlSetTop: Bool
    let visible: Int

    enum CodingKeys: String, CodingKey {
        case children
        case courseID = "courseId"
        case id, name, order
        case parentChapterID = "parentChapterId"
        case userControlSetTop, visible
    }
}
