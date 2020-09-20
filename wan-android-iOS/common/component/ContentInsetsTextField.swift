//
//  ContentInsetsTextField.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/9/19.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class ContentInsetsTextField: UITextField {
    var contentEdgeInsets: UIEdgeInsets = .zero
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect.init(
            x: bounds.minX + contentEdgeInsets.left,
            y: bounds.minY + contentEdgeInsets.top,
            width: bounds.width - contentEdgeInsets.left - contentEdgeInsets.right,
            height: bounds.height - contentEdgeInsets.top - contentEdgeInsets.bottom)

        return rect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect.init(
            x: bounds.minX + contentEdgeInsets.left,
            y: bounds.minY + contentEdgeInsets.top,
            width: bounds.width - contentEdgeInsets.left - contentEdgeInsets.right,
            height: bounds.height - contentEdgeInsets.top - contentEdgeInsets.bottom)

        return rect
    }
}
