//
//  ProjectModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/9.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
struct ProjectListModel: Codable {
    let courseID, id: Int
    let name: String
    let order, parentChapterID: Int
    let userControlSetTop: Bool
    let visible: Int

    enum CodingKeys: String, CodingKey {
        case courseID = "courseId"
        case id, name, order
        case parentChapterID = "parentChapterId"
        case userControlSetTop, visible
    }
}
