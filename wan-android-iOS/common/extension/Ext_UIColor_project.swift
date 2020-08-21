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

    class func modeColor(light: UInt32, dark: UInt32) -> UIColor {
        let color: UIColor
        if #available(iOS 13, *) {
            color = UIColor { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor.init(hex8: dark)
                } else {
                    return UIColor.init(hex8: light)
                }
            }
        } else {
            color = UIColor.init(hex8: light)
        }

        return color
    }
    
    let toastBackound: UIColor = Project.modeColor(light: "#99000000", dark: "#eeffffff")
    let toastLabel: UIColor = Project.modeColor(light: "#ffffff", dark: "#000000")
    let green: UIColor = Project.make("#00BFA6")
    
    let primary: UIColor = Project.modeColor(light: 0xFF00BFA6, dark: 0xFF6c63ff)
    let lightPrimary: UIColor = Project.modeColor(light: 0xFF4DE9D4, dark: 0xFFa491ff)
    let darkPrimary: UIColor = Project.modeColor(light: 0xFF008e77, dark: 0xFF2838cb)
    
    let secondary: UIColor = Project.modeColor(light: 0xFFFF6A00, dark: 0xffFFD449)
    let lightSecondary: UIColor = Project.modeColor(light: 0xFFFF9B54, dark: 0xFFFFE285)
    let darkSecondary: UIColor = Project.modeColor(light: 0xFFAB6838, dark: 0xFFAB9859)
    
    let text: UIColor = Project.modeColor(light: 0xff000000, dark: 0xffffffff)
    let background: UIColor = Project.modeColor(light: 0xfff5f5f5, dark: 0xFF1C1C1D)
    let appBackground: UIColor = Project.modeColor(light: 0xfff5f5f5, dark: 0xff000000)
    let appBar: UIColor = Project.modeColor(light: 0xFFFFFFFF, dark: 0xFF1C1C1D)
    let item: UIColor = Project.modeColor(light: 0xffffffff, dark: 0xff000000)
}
