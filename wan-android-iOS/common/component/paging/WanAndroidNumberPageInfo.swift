//
//  WanAndroidNumberPageInfo.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class WanAnroidNumPageInfo: PageInfo {
    let pageSize: Int
    var pageNum: Int = 0
    var pageCount: Int = 0
    let pageStartNum: Int
    
    init(pageStartNum: Int,pageSize: Int) {
        self.pageStartNum = pageStartNum
        self.pageSize = pageSize
        self.pageNum = pageStartNum
    }
    
    override func isFirstPage() -> Bool {
        return pageStartNum == pageNum
    }
    
    override func addPage(info: Any?) {
        pageNum += 1
    }
    
    override func resetPage() {
        pageNum = pageStartNum
    }
}
