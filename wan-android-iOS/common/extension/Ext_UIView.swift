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
    
    var safeAreaLeft: CGFloat {
        get {
            return getMainWindowSafeAreaInsets().left
        }
    }
    
    var safeAreaRight: CGFloat {
        get {
            return getMainWindowSafeAreaInsets().right
        }
    }
    
    var safeAreaTop: CGFloat {
        get {
            return getMainWindowSafeAreaInsets().top
        }
    }
    
    var safeAreaBottom: CGFloat {
        get {
            return getMainWindowSafeAreaInsets().bottom
        }
    }
    
    var matchWidth: CGFloat {
        get {
            return frame.width - getMainWindowSafeAreaInsets().left - getMainWindowSafeAreaInsets().right
        }
    }
}
