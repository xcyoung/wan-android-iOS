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
    func onRefresh(pageIndex: Int) {
        repo.articleAll().subscribe(HttpObserverType.init(success: { [weak self] response in
            self?.articleFirstListLiveData.value = response.data
        }, error: { (error) in
                print(error)
            })
        ).disposed(by: disposeBag)
    }
}
