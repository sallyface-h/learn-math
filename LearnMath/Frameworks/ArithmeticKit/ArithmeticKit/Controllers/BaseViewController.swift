//
//  BaseViewController.swift
//  ArithmeticKit_Example
//
//  Created by Jackie on 7/28/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import UIKit
import EachNavigationBar
import AppearanceKit
import ProgressHUD

open class BaseViewController: UIViewController & ControllerParameterable {
    
    public var params: [String : Any]
    
    public var isBackGestureEnable: Bool = true
    
    public var navHide: Bool = false {
        didSet {
            self.navigation.bar.isHidden = navHide
        }
    }

    required public init(_ params: [String : Any] = [:]) {
        self.params = params
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBtnHeight = 64.0.scale()
        if (self.navigationController?.viewControllers.count ?? 0) > 1 {
            let btn = BaseBackButton(type: .custom)
            btn.setImage(UIImage.em.image("nav_back"), for: .normal)
            btn.frame = CGRect(x: 0.0, y: 0.0, width: 76.0.scale(), height: backBtnHeight)
            btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            navigation.bar.backBarButtonItem = BackBarButtonItem(customView: btn)
        }
        
        let navHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
        navigation.bar.layoutPaddings = UIEdgeInsets(top: 0.0, left: 0.0, bottom: (backBtnHeight - navHeight) * 0.5, right: 0.0)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isBackGestureEnable {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc open func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        ProgressHUD.dismiss()
    }

}
