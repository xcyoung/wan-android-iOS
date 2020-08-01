//
//  Ext_UIImageView.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/1.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
extension UIImageView {
    func load(_ url: String, placeholder: UIImage? = nil) {
        let withUrl = URL.init(string: url)
        sd_setImage(with: withUrl, placeholderImage: placeholder, options: [], progress: nil, completed: nil)
    }
}
