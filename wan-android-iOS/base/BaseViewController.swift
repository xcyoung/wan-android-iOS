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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarHidden()
    }
    
    open func initView() {
        
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
    
    open func setNavigationBarHidden() {
        let hidden = getNavigationBarHidden()
        self.navigationController?.setNavigationBarHidden(hidden.hidden, animated: hidden.animated)
        if hidden.hidden {
            if #available(iOS 11.0, *) {
                let insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
                parentView.frame = CGRect.init(x: insets.left, y: insets.top, width: UIScreen.main.bounds.width - insets.left - insets.right, height: UIScreen.main.bounds.height - insets.bottom)
            } else {
                parentView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        } else {
            self.edgesForExtendedLayout = UIRectEdge.bottom
            parentView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
    
    open func getNavigationBarHidden() -> (hidden: Bool, animated: Bool) {
        return (hidden: false, animated: true)
    }
    
    open func setNavigationBarHiddenForSubVC() {
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        parentView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
}
