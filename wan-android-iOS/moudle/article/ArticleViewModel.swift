//
//  ArticleViewModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class ArticleViewModel: BaseViewModel {
    private let repo = WanAndroidRepo.shared

    let articleFirstListLiveData = RxLiveData<ArticleFirstModel?>.init(defalutValue: nil)
    let articleListLiveData = RxLiveData<ArticleListModel?>.init(defalutValue: nil)
    let collectionArticleLiveData = RxLiveData<(error: XError?, id: Int)>.init(defalutValue: (error: nil, id: -1))
    let unCollectionArticleLiveData = RxLiveData<(error: XError?, id: Int)>.init(defalutValue: (error: nil, id: -1))
    func onRefresh(pageIndex: Int) {
        repo.articleAll().subscribe(HttpObserverType.init(success: { [weak self] response in
            self?.articleFirstListLiveData.value = response.data
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })
        ).disposed(by: disposeBag)
    }

    func onLoad(pageIndex: Int) {
        repo.articleList(pageIndex: pageIndex).subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.articleListLiveData.value = response.data
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })).disposed(by: disposeBag)
    }

    func collectionInside(id: Int) {
        repo.collectInside(id: id).subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.collectionArticleLiveData.value = (error: nil, id: id)
        }, error: { [weak self] (error) in
                self?.collectionArticleLiveData.value = (error: error, id: id)
            })).disposed(by: disposeBag)
    }

    func unCollectionInside(id: Int) {
        repo.unCollectionInside(id: id).subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.unCollectionArticleLiveData.value = (error: nil, id: id)
        }, error: { [weak self] (error) in
                self?.unCollectionArticleLiveData.value = (error: error, id: id)
            })).disposed(by: disposeBag)
    }
}
