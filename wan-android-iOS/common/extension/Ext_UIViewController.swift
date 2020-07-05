//
//  Ext_UIViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func toast(message: String) {
        Toast.show(text: message)
    }
    
    func toastError(error: XError) {
        toast(message: error.localizedDescription)
    }
}
