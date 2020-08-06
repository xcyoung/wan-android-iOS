//
//  TestViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //一共包含了两个视图
        let viewMain = UIViewController()
        viewMain.title = "2048"
        let viewSetting = UIViewController()
        viewSetting.title = "设置"
         
        self.viewControllers = [viewMain,viewSetting]
    }
}
