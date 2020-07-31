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
import MyLayout
class BaseViewController: UIViewController {
    public var pageStateManager: PageStateManager?
    public let disposeBag = DisposeBag.init()
    public var params: [String: Any] = [:]
    public let parentView: MyFrameLayout = MyFrameLayout.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    open func initView() {
        parentView.myHeight = CGFloat.init(MyLayoutSize.fill())
        parentView.myWidth = CGFloat.init(MyLayoutSize.fill())
        self.view.addSubview(parentView)
        pageStateManager = PageStateManager.init(rootView: self.parentView)
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
