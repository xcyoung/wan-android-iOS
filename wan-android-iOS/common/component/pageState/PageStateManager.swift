//
//  PageStateManager.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/26.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout
class PageStateManager: NSObject {
    private var emptyView: (UIView & AnimationProtocol)?
    private var errorView: (UIView & AnimationProtocol & ErrorViewProtocol)?
    private var loadView: (UIView & AnimationProtocol)?
    private let rootView: UIView

    init(
        rootView: UIView) {
        self.rootView = rootView

        super.init()
    }

    private func bringCoverToFront() {
        if let empty = emptyView {
            self.rootView.bringSubviewToFront(empty)
        }
        if let error = errorView {
            self.rootView.bringSubviewToFront(error)
        }
        if let load = loadView {
            self.rootView.bringSubviewToFront(load)
        }

    }

    public func showContent() {
        loadView?.stopLoading()
        emptyView?.stopLoading()
        errorView?.stopLoading()
        emptyView?.isHidden = true
        errorView?.isHidden = true
        loadView?.isHidden = true
    }

    public func showEmpty() {
        loadView?.stopLoading()
        errorView?.stopLoading()
        emptyView?.isHidden = false
        errorView?.isHidden = true
        loadView?.isHidden = true
        bringCoverToFront()
        emptyView?.startLoading()
    }

    public func showError(error: XError? = nil) {
        loadView?.stopLoading()
        emptyView?.stopLoading()
        emptyView?.isHidden = true
        errorView?.isHidden = false
        loadView?.isHidden = true
        bringCoverToFront()
        errorView?.startLoading()
        errorView?.setError(error: error)
    }

    public func showLoading() {
        emptyView?.stopLoading()
        errorView?.stopLoading()
        emptyView?.isHidden = true
        errorView?.isHidden = true
        loadView?.isHidden = false
        bringCoverToFront()
        loadView?.startLoading()
    }

    public func setStateView(emptyView: (UIView & AnimationProtocol)?, errorView: (UIView & AnimationProtocol & ErrorViewProtocol)?, loadView: (UIView & AnimationProtocol)?) {
        self.emptyView = emptyView
        self.errorView = errorView
        self.loadView = loadView
    }

    public func layout() {
        if let empty = emptyView {
            rootView.addSubview(empty)
        }
        if let error = errorView {
            rootView.addSubview(error)
        }
        if let load = loadView {
            rootView.addSubview(load)
        }

        emptyView?.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        errorView?.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        loadView?.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        
        showContent()
    }
}
