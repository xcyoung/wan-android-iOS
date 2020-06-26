//
//  Ext_UIColor_project.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/26.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    static let project = Project.init()
}

class Project: NSObject {
    private class func make(_ argb: String) -> UIColor {
        return UIColor.init(argb: argb)
    }

    // MARK: - 适配iOS13深色模式
    private class func modeColor(light: String, dark: String) -> UIColor {
        let color: UIColor
        if #available(iOS 13, *) {
            color = UIColor { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor.init(argb: dark)
                } else {
                    return UIColor.init(argb: light)
                }
            }
        } else {
            color = UIColor.init(argb: light)
        }

        return color
    }

    let toastBackound: UIColor = Project.modeColor(light: "#99000000", dark: "#eeffffff")
    let toastLabel: UIColor = Project.modeColor(light: "#ffffff", dark: "#000000")
}
