//
//  UIColor+Egg.swift
//  EggKit
//
//  Created by k on 09/11/2016.
//  Copyright © 2016 egg. All rights reserved.
//

import UIKit

public protocol ColorSet {
    var lightColor: String { get }
    var darkColor: String { get }
}

extension AppearanceX where Base: UIColor {
 
    /// 颜色
    /// - Parameters:
    ///   - colorSet: 颜色类型
    ///   - alpha:    是否透明
    ///   - autoDark: 是否跟随系统暗黑模式（为true时，isDark无效）
    ///   - isDark:   是否返回暗色
    /// - Returns: 返回颜色
    public static func color(_ colorSet: ColorSet, alpha: Float = 1.0, autoDark: Bool = false, isDark: Bool = false) -> UIColor? {
        if #available(iOS 13.0, *), autoDark {
            return UIColor { collection -> UIColor in
                if collection.userInterfaceStyle == .dark {
                    return UIColor(hexString: colorSet.darkColor, alpha: alpha) ?? .clear
                }
                return UIColor(hexString: colorSet.lightColor, alpha: alpha) ?? .clear
            }
        } else {
            if isDark {
                return UIColor(hexString: colorSet.darkColor, alpha: alpha) ?? .clear
            } else {
                return UIColor(hexString: colorSet.lightColor, alpha: alpha) ?? .clear
            }
        }
    }
}

extension UIColor {

    /**
     Create non-autoreleased color with in the given hex string and alpha.

     - parameter hexString: The hex string, with or without the hash character.
     - parameter alpha: The alpha value, a floating value between 0 and 1.
     - returns: A color with the given hex string and alpha.
     */
    public convenience init?(hexString: String, alpha: Float = 1.0) {
        var hex = hexString

        // Check for hash and remove the hash
        if hex.hasPrefix("#") {
            hex = hex.egg.substring(from: 1, to: hex.count)
        }

        if (hex.range(of: "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .regularExpression) != nil) {

            // Deal with 3 character Hex strings
            if hex.count == 3 {
                let redHex   = hex.egg.substring(from: 0, to: 1)
                let greenHex = hex.egg.substring(from: 1, to: 2)
                let blueHex  = hex.egg.substring(from: 2, to: 3)
                hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
            }

            let redHex   = hex.egg.substring(from: 0, to: 2)
            let greenHex = hex.egg.substring(from: 2, to: 4)
            let blueHex  = hex.egg.substring(from: 4, to: 6)

            var redInt:   UInt64 = 0
            var greenInt: UInt64 = 0
            var blueInt:  UInt64 = 0

            Scanner(string: redHex).scanHexInt64(&redInt)
            Scanner(string: greenHex).scanHexInt64(&greenInt)
            Scanner(string: blueHex).scanHexInt64(&blueInt)

            if #available(iOS 10.0, *) {
                self.init(displayP3Red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
            } else {
                // Fallback on earlier versions
                self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
            }

        } else {
            // Note:
            // The swift 1.1 compiler is currently unable to destroy partially initialized classes in all cases,
            // so it disallows formation of a situation where it would have to.  We consider this a bug to be fixed
            // in future releases, not a feature. -- Apple Forum
            self.init()
            return nil
        }
    }

    /**
     Create non-autoreleased color with in the given hex value and alpha

     - parameter hex: The hex value. For example: 0xff8942 (no quotation).
     - parameter alpha: The alpha value, a floating value between 0 and 1.
     - returns: color with the given hex value and alpha
     */
    public convenience init?(hex: Int, alpha: Float = 1.0) {
        var hexString = String(format: "%2X", hex)
        let leadingZerosString = String(repeating: "0", count: 6 - hexString.count)
        hexString = leadingZerosString + hexString
        self.init(hexString: hexString, alpha: alpha)
    }
}
