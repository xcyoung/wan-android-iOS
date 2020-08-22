//
//  ArticleModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class ArticleListModel: Pagination, Codable {
    var offset: Int = 0

    var over: Bool = false

    var pageCount: Int = 0

    var size: Int = 0

    var total: Int = 0

    var curPage: Int = 0

    let datas: [ArticleItem]

    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        offset = try c.decodeIfPresent(Int.self, forKey: .offset) ?? 0
        over = try c.decodeIfPresent(Bool.self, forKey: .over) ?? false
        pageCount = try c.decodeIfPresent(Int.self, forKey: .pageCount) ?? 0
        size = try c.decodeIfPresent(Int.self, forKey: .size) ?? 0
        total = try c.decodeIfPresent(Int.self, forKey: .total) ?? 0
        curPage = try c.decodeIfPresent(Int.self, forKey: .curPage) ?? 0
        datas = try c.decode([ArticleItem].self, forKey: .datas)
    }
}

class ArticleFirstModel: Pagination, Codable {
    var curPage: Int

    var offset: Int

    var over: Bool

    var pageCount: Int

    var size: Int

    var total: Int

    let datas: [ArticleItem]

    let bannerModel: ArticleBannerModel

    init(offset: Int, over: Bool, pageCount: Int, size: Int, total: Int, curPage: Int, datas: [ArticleItem], bannerModel: ArticleBannerModel) {
        self.offset = offset
        self.over = over
        self.pageCount = pageCount
        self.size = size
        self.total = total
        self.curPage = curPage
        self.datas = datas
        self.bannerModel = bannerModel
    }

}

class BaseArticleItem: NSObject, Codable {

}

class ArticleItem: NSObject, Codable {
    let apkLink: String
    let audit: Int
    let author: String
    let canEdit: Bool
    let chapterID: Int
    let chapterName: String
    let collect: Bool
    let courseID: Int
    let desc, descMd, envelopePic: String
    let fresh: Bool
    let id: Int
    let link: String
    let niceDate, niceShareDate, origin, dataPrefix: String
    let projectLink: String
    let publishTime, realSuperChapterID, selfVisible: Int
    let shareDate: Int64?
    let shareUser: String
    let superChapterID: Int
    let superChapterName: String
    let tags: [Tag]
    let title: String
    let type, userID, visible: Int
    var zan: Int

    enum CodingKeys: String, CodingKey {
        case apkLink, audit, author, canEdit
        case chapterID = "chapterId"
        case chapterName, collect
        case courseID = "courseId"
        case desc, descMd, envelopePic, fresh, id, link, niceDate, niceShareDate, origin
        case dataPrefix = "prefix"
        case projectLink, publishTime
        case realSuperChapterID = "realSuperChapterId"
        case selfVisible, shareDate, shareUser
        case superChapterID = "superChapterId"
        case superChapterName, tags, title, type
        case userID = "userId"
        case visible, zan
    }
}

class Tag: NSObject, Codable {
    let name: String
    let url: String
}

class ArticleBannerItem: NSObject, Codable {
    let desc: String
    let id: Int
    let imagePath: String
    let isVisible, order: Int
    let title: String
    let type: Int
    let url: String

    init(desc: String, id: Int, imagePath: String, isVisible: Int, order: Int, title: String, type: Int, url: String) {
        self.desc = desc
        self.id = id
        self.imagePath = imagePath
        self.isVisible = isVisible
        self.order = order
        self.title = title
        self.type = type
        self.url = url
    }
}

class ArticleBannerModel: NSObject, Codable {
    let banners: [ArticleBannerItem]
    
    init(banners: [ArticleBannerItem]) {
        self.banners = banners
    }
}
