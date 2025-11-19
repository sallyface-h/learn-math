//
//  Image+Emperor.swift
//  EmperorKit_Example
//
//  Created by 3commas on 3/3/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit

public extension Arithmetic where Base: UIImage {

    static func image(_ name: String) -> UIImage? {
        return UIImage(named: name, in: Configurations.bundle, compatibleWith: nil)
    }
    
}
