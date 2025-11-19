//
//  ViewController+Appearance.swift
//  AppearanceKit_Example
//
//  Created by 3commas on 4/18/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit

extension AppearanceX where Base: UIViewController {

    public func removeSelfFromNavigationStack(_ delaySeconds: Double = 0.4) {
        if delaySeconds == 0.0 {
            if let viewControllers = self.base.navigationController?.viewControllers, viewControllers.count > 2 {
                let i = viewControllers.count - 2
                if let realSelf = viewControllers.safe[i], realSelf == self.base {
                    self.base.navigationController?.viewControllers.remove(at: i)
                }
            }
        } else {
            let targetTime = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * delaySeconds)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: targetTime) {
                if let viewControllers = self.base.navigationController?.viewControllers, viewControllers.count > 2 {
                    let i = viewControllers.count - 2
                    if let realSelf = viewControllers.safe[i], realSelf == self.base {
                        self.base.navigationController?.viewControllers.remove(at: i)
                    }
                }
            }
        }
    }
    
    public static func topViewController(controller: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
}
