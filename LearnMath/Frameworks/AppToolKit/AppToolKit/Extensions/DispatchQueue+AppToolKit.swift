//
//  DispatchQueue+Egg.swift
//  EmperorKit_Example
//
//  Created by 3commas on 3/5/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import Foundation

extension AppToolKit where Base: DispatchQueue {
    // This method will dispatch the `block` to self.
    // If `self` is the main queue, and current thread is main thread, the block
    // will be invoked immediately instead of being dispatched.
    public func safeAsync(_ block: @escaping ()->()) {
        if base === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            base.async { block() }
        }
    }
}
