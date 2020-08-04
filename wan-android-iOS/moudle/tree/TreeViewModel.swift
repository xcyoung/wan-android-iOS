//
//  TreeViewModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/3.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class TreeViewModel: BaseViewModel {
    private let repo = WanAndroidRepo.shared

    let treeListLiveData = RxLiveData<[TreeListModel]>.init(defalutValue: [])
    let treeSubListLiveData = RxLiveData<ArticleListModel?>.init(defalutValue: nil)
    let naviListLiveData = RxLiveData<[NaviListModel]>.init(defalutValue: [])
    func treeList() {
        repo.treeList().subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.treeListLiveData.value = response.data ?? []
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })
        ).disposed(by: disposeBag)
    }

    func treeSubList(pageIndex: Int, id: Int) {
        repo.treeSubList(pageIndex: pageIndex, id: id).subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.treeSubListLiveData.value = response.data
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })).disposed(by: disposeBag)
    }

    func naviList() {
        repo.naviList().subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.naviListLiveData.value = response.data ?? []
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })).disposed(by: disposeBag)
    }
}
