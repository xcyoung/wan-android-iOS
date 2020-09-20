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

    func treeList() -> Observable<WanResponse<[TreeListModel]>> {
        let url = "tree/json"
        return httpClient.requestByRx(url: url, method: .get)
    }

    func treeSubList(pageIndex: Int, id: Int) -> Observable<WanResponse<ArticleListModel>> {
        let url = "article/list/\(pageIndex)/json?cid=\(id)"
        return httpClient.requestByRx(url: url, method: .get)
    }

    func naviList() -> Observable<WanResponse<[NaviListModel]>> {
        let url = "navi/json"
        return httpClient.requestByRx(url: url, method: .get)
    }

    func officialChaptersList() -> Observable<WanResponse<[OfficialListModel]>> {
        let url = "wxarticle/chapters/json"
        return httpClient.requestByRx(url: url, method: .get)
    }

    func officialList(id: Int, pageIndex: Int) -> Observable<WanResponse<ArticleListModel>> {
        let url = "wxarticle/list/\(id)/\(pageIndex)/json"
        return httpClient.requestByRx(url: url, method: .get)
    }

    func projectTreeList() -> Observable<WanResponse<[ProjectListModel]>> {
        let url = "project/tree/json"
        return httpClient.requestByRx(url: url, method: .get)
    }

    func projectList(id: Int, pageIndex: Int) -> Observable<WanResponse<ArticleListModel>> {
        let url = "project/list/\(pageIndex)/json?cid=\(id)"
        return httpClient.requestByRx(url: url, method: .get)
    }

    func collectInside(id: Int) -> Observable<WanResponse<Empty>> {
        let url = "lg/collect/\(id)/json"
        return httpClient.requestByRx(url: url, method: .post)
    }

    func unCollectionInside(id: Int) -> Observable<WanResponse<Empty>> {
        let url = "lg/uncollect_originId/\(id)/json"
        return httpClient.requestByRx(url: url, method: .post)
    }

    func signIn(userName: String, password: String) -> Observable<WanResponse<Empty>> {
        let url = "user/login"
        let body = [
            "username": userName,
            "password": password
        ]
        return httpClient.requestByRx(url: url, method: .post, params: body)
    }

    func signUp(userName: String, password: String, repassword: String) -> Observable<WanResponse<Empty>> {
        let url = "user/register"
        let body = [
            "username": userName,
            "password": password,
            "repassword": repassword
        ]
        return httpClient.requestByRx(url: url, method: .post, params: body)
    }

    func hotkey() -> Observable<WanResponse<[HotSearchModel]>> {
        let url = "hotkey/json"
        return httpClient.requestByRx(url: url, method: .get)
    }

    func search(index: Int, keyword: String) -> Observable<WanResponse<ArticleListModel>> {
        let url = "article/query/\(index)/json"
        let body = [
            "k": keyword
        ]
        return httpClient.requestByRx(url: url, method: .post, params: body)
    }
}
