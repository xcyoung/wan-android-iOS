//
//  Pagination.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation

public protocol Pagination {
    var curPage: Int { get set }
    var offset: Int { get set }
    var over: Bool { get set }
    var pageCount: Int { get set }
    var size: Int { get set }
    var total: Int { get set }
}
