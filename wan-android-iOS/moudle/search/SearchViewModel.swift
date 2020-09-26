//
//  SearchViewModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/9/20.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class SearchViewModel: BaseViewModel {
    private let repo = WanAndroidRepo.shared
    private var currentKeyword: String = ""
    let hotkeyLiveData = RxLiveData<[HotSearchModel]>.init(defalutValue: [])
    let beforeSearchLiveData = RxLiveData<String>.init(defalutValue: "")
    let onSearchLiveData = RxLiveData<String>.init(defalutValue: "")
    let searchResultLiveData = RxLiveData<ArticleListModel?>.init(defalutValue: nil)
    let searchHistoryLiveData = RxLiveData<[String]>.init(defalutValue: [])
    func getHotKey() {
        repo.hotkey().subscribe(HttpObserverType.init(success: { [weak self] (response) in
            if let list = response.data {
                self?.hotkeyLiveData.value = list
            }
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })).disposed(by: disposeBag)
    }

    private func search(index: Int, keyword: String) {
        repo.search(index: index, keyword: keyword).subscribe(HttpObserverType.init(success: { [weak self] (response) in
            self?.searchResultLiveData.value = response.data
        }, error: { [weak self] (error) in
                self?.errorLiveData.value = error
            })).disposed(by: disposeBag)
    }

    func search(index: Int) {
        search(index: index, keyword: self.currentKeyword)
        getHistory()
    }

    func onGuideSearch(keyword: String) {
        beforeSearchLiveData.value = keyword
    }
    
    func onSearch(keyword: String) {
        self.currentKeyword = keyword
        LocalStroage.shared.saveSearchHistory(keyword: keyword)
        onSearchLiveData.value = keyword
    }
    
    func getHistory() {
        let history = LocalStroage.shared.getSearchHistory()
        searchHistoryLiveData.value = history
    }
    
    func refreshSearch() {
        
    }
}
