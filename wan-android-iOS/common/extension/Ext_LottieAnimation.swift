//
//  Ext_LottieAnimation.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/26.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import Lottie
extension Animation {
    static func nameWithMode(_ name: String, subdirectory: String? = nil) -> Animation? {
        let realName: String
        let realSubdirectory: String
//        if #available(iOS 13.0, *) {
//            let currentMode = UITraitCollection.current.userInterfaceStyle
//            if (currentMode == .dark) {
//                realName = name + "_dark"
//            } else {
//                realName = name
//            }
//        } else {
            realName = name
//        }
        realSubdirectory = "animation/\(name)"
        return named(realName, subdirectory: realSubdirectory)
    }
}
