//
//  WanAndroidRepo.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import RxSwift
class WanAndroidRepo: NSObject {
    public static let shared: WanAndroidRepo = WanAndroidRepo.init()

    private let service = WanAndroidService.init()

    private override init() {
        super.init()
    }

    func articleList(pageIndex: Int) -> Observable<WanResponse<ArticleListModel>> {
        return service.articleList(pageIndex: pageIndex)
    }

    func articleTop() -> Observable<WanResponse<[ArticleItem]>> {
        return service.articleTop()
    }

    func articleAll() -> Observable<WanResponse<ArticleFirstModel>> {
        return Observable<WanResponse<ArticleFirstModel>>.combineLatest(articleTop(), articleList(pageIndex: 0)) { a1, a2 -> WanResponse<ArticleFirstModel> in
            guard let data1 = a1.data, let data2 = a2.data else {
                throw XError.init(code: -1, message: "error")
            }

            let errorCode: Int
            let errorMsg: String
            var articles = [ArticleItem]()
            if a1.errorCode == 0 && a2.errorCode == 0 {
                errorCode = 0
                errorMsg = a1.errorMsg
                articles.append(contentsOf: data1)
                articles.append(contentsOf: data2.datas)
            } else if a1.errorCode != 0 && a2.errorCode == 0 {
                throw XError.init(code: -1, message: "error")
            } else if a1.errorCode == 0 && a2.errorCode != 0 {
                throw XError.init(code: -2, message: "error")
            } else {
                throw XError.init(code: -3, message: "error")
            }
            let articleFirstModel = ArticleFirstModel.init(offset: data2.offset,
                over: data2.over,
                pageCount: data2.pageCount,
                size: data2.size,
                total: data2.total,
                curPage: data2.curPage,
                datas: articles)
            let r = WanResponse<ArticleFirstModel>.init(errorCode: errorCode, errorMsg: errorMsg, data: articleFirstModel)
            return r
        }
    }
}
