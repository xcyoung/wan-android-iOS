//
//  XError.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class XError: NSError {
    public var message: String = ""

    override var localizedDescription: String {
        get {
            #if DEBUG
                return "[\(code)]\(message)"
            #else
                return message
            #endif

        }
    }

    convenience init(code: Int, message: String) {
        self.init(domain: "XError", code: code, userInfo: nil)
        self.message = message
    }
}
