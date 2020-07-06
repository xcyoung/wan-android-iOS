//
//  ViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/18.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    let articleViewModel = ArticleViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
//        let label = UILabel.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
//        label.backgroundColor = UIColor.init(argb: "#FFFF00")
//
//        label.isUserInteractionEnabled = true
//        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelClick)))
//
//        let image = DefaultLoadingView.init(frame: CGRect.init(x: 0, y: 200, width: UIScreen.main.bounds.width - 100, height: 500))
//        image.startLoading()
//
//        self.view.addSubview(image)
//        self.view.addSubview(label)
        showLoading()
        
        articleViewModel.onRefresh(pageIndex: 0)
    }


    @objc func labelClick() {
        Toast.show(text: "你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？")
        Toast.show(text: "你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？2")
        Toast.show(text: "你好吗？你好吗？3")
    }
}

