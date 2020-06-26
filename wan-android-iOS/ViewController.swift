//
//  ViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/18.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let label = UILabel.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        label.backgroundColor = UIColor.init(argb: "#FFFF00")

        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelClick)))
        self.view.addSubview(label)
    }


    @objc func labelClick() {
        Toast.show(text: "你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？")
    }
}

