//
//  AccountViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/22.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout
import Lottie
class AccountViewController: BaseViewController {
    private let accountViewModel: AccountViewModel = AccountViewModel.init()
    private var subVCMap: [Int: BaseViewController] = [:]
    private let logoView: AnimationView = {
        let view: AnimationView = AnimationView.init()

        let animation = Animation.named("android_logo", subdirectory: "animation/android_logo")

        view.animation = animation
        view.contentMode = .scaleAspectFit
        view.backgroundBehavior = .pauseAndRestore
        return view
    }()

    private let accountViewLayout: MyFrameLayout = {
        let view = MyFrameLayout.init()
//        view.backgroundColor = UIColor.black
        return view
    }()

    private let closeBtn: UIButton = {
        let btn = UIButton.init()
        btn.backgroundColor = UIColor.project.text
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.parentView.removeFromSuperview()

        accountViewModel.viewSwtichLiveData.asObservable().subscribe { [weak self] (event) in
            guard let model = event.element else {
                return
            }

            if model.from == .select {
                self?.normal2Edit(to: model.to)
            } else {
                self?.edit2Normal(from: model.from)
            }
        }.disposed(by: disposeBag)

        accountViewModel.dismissLiveData.asObservable().subscribe { [weak self] (event) in
            guard let isDismiss = event.element, isDismiss else {
                return
            }

            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)

        showSubViewController(index: AccountView.signIn.rawValue, shouldShow: false)
        showSubViewController(index: AccountView.signUp.rawValue, shouldShow: false)
        showSubViewController(index: AccountView.select.rawValue)

        logoView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)

        self.view.backgroundColor = UIColor.project.background

        self.closeBtn.addTarget(self, action: #selector(onCloseClick(_:)), for: .touchUpInside)
    }

    override func initView() {
        super.initView()

        self.closeBtn.frame = CGRect.init(x: self.view.frame.minX + 16, y: self.view.frame.minY + 20 + 16, width: 30, height: 30)
        self.normalLayout()
        self.view.addSubview(logoView)
        self.view.addSubview(accountViewLayout)
        self.view.addSubview(closeBtn)
    }

    func normalLayout() {
        let totalWidth = self.view.frame.width
        let totalHeight = self.view.frame.height - 20
        let logoHeight = totalHeight * 2 / 3
        logoView.frame = CGRect.init(x: 0, y: 20, width: totalWidth, height: logoHeight)
        accountViewLayout.frame = CGRect.init(x: 0, y: logoHeight + 20, width: totalWidth, height: totalHeight - logoHeight)

    }

    func editLayout() {
        let totalWidth = self.view.frame.width
        let totalHeight = self.view.frame.height - 20
        let logoHeight = totalHeight / 4
        let logoWidth = totalWidth / 3
        logoView.frame = CGRect.init(x: (totalWidth - logoWidth) / 2, y: 20, width: logoWidth, height: logoHeight)
        accountViewLayout.frame = CGRect.init(x: 0, y: logoHeight + 20, width: totalWidth, height: totalHeight - logoHeight)
    }

    func showSubViewController(index: Int, shouldShow: Bool = true) {
        if self.subVCMap[index] == nil {
            let vc: BaseViewController
            switch index {
            case AccountView.select.rawValue:
                vc = AccountSelectViewController.init(accountViewModel: accountViewModel)
                break
            case AccountView.signIn.rawValue:
                vc = SignInViewController.init(accountViewModel: accountViewModel)
                break
            case AccountView.signUp.rawValue:
                vc = SignUpViewController.init(accountViewModel: accountViewModel)
                break
            default:
                vc = AccountSelectViewController.init(accountViewModel: accountViewModel)
                break
            }
            vc.view.frame = CGRect.init(x: 0, y: 0, width: self.accountViewLayout.frame.width, height: self.accountViewLayout.frame.height)
//            self.addChild(vc)
            self.accountViewLayout.addSubview(vc.view)
            subVCMap[index] = vc
        }
        if shouldShow {
            subVCMap.forEach { (key: Int, value: BaseViewController) in
                if key == index {
                    value.view.isHidden = false
                } else {
                    value.view.isHidden = true
                }
            }
        } else {
            subVCMap[index]?.view.isHidden = false
        }
    }

    /*
     动画路径:
     select -> signIn or signUp
        1、normalLayout()   ps: logoHeight:accountViewHeight = 2:1
        2、transition(from: AccountView, to: AccountView)
     signIn or signUp -> select
        1、editLayout()   ps: logoHeight:accountViewHeight = 1:3
        2、transition(from: AccountView, to: AccountView)
     */
    func transition(from: AccountView, to: AccountView) {
        if from == .select && to == .signIn {
            self.select2SignIn()
        } else if from == .signIn && to == .select {
            self.signIn2Select()
        } else if from == .select && to == .signUp {
            self.select2SignUp()
        } else if from == .signUp && to == .select {
            self.signUp2Select()
        }
    }

