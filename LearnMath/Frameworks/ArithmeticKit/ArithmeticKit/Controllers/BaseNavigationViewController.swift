//
//  BaseNavigationViewController.swift
//  ArithmeticKit_Example
//
//  Created by Jackie on 7/28/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import UIKit
import EachNavigationBar
import AppearanceKit

open class BaseNavigationViewController: UINavigationController {
    
    public var animator: BaseAnimator?
    
    public var isRotating: Bool = false
    public var isFullScreen: Bool = false
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        navigation.configuration.isEnabled = true
        navigation.configuration.isShadowHidden = true
        navigation.configuration.shadow = nil
        navigation.configuration.shadowImage = nil
        navigation.configuration.barTintColor = UIColor.clear
        navigation.configuration.isTranslucent = false
        navigation.configuration.tintColor = UIColor.ap.color(ColorSet.white)
        navigation.configuration.backItem = UINavigationController.Configuration.BackItem(style: .image(UIImage.em.image("nav_back")))
        let navBarHeight = self.navigationBar.frame.height
        let navHeight = 64.0.scale()
        navigation.configuration.additionalHeight = navHeight - navBarHeight
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open var shouldAutorotate : Bool {
        return isRotating
    }

    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return isFullScreen ? .landscapeRight : .portrait
    }

}
