//
//  Ext_UIColor_Hex.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/25.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

/**
 MissingHashMarkAsPrefix:   "Invalid RGB string, missing '#' as prefix"
 UnableToScanHexValue:      "Scan hex error"
 MismatchedHexStringLength: "Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8"
 */
public enum UIColorInputError: Error {
    case MissingHashMarkAsPrefix,
        UnableToScanHexValue,
        MismatchedHexStringLength
}

extension UIColor {
    /**
     The shorthand three-digit hexadecimal representation of IdtColor.
     #RGB defines to the IdtColor #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    @objc dynamic public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue = CGFloat(hex3 & 0x00F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The shorthand four-digit hexadecimal representation of IdtColor with alpha.
     #RGBA defines to the IdtColor #RRGGBBAA.
     
     - parameter hex4: Four-digit hexadecimal value.
     */
    @objc dynamic public convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let alpha = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let red = CGFloat((hex4 & 0x0F00) >> 8) / divisor
        let green = CGFloat((hex4 & 0x00F0) >> 4) / divisor
        let blue = CGFloat(hex4 & 0x000F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The six-digit hexadecimal representation of IdtColor of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    @objc dynamic public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The six-digit hexadecimal representation of IdtColor with alpha of the form #AARRGGBB.
     
     - parameter hex8: Eight-digit hexadecimal value.
     */
    @objc dynamic public convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let alpha = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let red = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let green = CGFloat((hex8 & 0x0000FF00) >> 8) / divisor
        let blue = CGFloat(hex8 & 0x000000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The rgba string representation of IdtColor with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
     
     - parameter rgba: String value.
     */
    @objc dynamic public convenience init(argb_throws rgba: String) throws {
        guard rgba.hasPrefix("#") else {
            throw UIColorInputError.MissingHashMarkAsPrefix
        }
        let hexString: String = String.init(rgba.dropFirst())
        var hexValue: UInt32 = 0
        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            throw UIColorInputError.UnableToScanHexValue
        }

        guard hexString.count == 3
            || hexString.count == 4
            || hexString.count == 6
            || hexString.count == 8 else {
                throw UIColorInputError.MismatchedHexStringLength
        }

        switch (hexString.count) {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(hex6: hexValue)
        default:
            self.init(hex8: hexValue)
        }
    }

    /**
     The rgba string representation of IdtColor with alpha of the form #RRGGBBAA/#RRGGBB, fails to default IdtColor.
     
     - parameter rgba: String value.
     */
    @objc dynamic public convenience init(argb: String, defaultColor: UIColor = UIColor.clear) {
        guard let IdtColor = try? UIColor(argb_throws: argb) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: IdtColor.cgColor)
    }

    /**
     Hex string of a UIColor instance.
     
     - parameter rgba: Whether the alpha should be included.
     */
    @objc dynamic public func hexString(includeAlpha: Bool) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)

        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(a * 255), Int(r * 255), Int(g * 255), Int(b * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }

    @objc dynamic open override var description: String {
        return self.hexString(includeAlpha: true)
    }

    @objc dynamic open override var debugDescription: String {
        return self.hexString(includeAlpha: true)
    }
}