    func createAnimateBtn() -> UIButton {
        let btn = UIButton.init()
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(UIColor.project.item, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = UIColor.project.primary
        btn.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
        return btn
    }

    func createSignUpAnimationBtn() -> UIButton {
        let btn = UIButton.init()
        btn.setTitle("注册", for: .normal)
        btn.setTitleColor(UIColor.project.primary, for: .normal)
        return btn
    }

    func select2SignIn() {
        if let selectVC = subVCMap[AccountView.select.rawValue] as? AccountSelectViewController,
            let signInVC = subVCMap[AccountView.signIn.rawValue] as? SignInViewController {
            let btn1 = selectVC.getSignInBtn()
            let btn2 = signInVC.getSignInBtn()

            let btn: UIButton = self.createAnimateBtn()

            let btn1Rect = btn1.convert(btn1.bounds, to: self.view)
            let btn2Rect = btn2.convert(btn2.bounds, to: self.view)

            self.view.addSubview(btn)
            btn.frame = btn1Rect
            let targetRect = btn2Rect
            UIView.animate(withDuration: 0.7,
                delay: 0.2,
                options: [],
                animations: {
                    btn.frame = targetRect
                    selectVC.view.alpha = 0
                }) { (_) in
                selectVC.view.isHidden = true
                signInVC.view.isHidden = false
                btn.removeFromSuperview()
            }
        }
    }

    func select2SignUp() {
        if let selectVC = subVCMap[AccountView.select.rawValue] as? AccountSelectViewController,
            let signUpVC = subVCMap[AccountView.signUp.rawValue] as? SignUpViewController {
            let btn1 = selectVC.getSignUpBtn()
            let btn2 = signUpVC.getSignUpBtn()

            let btn: UIButton = self.createSignUpAnimationBtn()

            let btn1Rect = btn1.convert(btn1.bounds, to: self.view)
            let btn2Rect = btn2.convert(btn2.bounds, to: self.view)

            self.view.addSubview(btn)
            btn.frame = btn1Rect
            let targetRect = btn2Rect
            UIView.animate(withDuration: 0.7,
                delay: 0.2,
                options: [],
                animations: {
                    btn.frame = targetRect
                    selectVC.view.alpha = 0
                }) { (_) in
                selectVC.view.isHidden = true
                btn.backgroundColor = UIColor.project.primary
                btn.setTitleColor(UIColor.project.item, for: .normal)
                signUpVC.view.isHidden = false
                btn.removeFromSuperview()
            }
        }
    }

    func signIn2Select() {
        if let selectVC = subVCMap[AccountView.select.rawValue] as? AccountSelectViewController,
            let signInVC = subVCMap[AccountView.signIn.rawValue] as? SignInViewController {
            let btn1 = selectVC.getSignInBtn()
            let btn2 = signInVC.getSignInBtn()

            let btn: UIButton = self.createAnimateBtn()

            let btn1Rect = btn1.convert(btn1.bounds, to: self.view)
            let btn2Rect = btn2.convert(btn2.bounds, to: self.view)

            self.view.addSubview(btn)
            btn.frame = btn2Rect
            let targetRect = btn1Rect
            UIView.animate(withDuration: 0.7,
                delay: 0.2,
                options: [],
                animations: {
                    btn.frame = targetRect
                    signInVC.view.isHidden = true
                    selectVC.view.alpha = 1
                }) { (_) in
                selectVC.view.isHidden = false
                btn.removeFromSuperview()
            }
        }
    }

    func signUp2Select() {
        if let selectVC = subVCMap[AccountView.select.rawValue] as? AccountSelectViewController,
            let signUpVC = subVCMap[AccountView.signUp.rawValue] as? SignUpViewController {
            let btn1 = selectVC.getSignUpBtn()
            let btn2 = signUpVC.getSignUpBtn()

            let btn: UIButton = self.createAnimateBtn()
            btn.setTitle("注册", for: .normal)

            let btn1Rect = btn1.convert(btn1.bounds, to: self.view)
            let btn2Rect = btn2.convert(btn2.bounds, to: self.view)

            self.view.addSubview(btn)
            btn.frame = btn2Rect
            let targetRect = btn1Rect
            UIView.animate(withDuration: 0.7,
                delay: 0.2,
                options: [],
                animations: {
                    btn.frame = targetRect
                    btn.backgroundColor = UIColor.project.background
                    btn.setTitleColor(UIColor.project.primary, for: .normal)
                    signUpVC.view.isHidden = true
                    selectVC.view.alpha = 1
                }) { (_) in
                selectVC.view.isHidden = false
                btn.removeFromSuperview()
            }
        }
    }

    func normal2Edit(to: AccountView) {
        UIView.animate(withDuration: 0.5,
            delay: 0,
            options: [],
            animations: { [weak self] in
                self?.editLayout()
            }, completion: { [weak self] (success) in
                if success {
                    self?.transition(from: .select, to: to)
                }
            })
    }

    func edit2Normal(from: AccountView) {
        UIView.animate(withDuration: 0.5,
            delay: 0,
            options: [],
            animations: { [weak self] in
                self?.normalLayout()
            }, completion: { [weak self] (success) in
                if success {
                    self?.transition(from: from, to: .select)
                }
            })
    }

    @objc private func onCloseClick(_ sender: UIButton) {
        self.accountViewModel.goBack()
    }

    override func getNavigationBarHidden() -> (hidden: Bool, animated: Bool) {
        return (hidden: true, animated: true)
    }
}
