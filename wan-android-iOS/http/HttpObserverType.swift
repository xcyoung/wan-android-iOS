//
//  HttpObserverType.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/6.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import RxSwift
class HttpObserverType<E>: ObserverType where E: Codable {
    private let error: (_ error: XError) -> Void
    private let success: (_ result: WanResponse<E>) -> Void

    init(success: @escaping (_ result: WanResponse<E>) -> Void, error: @escaping (_ error: XError) -> Void) {
        self.error = error
        self.success = success
    }

    func on(_ event: Event<WanResponse<E>>) {
        switch event {
        case .next(let element):
            if element.errorCode == ErrorCode.success.rawValue {
                success(element)
            } else {
                onError(XError.init(code: element.errorCode, message: element.errorMsg))
            }
        case .error(let error):
            if error is XError,
                let xError = error as? XError {
                self.error(xError)
            } else {
                self.error(XError.init(code: -1, message: error.localizedDescription))
            }
        default:
            break
        }
    }

    typealias Element = WanResponse<E>
}
