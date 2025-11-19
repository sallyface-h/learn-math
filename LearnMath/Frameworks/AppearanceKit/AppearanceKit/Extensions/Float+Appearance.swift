//
//  CGFloat+Egg.swift
//  EggKit
//
//  Created by Limon on 11/16/16.
//  Copyright © 2016 egg. All rights reserved.
//

import UIKit

extension FloatProxy {

    public func rounded(_ decimalPlace: Int) -> Float {
        let format = NSString(format: "%%.%if", decimalPlace)
        let string = NSString(format: format, base)
        return Float(atof(string.utf8String))
    }
    
    /// 根据375宽度比例算出高度
    public func scale() -> Float {
        return Float(CGFloat(base).ap.scale())
    }
}

public struct FloatProxy {

    public let base: Float

    init(_ base: Float) {
        self.base = base
    }
}

extension Float {

    public var egg: FloatProxy {
        return FloatProxy(self)
    }

    public static var egg: FloatProxy.Type {
        return FloatProxy.self
    }
}
