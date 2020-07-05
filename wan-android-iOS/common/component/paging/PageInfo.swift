//
//  PageInfo.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
public class PageInfo: NSObject {

    open func isFirstPage() -> Bool {
        return false
    }

    open func addPage(info: Any?) { } // 加载更多
    open func resetPage() { } // 刷新
}
