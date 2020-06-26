//
//  ToastHandler.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/26.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class ToastHandler: NSObject {
    public static let shared = ToastHandler.init()

    private let queue: OperationQueue

    open var currentToastOperation: ToastOperation? {
        return queue.operations.first(where: { !$0.isCancelled && !$0.isFinished }) as? ToastOperation
    }

    override init() {
        // 规定最大并发数为1的队列
        queue = OperationQueue.init()
        queue.maxConcurrentOperationCount = 1

        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    func add(_ toastOperation: ToastOperation) {
        queue.addOperation(toastOperation)
    }

    func cancelAll() {
        queue.cancelAllOperations()
    }

    @objc func deviceOrientationChange() {
        if let lastToast = queue.operations.first as? ToastOperation {
            lastToast.toast.contentView.setNeedsLayout()
        }
    }
}
