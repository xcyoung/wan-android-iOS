//
//  ProjectViewModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/9.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class ProjectViewModel: BaseViewModel {
    private let repo = WanAndroidRepo.shared

    let projectTreeLiveData = RxLiveData<[ProjectListModel]>.init(defalutValue: [])
    let projectListLiveData = RxLiveData<ArticleListModel?>.init(defalutValue: nil)
    func projectTreeList() {
        repo.projectTreeList().asObservable().subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.projectTreeLiveData.value = response.data ?? []
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })).disposed(by: disposeBag)
    }

    func projectList(id: Int, pageIndex: Int) {
        repo.projectList(id: id, pageIndex: pageIndex).asObservable().subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.projectListLiveData.value = response.data
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })).disposed(by: disposeBag)
    }
}
