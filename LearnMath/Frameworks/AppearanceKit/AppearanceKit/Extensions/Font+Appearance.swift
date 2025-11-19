//
//  UIFont+Egg.swift
//  EggKit_Example
//
//  Created by Limon F. on 21/12/2017.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

extension AppearanceX where Base: UIFont {
    
    public static func convertPxFontSizeToPtFontSize(_ pxFontSize: CGFloat, isRawScaled: Bool = false) -> CGFloat {
        return pxFontSize//isRawScaled ? pxFontSize.egg.rawScaled : pxFontSize.egg.plusScaled
    }
    
    public static func font(ofSize pxFontSize: CGFloat, weight: UIFont.Weight = .regular, isRawScaled: Bool = false) -> UIFont {
        let ptFontSize = convertPxFontSizeToPtFontSize(pxFontSize, isRawScaled: isRawScaled)
        return UIFont.systemFont(ofSize: ptFontSize, weight: weight)
    }
    
    /// DIN Condensed （系统自带的 DIN）
    private static func din(ofSize pxFontSize: CGFloat, weight: UIFont.Weight = .regular, isRawScaled: Bool = false) -> UIFont {
        let ptFontSize = convertPxFontSizeToPtFontSize(pxFontSize, isRawScaled: isRawScaled)
        if weight.rawValue > UIFont.Weight.regular.rawValue {
            return UIFont(name: "DINAlternate-Bold", size: ptFontSize) ?? UIFont.systemFont(ofSize: ptFontSize, weight: weight)
        }
        return UIFont(name: "DIN Alternate", size: ptFontSize) ?? UIFont.systemFont(ofSize: ptFontSize, weight: weight)
    }
    
    /// Yuanti（手动添加进来的 DIN 字体，通过 FontBlaster 动态加载）
    public static func yuanti(ofSize pxFontSize: CGFloat, weight: UIFont.Weight = .regular, isRawScaled: Bool = false) -> UIFont {
        let ptFontSize = convertPxFontSizeToPtFontSize(pxFontSize, isRawScaled: isRawScaled)
        return UIFont.systemFont(ofSize: ptFontSize, weight: weight)

//        let customDinName: String
//
//        // DIN-Black.otf
//        // DIN-Bold.otf
//        // DIN-Medium.otf
//
//        switch weight {
//        case .ultraLight, .thin, .light, .regular:
//            customDinName = "DIN-Medium"
//        case .medium, .semibold, .bold:
//            customDinName = "DIN-Bold"
//        case .heavy, .black:
//            customDinName = "DIN-Black"
//        default:
//            customDinName = "DIN-Medium"
//        }
//
//        let ptFontSize = convertPxFontSizeToPtFontSize(pxFontSize, isRawScaled: isRawScaled)
//        return UIFont(name: customDinName, size: ptFontSize) ?? UIFont.systemFont(ofSize: ptFontSize, weight: weight)
    }
    
    /// Baloo字体
    public static func baloo(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        switch weight {
        case .regular:
            return UIFont(name: "Baloo", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
        default:
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
    
    /// Poppins字体
    public static func poppins(size: CGFloat, weight: UIFont.Weight = .bold) -> UIFont {
        switch weight {
        case .bold:
            return UIFont(name: "Poppins-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
        case .medium:
            return UIFont(name: "Poppins-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
        default:
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
    
}
