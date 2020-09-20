//
//  RouterCenter.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/9.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import URLNavigator

class RouterCenter: NSObject {
    public static let shared: RouterCenter = RouterCenter.init()

    private let navigator = Navigator()

    enum Path: String, CaseIterable {
        case browser = "/browser"
        case account = "/account"
        case search = "/search"
        func absolutePath() -> String {
            return "xWanAndroid://me.xcyoung.com" + self.rawValue
        }
    }

    override init() {

    }

    func initialize() {
        Path.allCases.forEach { (path) in
            self.register(path: path.absolutePath())
            self.handle(path: path.absolutePath())
        }
    }

    func register(path: String) {
        navigator.register(path) { (url, value, context) -> UIViewController? in
            return self.onRegister(url: url.urlValue, urlString: url.urlStringValue, queryParameters: url.queryParameters, values: value, context: context)
        }
    }

    func handle(path: String) {
        navigator.handle(path) { (url, value, context) -> Bool in
            return self.onHandle(url: url.urlValue, urlString: url.urlStringValue, queryParameters: url.queryParameters, values: value, context: context)
        }
    }

    func onRegister(url: URL?, urlString: String, queryParameters: [String: String], values: [String: Any], context: Any?) -> UIViewController? {
        switch url?.path {
        case Path.browser.rawValue:
            let target = BrowserViewController.init()
            let paramUrl = queryParameters["url"]
            target.params["url"] = paramUrl
            return target
        case Path.account.rawValue:
            let target = AccountViewController.init()
            let accountNavigationVC = UINavigationController.init(rootViewController: target)
            accountNavigationVC.modalPresentationStyle = .fullScreen
            return accountNavigationVC
        case Path.search.rawValue:
            let target = SearchViewController.init()
            return target
        default:
            return nil
        }
    }

    func onHandle(url: URL?, urlString: String, queryParameters: [String: String], values: [String: Any], context: Any?) -> Bool {
        return true
    }

    func goToBrowser(url: String) {
        navigator.push("\(Path.browser.absolutePath())?url=\(url)")
    }

    func goToAccount() {
        navigator.present(Path.account.absolutePath())
    }

    func goToSearch(fromVC: UIViewController? = nil) {
        navigator.push("\(Path.search.absolutePath())")
    }
}


class WanNavigationDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC.isKind(of: HomeViewController.self),
            toVC.isKind(of: SearchViewController.self) {
            return PushSearchAnimatedTransitioning.init()
        }
        return nil
    }
}

class PushSearchAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)
        let fromVC = transitionContext.viewController(forKey: .from)

        if let homeVC = fromVC as? HomeViewController,
            let searchVC = toVC as? SearchViewController {
            home2Search(homeVC: homeVC, searchVC: searchVC, using: transitionContext)
        } else {

        }
    }

    private func home2Search(
        homeVC: HomeViewController,
        searchVC: SearchViewController,
        using transitionContext: UIViewControllerContextTransitioning) {
//        guard let articleMainVC = homeVC.subVCMap[0] as? ArticleMainViewController
//            else {
//                return
//        }
//        let fromView = articleMainVC.getSearchBar()
//        let toView = searchVC.getSearchArea()
        transitionContext.containerView.addSubview(searchVC.view)
        transitionContext.containerView.bringSubviewToFront(homeVC.view)
//        let toFrame = toView.frame
//        let fromFrame = fromView.frame
        UIView.animate(withDuration: 0.5, animations: {
//            fromView.alpha = 0
//            fromView.frame = toFrame
//            toView.alpha = 1.0
            homeVC.view.alpha = 0
            searchVC.view.alpha = 1
        }) { (_) in
//            fromView.frame = fromFrame
            transitionContext.completeTransition(true)
//            fromView.alpha = 1.0
            homeVC.view.alpha = 1
        }
    }
}
