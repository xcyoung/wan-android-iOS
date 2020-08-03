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
    func treeList() {
        repo.treeList().subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.treeListLiveData.value = response.data ?? []
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })
        ).disposed(by: disposeBag)
    }
}
