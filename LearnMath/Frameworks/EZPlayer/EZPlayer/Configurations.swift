//
//  EmperorNavigationController.swift
//  EmperorNavigationController_Example
//
//  Created by 黄杰 on 2019/4/11.
//  Copyright © 2019 3commas. All rights reserved.
//

import UIKit

class Empty {}

public struct Configurations {
    
    public static var bundle: Bundle {
        let classBundle = Bundle(for: Empty.self)
        let module = NSStringFromClass(Empty.self).components(separatedBy: ".").first ?? ""
        if let bundleURL = classBundle.url(forResource: module, withExtension: "bundle") {
            return Bundle(url: bundleURL) ?? classBundle
        } else {
            return classBundle
        }
    }
    
}
