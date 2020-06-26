//
//  Ext_UIApplication.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/25.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
extension UIApplication {
    //  MARK: - 获取app的mainWindow
    open func getMainWindow() -> UIWindow? {
        //  MARK: - iOS13引入Sence的概念，若在info.plist下配置了Sence Configuration(应该是有SceneDelegate的配置)则该window的获取是不准的
        guard let mainWindow = UIApplication.shared.delegate?.window else {
            return nil
        }

        return mainWindow
    }
}
