//
//  BaseViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/25.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
class BaseViewController: UIViewController {
    public var pageStateManager: PageStateManager?
    public let disposeBag = DisposeBag.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    open func initView() {
        pageStateManager = PageStateManager.init(rootView: self.view)
        configPageStateManager(pageStateManager: pageStateManager)
        pageStateManager?.layout()
    }

    open func configPageStateManager(pageStateManager: PageStateManager?) {
        pageStateManager?.setStateView(emptyView: DefaultEmptyView.init(), errorView: DefaultErrorView.init(), loadView: DefaultLoadingView.init())
    }

    open func showContent() {
        pageStateManager?.showContent()
    }

    open func showEmpty() {
        pageStateManager?.showEmpty()
    }

    open func showLoading() {
        pageStateManager?.showLoading()
    }

    open func showError(msg: String = "") {
        pageStateManager?.showError(msg: msg)
    }
}
