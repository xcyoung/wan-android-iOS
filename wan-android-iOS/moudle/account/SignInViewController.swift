//
//  SignInViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/22.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout

class SignInViewController: BaseViewController {
    private let accountViewModel: AccountViewModel

    private let userNameTextFeild: CurrencyUnderLineTextField = {
        let textField = CurrencyUnderLineTextField.init()
        textField.placeholder = "用户名"
        textField.textColor = UIColor.project.text
        textField.keyboardType = .emailAddress
        textField.tintColor = UIColor.project.primary
        textField.lineColor = UIColor.project.primary
        textField.lineHeight = 1
        textField.clearButtonMode = .whileEditing
        textField.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        return textField
    }()

    private let passwordTextFeild: CurrencyUnderLineTextField = {
        let textField = CurrencyUnderLineTextField.init()
        textField.placeholder = "密码"
        textField.textColor = UIColor.project.text
        textField.keyboardType = .emailAddress
        textField.isSecureTextEntry = true
        textField.tintColor = UIColor.project.primary
        textField.lineColor = UIColor.project.primary
        textField.lineHeight = 1
        textField.clearButtonMode = .whileEditing
        textField.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        return textField
    }()

    private let signInBtn: UIButton = {
        let btn = UIButton.init(type: .system)
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(UIColor.project.item, for: .normal)
        btn.layer.cornerRadius = 22.5
        btn.backgroundColor = UIColor.project.primary
        btn.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
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
    }

    override func initView() {
        super.initView()

        let layout = MyLinearLayout.init()
        layout.orientation = MyOrientation_Vert
        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())

        userNameTextFeild.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        userNameTextFeild.myTop = CGFloat.init(8)
        userNameTextFeild.myTrailing = CGFloat.init(32)
        userNameTextFeild.myLeading = CGFloat.init(32)

        passwordTextFeild.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        passwordTextFeild.myTop = CGFloat.init(16)
        passwordTextFeild.myTrailing = CGFloat.init(32)
        passwordTextFeild.myLeading = CGFloat.init(32)

        signInBtn.mySize = CGSize.init(width: MyLayoutSize.fill(), height: 45)
        signInBtn.myTop = CGFloat.init(32)
        signInBtn.myTrailing = CGFloat.init(32)
        signInBtn.myLeading = CGFloat.init(32)

        layout.addSubview(userNameTextFeild)
        layout.addSubview(passwordTextFeild)
        layout.addSubview(signInBtn)
        parentView.addSubview(layout)
    }

    func getSignInBtn() -> UIButton {
        return signInBtn
    }

    @objc private func onSignInClick(_ sender: UIButton) {
        let userName = userNameTextFeild.text
        let password = passwordTextFeild.text

        if userName?.isEmpty == true {
            toast(message: "请输入用户名")
            return
        } else if password?.isEmpty == true {
            toast(message: "请输入密码")
            return
        } else {
            accountViewModel.signIn(userName: userName!, password: password!)
        }
    }
}
