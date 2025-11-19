//
//  CGFloat+Arithmetic.swift
//  ArithmeticKit_Example
//
//  Created by Jackie on 7/28/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import UIKit
import AppearanceKit

public extension CGFloat {

    func scale() -> CGFloat {
        return self * (Appearance.screenH / 812.0)
    }
    
}

public extension Double {

    func scale() -> Double {
        return self * (Appearance.screenH / 812.0)
    }
    
}

