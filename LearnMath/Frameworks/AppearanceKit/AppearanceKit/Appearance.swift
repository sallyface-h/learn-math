//
//  Appearance.swift
//  AppearanceKit_Example
//
//  Created by Jackie on 2024/7/17.
//  Copyright © 2024 3commas. All rights reserved.
//

import UIKit

public struct AppearanceX<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: AppearanceXProtocol {}

public protocol AppearanceXProtocol {}

extension AppearanceXProtocol {
    public var ap: AppearanceX<Self> {
        return AppearanceX(self)
    }

    public static var ap: AppearanceX<Self>.Type {
        return AppearanceX.self
    }
}

public extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

public struct Appearance {
    
    public static let screenBounds = CGRect(x: 0.0, y: 0.0, width: screenW, height: screenH)

    public static let screenW = UIScreen.main.bounds.width

    public static let screenH = UIScreen.main.bounds.height

    /// 使用计算型属性，不能使用存储型属性，这样可以让他每次都计算，而不会导致状态栏隐藏时，statusBarH返回0
    public static var statusBarH: CGFloat {
        return UIApplication.shared.windows.first(where: \.isKeyWindow)?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
    }

    public static let navigationBarH: CGFloat = 44.0

    public static var navigationH: CGFloat {
        return navigationBarH + statusBarH
    }

    public static let tabBarHeight: CGFloat = {
        let root = (UIWindow.key?.rootViewController as? UITabBarController)
        let tabBarH: CGFloat = root == nil ? 0.0 : 49.0
        return (safeBottomHeight != 0.0) ? (safeBottomHeight + tabBarH) : tabBarH
    }()

    public static var safeTopHeight: CGFloat {
        var safeTopSpacing: CGFloat = 0.0
        if let top = UIWindow.key?.safeAreaInsets.top, top != 0.0 {
            safeTopSpacing = top
        } else if let top = UIApplication.shared.windows.first?.safeAreaInsets.top, top != 0.0 {
            safeTopSpacing = top
        }
        return safeTopSpacing
    }

    public static var safeBottomHeight: CGFloat {
        var safeBottomSpacing: CGFloat = 0.0
        if let bottom = UIWindow.key?.safeAreaInsets.bottom, bottom != 0.0 {
            safeBottomSpacing = bottom
        } else if let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom, bottom != 0.0 {
            safeBottomSpacing = bottom
        }
        return safeBottomSpacing
    }

    /// 是否是全面屏/刘海屏
    public static var isFullScreen: Bool {
        return safeBottomHeight > 0
    }
    
}
