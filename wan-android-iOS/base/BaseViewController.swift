//
//  BaseViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/25.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
class BaseViewController: UIViewController {
    public let disposeBag = DisposeBag.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    open func initView() {

    }
}
