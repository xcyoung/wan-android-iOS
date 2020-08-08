//
//  OfficialViewModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/8.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class OfficialViewModel: BaseViewModel {
    private let repo = WanAndroidRepo.shared

    let officialChaptersLiveData = RxLiveData<[OfficialListModel]>.init(defalutValue: [])
    let officialListLiveData = RxLiveData<ArticleListModel?>.init(defalutValue: nil)
    func officialChaptersList() {
        repo.officialChaptersList().asObservable().subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.officialChaptersLiveData.value = response.data ?? []
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })).disposed(by: disposeBag)
    }

    func officialList(id: Int, pageIndex: Int) {
        repo.officialList(id: id, pageIndex: pageIndex).asObservable().subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.officialListLiveData.value = response.data
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })).disposed(by: disposeBag)
    }
}
