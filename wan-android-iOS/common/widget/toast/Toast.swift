//
//  Toast.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/25.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class Toast: NSObject {
    static let defaultDuration: Float = 1.5
    static let defaultBackgroukColor: UIColor = UIColor.init(argb: "#99000000")

    let contentView: ToastView

    init(text: String) {
        contentView = ToastView.init(frame: CGRect.zero)
        contentView.textLabel.text = text

        super.init()
    }

    func show() {
        guard Thread.isMainThread else {
            return
        }

        guard let window = UIApplication.shared.getMainWindow() else {
            return
        }

        contentView.center = CGPoint.init(x: window.center.x, y: window.frame.height - (100 + contentView.frame.height / 2))
        window.addSubview(contentView)
        //  调用setNeedsLayout后会自动调用ToastView的layoutSubView，并计算frame的大小
        contentView.setNeedsLayout()
    }

    @objc func dismiss() {
        contentView.removeFromSuperview()
    }

    func onAnimate(isShow: Bool) {
        contentView.alpha = isShow ? 1 : 0
    }

    @available(*, deprecated, message: "ToastOperation control")
    func showAnimation() {
        UIView.beginAnimations("show", context: nil)
        UIView.setAnimationCurve(.easeIn)
        UIView.setAnimationDuration(0.3)
        contentView.alpha = 1
        UIView.commitAnimations()
    }

    @available(*, deprecated, message: "ToastOperation control")
    @objc func hideAnimation() {
        UIView.beginAnimations("hide", context: nil)
        UIView.setAnimationCurve(.easeOut)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(dismiss))
        UIView.setAnimationDuration(0.3)
        contentView.alpha = 0
        UIView.commitAnimations()
    }

    class func show(text: String) {
        guard Thread.isMainThread else {
            return
        }

        let operation = ToastOperation.init(text: text)
        ToastHandler.shared.add(operation)
    }
}
