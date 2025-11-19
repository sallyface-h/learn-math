//
//  AppToolKit.swift
//  AppToolKit_Example
//
//  Created by Jackie on 2024/7/17.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation

public struct AppToolKit<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: AppToolKitProtocol {}

public protocol AppToolKitProtocol {}

extension AppToolKitProtocol {
    public var atk: AppToolKit<Self> {
        return AppToolKit(self)
    }

    public static var atk: AppToolKit<Self>.Type {
        return AppToolKit.self
    }
}
