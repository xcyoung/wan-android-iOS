//
//  WanAndroidPageStrategy.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class WanAndroidPageStrategy: PageStrategy {
    var pageInfo: PageInfo

    init(pageStartNum: Int, pageSize: Int) {
        self.pageInfo = WanAnroidNumPageInfo.init(pageStartNum: pageStartNum, pageSize: pageSize)
    }

    func addPage(info: Any?) {
        pageInfo.addPage(info: info)
    }

    func resetPage() {
        pageInfo.resetPage()
    }

    func checkFinish(result: Any?, listSize: Int) -> Bool {
        guard let info = pageInfo as? WanAnroidNumPageInfo,
            let rs = result as? NSObject
            else {
                return false
        }
        info.pageCount = (rs.value(forKey: "pageCount") as? Int) ?? 0
        return (rs.value(forKey: "over") as? Bool) ?? false
    }
}
