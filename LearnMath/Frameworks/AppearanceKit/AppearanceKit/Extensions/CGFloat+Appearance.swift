//
//  CGFloat+Egg.swift
//  EmperorKit_Example
//
//  Created by 黄杰 on 2021/3/11.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit

extension CGFloatProxy {

    public func rounded(_ decimalPlace: Int) -> CGFloat {
        let format = NSString(format: "%%.%if", decimalPlace)
        let string = NSString(format: format, base)
        return CGFloat(atof(string.utf8String))
    }

    /// 根据414宽度比例算出高度
    public func scale() -> CGFloat {
        return (Appearance.screenW * base) / 414.0
    }
}

public struct CGFloatProxy {

    public let base: CGFloat

    init(_ base: CGFloat) {
        self.base = base
    }
}

extension CGFloat {

    public var ap: CGFloatProxy {
        return CGFloatProxy(self)
    }

    public static var ap: CGFloatProxy.Type {
        return CGFloatProxy.self
    }
}
