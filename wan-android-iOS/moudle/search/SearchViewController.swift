//
//  SearchViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/9/19.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: BaseViewController {
    private let searchViewModel: SearchViewModel = SearchViewModel.init()
    private let searchArea: UIView = {
        let view = UIView.init()
        return view
    }()

    private let backBtn: UIButton = {
        let btn = UIButton.init()
        let image = R.image.wan_ic_back_arrow_left()
        btn.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor.project.text
        return btn
    }()

    private let searchTextField: ContentInsetsTextField = {
        let textField = ContentInsetsTextField.init()
        textField.placeholder = "用空格隔开多个关键词"
        textField.textColor = UIColor.project.text
        textField.keyboardType = .default
        textField.tintColor = UIColor.project.primary
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.project.appBar.cgColor
        textField.backgroundColor = UIColor.project.appBar
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .search
        textField.contentEdgeInsets = .init(top: 2, left: 8, bottom: 2, right: 8)
        return textField
    }()

    private let contentView: UIView = {
        let view = UIView.init()

        return view
    }()

    private var subVCMap: [Int: BaseViewController] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()

        searchViewModel.beforeSearchLiveData.asObservable().subscribe { [weak self] (event) in
            guard let keyword = event.element,
                !keyword.isEmpty
                else {
                    return
            }
            
            self?.onSearch(keyword: keyword)
        }.disposed(by: disposeBag)

        backBtn.addTarget(self, action: #selector(onBackClick(_:)), for: .touchUpInside)
        searchTextField.delegate = self
        showSubViewController(index: 0)
    }

    override func initView() {
        super.initView()

        let searchAreaWidth = UIScreen.main.bounds.width - view.safeAreaLeft - view.safeAreaRight
        searchArea.frame = CGRect.init(x: view.safeAreaLeft, y: view.safeAreaTop, width: searchAreaWidth, height: 56)
        contentView.frame = CGRect.init(x: view.safeAreaLeft, y: view.safeAreaTop + 56, width: searchAreaWidth, height: UIScreen.main.bounds.height - view.safeAreaTop - 56 - view.safeAreaBottom)
        self.view.addSubview(searchArea)
        self.view.addSubview(contentView)

        self.backBtn.frame = CGRect.init(x: 10, y: (searchArea.frame.height - 30) / 2, width: 30, height: 30)
        self.searchTextField.frame = CGRect.init(x: backBtn.frame.maxX + 5, y: 10, width: searchArea.frame.width - backBtn.frame.width - 25, height: searchArea.frame.height - 20)
        searchArea.addSubview(backBtn)
        searchArea.addSubview(searchTextField)
    }

    override func getNavigationBarHidden() -> (hidden: Bool, animated: Bool) {
        return (hidden: true, animated: true)
    }

    @objc private func onBackClick(_ sender: UIView) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func onSearch(keyword: String) {
        searchTextField.resignFirstResponder()
        
        if searchTextField.text != keyword {
            searchTextField.text = keyword
            
        }
        showSubViewController(index: 1)
        self.searchViewModel.onSearch(keyword: keyword)
    }

    private func showSubViewController(index: Int) {
        if self.subVCMap[index] == nil {
            let vc: BaseViewController
            switch index {
            case 0:
                vc = SearchGuideViewController.init(searchViewModel: searchViewModel)
                break
            case 1:
                vc = SearchResultViewController.init(searchViewModel: searchViewModel)
                break
            default:
                vc = UIViewController.init() as! BaseViewController
                break
            }
            vc.view.frame = CGRect.init(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
            self.contentView.addSubview(vc.view)
            self.addChild(vc)
            subVCMap[index] = vc
        }
        subVCMap.forEach { (key: Int, value: BaseViewController) in
            if key == index {
                value.view.isHidden = false
            } else {
                value.view.isHidden = true
            }
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showSubViewController(index: 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let keyword = textField.text {
            onSearch(keyword: keyword)
            return true
        }
        return false
    }
}
