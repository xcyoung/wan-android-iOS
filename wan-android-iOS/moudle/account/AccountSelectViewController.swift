//
//  AccountSelectViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/22.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout

class AccountSelectViewController: BaseViewController {
    private let accountViewModel: AccountViewModel

    private let signInBtn: UIButton = {
        let btn = UIButton.init(type: .system)
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(UIColor.project.item, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = UIColor.project.primary
        btn.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
        return btn
    }()

    private let signUpBtn: UIButton = {
        let btn = UIButton.init(type: .system)
        btn.setTitle("注册", for: .normal)
        btn.setTitleColor(UIColor.project.primary, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = UIColor.project.background
        btn.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
        return btn
    }()

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        signInBtn.addTarget(self, action: #selector(onSignInClick(_:)), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(onSignUPClick(_:)), for: .touchUpInside)
    }

    override func initView() {
        super.initView()
        let layout = MyLinearLayout.init()
        layout.orientation = MyOrientation_Vert
        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        layout.gravity = MyGravity_Center

        signInBtn.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        signInBtn.myTrailing = CGFloat.init(32)
        signInBtn.myLeading = CGFloat.init(32)

        signUpBtn.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        signUpBtn.myTop = CGFloat.init(8)
        signUpBtn.myTrailing = CGFloat.init(32)
        signUpBtn.myLeading = CGFloat.init(32)

        layout.addSubview(signInBtn)
        layout.addSubview(signUpBtn)
        parentView.addSubview(layout)
    }

    @objc private func onSignInClick(_ sender: UIButton) {
        accountViewModel.onViewSwtich(accountView: .signIn)
    }

    @objc private func onSignUPClick(_ sender: UIButton) {
        accountViewModel.onViewSwtich(accountView: .signUp)
    }

    func getSignInBtn() -> UIButton {
        return signInBtn
    }
    
    func getSignUpBtn() -> UIButton {
        return signUpBtn
    }
}
