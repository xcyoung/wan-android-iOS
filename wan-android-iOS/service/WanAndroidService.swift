//
//  WanAndroidService.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import RxSwift
class WanAndroidService: BaseService {
    func articleList(pageIndex: Int) -> Observable<WanResponse<ArticleListModel>> {
        let url = "article/list/\(pageIndex)/json"
        return httpClient.requestByRx(url: url, method: .get)
    }
    
    func articleTop() -> Observable<WanResponse<[ArticleItem]>> {
        let url = "article/top/json"
        return httpClient.requestByRx(url: url, method: .get)
    }
    
    func articleBanner() -> Observable<WanResponse<[ArticleBannerItem]>> {
        let url = "banner/json"
        return httpClient.requestByRx(url: url, method: .get)
    }
}
