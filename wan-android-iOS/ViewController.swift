//
//  ViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/18.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import UIKit
import SnapKit
import MyLayout
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
        
//        articleViewModel.onRefresh(pageIndex: 0)
        let s = MyFlowLayout.init(orientation: MyOrientation_Vert, arrangedCount: 4)
        s?.myHeight = 400
        s?.myWidth = 300
        s?.padding = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        s?.gravity = MyGravity_Fill
        s?.subviewSpace = 10
        
        let label = UILabel.init()
        label.textColor = UIColor.blue
        label.text = "111"
        s?.addSubview(label)
        
        let label2 = UILabel.init()
        label2.textColor = UIColor.red
        label2.text = "222"
        s?.addSubview(label2)
        
        self.view.addSubview(s!)
        
//        label.snp.makeConstraints { m in
//            if #available(iOS 11.0, *) {
//                m.left.equalTo(self.view.safeAreaInsets.left)
//                m.top.equalTo(self.view.safeAreaInsets.top)
//            } else {
//                // Fallback on earlier versions
//            }
//
//        }
//
//        label2.snp.makeConstraints { m in
//            if #available(iOS 11.0, *) {
//                m.left.equalTo(label.snp.right)
//                m.top.equalTo(self.view.safeAreaInsets.top)
//            } else {
//                // Fallback on earlier versions
//            }
//        }
//
        label.isHidden = true
    }


    @objc func labelClick() {
        Toast.show(text: "你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？")
        Toast.show(text: "你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？你好吗？2")
        Toast.show(text: "你好吗？你好吗？3")
    }
}

