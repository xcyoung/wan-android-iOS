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

    override func viewDidLoad() {
        super.viewDidLoad()

        accountViewModel.viewSwtichLiveData.asObservable().subscribe { [weak self] (event) in
            guard let model = event.element else {
                return
            }
            self?.transition(from: model.from, to: model.to)
        }.disposed(by: disposeBag)

        showSubViewController(index: AccountView.signIn.rawValue, shouldShow: false)
        showSubViewController(index: AccountView.signUp.rawValue, shouldShow: false)
        showSubViewController(index: AccountView.select.rawValue)

        logoView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)

        self.view.backgroundColor = UIColor.project.background
    }

    override func initView() {
        super.initView()

        let layout = MyFlexLayout.init()
        layout.isFlex = true
        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        layout.myFlex.attrs.flex_wrap = MyFlexWrap_Wrap
        layout.myFlex.attrs.flex_direction = MyFlexDirection_Column

        logoView.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        logoView.myTop = CGFloat.init(30)
//        logoView.myBottom = CGFloat.init(10)
        logoView.myFlex.attrs.flex_grow = 1

        layout.addSubview(logoView)

        accountViewLayout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        accountViewLayout.myFlex.attrs.flex_grow = 4

        layout.addSubview(accountViewLayout)

        parentView.addSubview(layout)
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
//            vc.view.isHidden = false
        }
        if shouldShow {
            subVCMap.forEach { (key: Int, value: BaseViewController) in
                if key == index {
                    value.view.isHidden = false
                } else {
                    value.view.isHidden = true
                }
            }
        }
    }

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
        btn.layer.cornerRadius = 15
        btn.backgroundColor = UIColor.project.background
        btn.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
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
                delay: 0,
                options: [],
                animations: {
                    btn.frame = targetRect
                    selectVC.view.isHidden = true
                }) { (_) in
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
                delay: 0,
                options: [],
                animations: {

                    btn.frame = targetRect
                    btn.backgroundColor = UIColor.project.primary
                    btn.setTitleColor(UIColor.project.item, for: .normal)
                    selectVC.view.isHidden = true
                }) { (_) in
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
                delay: 0,
                options: [],
                animations: {
                    btn.frame = targetRect
                    signInVC.view.isHidden = true

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
                delay: 0,
                options: [],
                animations: {
                    btn.frame = targetRect
                    btn.backgroundColor = UIColor.project.background
                    btn.setTitleColor(UIColor.project.primary, for: .normal)
                    signUpVC.view.isHidden = true
                }) { (_) in
                selectVC.view.isHidden = false
                btn.removeFromSuperview()
            }
        }
    }

    override func getNavigationBarHidden() -> (hidden: Bool, animated: Bool) {
        return (hidden: true, animated: true)
    }
}
