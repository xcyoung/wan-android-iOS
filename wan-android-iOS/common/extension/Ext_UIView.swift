//
//  Ext_UIView.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/23.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func getMainWindowSafeAreaInsets() -> UIEdgeInsets {
        if #available(iOS 11, *) {
            return UIApplication.shared.getMainWindow()?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }
}
