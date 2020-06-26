//
//  ToastOperation.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/26.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
// 用于防止toast并发的等待队列
class ToastOperation: Operation {
    let toast: Toast

    private var _executing = false
    override var isExecuting: Bool {
        get {
            return self._executing
        }
        set {
            self.willChangeValue(forKey: "isExecuting")
            _executing = newValue
            self.didChangeValue(forKey: "isExecuting")
        }
    }

    private var _finished = false
    override var isFinished: Bool {
        get {
            return self._finished
        }
        set {
            self.willChangeValue(forKey: "isFinished")
            _finished = newValue
            self.didChangeValue(forKey: "isFinished")
        }
    }

    init(text: String) {
        self.toast = Toast.init(text: text)
    }

    override func start() {
        let isRunable = !isFinished && !isExecuting && !isCancelled
        guard isRunable else {
            return
        }
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.start()
            }
            return
        }

        main()
    }

    override func main() {
        self.isExecuting = true
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.toast.show()
            weakSelf.showAnimation()
            weakSelf.perform(#selector(weakSelf.hideAnimation), with: nil, afterDelay: TimeInterval.init(Toast.defaultDuration))
        }
    }

    override func cancel() {
        super.cancel()
        dismiss()
    }

    func finish() {
        self.isExecuting = false
        self.isFinished = true
    }

    @objc func dismiss() {
        finish()
        toast.dismiss()
    }

    func showAnimation() {
        UIView.beginAnimations("show", context: nil)
        UIView.setAnimationCurve(.easeIn)
        UIView.setAnimationDuration(0.8)
        toast.onAnimate(isShow: true)
        UIView.commitAnimations()
    }

    @objc func hideAnimation() {
        UIView.beginAnimations("hide", context: nil)
        UIView.setAnimationCurve(.easeOut)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(dismiss))
        UIView.setAnimationDuration(0.8)
        toast.onAnimate(isShow: false)
        UIView.commitAnimations()
    }
}
