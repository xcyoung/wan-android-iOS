//
//  PageStrategy.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
public protocol PageStrategy {
    var pageInfo: PageInfo { get }
    func addPage(info: Any?) // 加载更多
    func resetPage() // 刷新
//    func getPageInfo()
    func checkFinish(result: Any?, listSize: Int) -> Bool
}
