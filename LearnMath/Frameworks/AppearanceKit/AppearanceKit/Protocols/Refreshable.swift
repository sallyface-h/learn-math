//
//  Refreshable.swift
//  EmperorKit_Example
//
//  Created by 3commas on 2/24/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit

public protocol Refreshable {

    func refresh()

    var isAtTop: Bool { get }

    var currentOffsetY: CGFloat { get }

    func scrollsToTopIfNeeded(otherwise: (() -> Void)?)
}

extension Refreshable {

    public var isAtTop: Bool {
        return true
    }

    public var currentOffsetY: CGFloat {
        return 0.0
    }

    public func scrollsToTopIfNeeded(otherwise: (() -> Void)?) {}
}

