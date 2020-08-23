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

    func articleBanner() -> Observable<WanResponse<[ArticleBannerItem]>> {
        return service.articleBanner()
    }

    func articleAll() -> Observable<WanResponse<ArticleFirstModel>> {
        return Observable<WanResponse<ArticleFirstModel>>.combineLatest(articleBanner(), articleTop(), articleList(pageIndex: 0)) { a, a1, a2 -> WanResponse<ArticleFirstModel> in
            guard let bannerData = a.data, let data1 = a1.data, let data2 = a2.data else {
                throw XError.init(code: a.errorCode, message: a.errorMsg)
            }

            let errorCode: Int
            let errorMsg: String
            var articles = [ArticleItem]()
            var banner = [ArticleBannerItem]()
            if a.errorCode == 0 {
                banner.append(contentsOf: bannerData)
                if a1.errorCode == 0 && a2.errorCode == 0 {
                    errorCode = 0
                    errorMsg = a1.errorMsg
                    articles.append(contentsOf: data1)
                    articles.append(contentsOf: data2.datas)
                } else if a1.errorCode != 0 && a2.errorCode == 0 {
                    throw XError.init(code: a1.errorCode, message: a1.errorMsg)
                } else if a1.errorCode == 0 && a2.errorCode != 0 {
                    throw XError.init(code: a2.errorCode, message: a2.errorMsg)
                } else {
                    throw XError.init(code: a1.errorCode, message: a1.errorMsg)
                }
            } else {
                throw XError.init(code: a.errorCode, message: a.errorMsg)
            }

            let bannerModel = ArticleBannerModel.init(banners: banner)
            let articleFirstModel = ArticleFirstModel.init(offset: data2.offset,
                over: data2.over,
                pageCount: data2.pageCount,
                size: data2.size,
                total: data2.total,
                curPage: data2.curPage,
                datas: articles, bannerModel: bannerModel)
            let r = WanResponse<ArticleFirstModel>.init(errorCode: errorCode, errorMsg: errorMsg, data: articleFirstModel)
            return r
        }
    }

    func treeList() -> Observable<WanResponse<[TreeListModel]>> {
        return service.treeList()
    }

    func treeSubList(pageIndex: Int, id: Int) -> Observable<WanResponse<ArticleListModel>> {
        return service.treeSubList(pageIndex: pageIndex, id: id)
    }

    func naviList() -> Observable<WanResponse<[NaviListModel]>> {
        return service.naviList()
    }

    func officialChaptersList() -> Observable<WanResponse<[OfficialListModel]>> {
        return service.officialChaptersList()
    }

    func officialList(id: Int, pageIndex: Int) -> Observable<WanResponse<ArticleListModel>> {
        return service.officialList(id: id, pageIndex: pageIndex)
    }

    func projectTreeList() -> Observable<WanResponse<[ProjectListModel]>> {
        return service.projectTreeList()
    }

    func projectList(id: Int, pageIndex: Int) -> Observable<WanResponse<ArticleListModel>> {
        return service.projectList(id: id, pageIndex: pageIndex)
    }

    func collectInside(id: Int) -> Observable<WanResponse<Empty>> {
        return service.collectInside(id: id)
    }
    
    func unCollectionInside(id: Int) -> Observable<WanResponse<Empty>> {
        return service.unCollectionInside(id: id)
    }
    
    func signIn(userName: String, password: String) -> Observable<WanResponse<Empty>> {
        return service.signIn(userName: userName, password: password)
    }
}
