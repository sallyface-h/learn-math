//
//  Arithmetic.swift
//  ArithmeticKit_Example
//
//  Created by Jackie on 2024/7/17.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation

public struct Arithmetic<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: ArithmeticProtocol {}

public protocol ArithmeticProtocol {}

extension ArithmeticProtocol {
    public var em: Arithmetic<Self> {
        return Arithmetic(self)
    }

    public static var em: Arithmetic<Self>.Type {
        return Arithmetic.self
    }
}
