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

    fileprivate static var localizedBundle: Bundle? = {
        let currentLanguage = UserDefaults.standard.string(forKey: "Parrot.LocalizeCurrentLanguage") ?? "ja"
        let parrotBundle = Bundle(url: Bundle.main.bundleURL.appendingPathComponent("Parrot.bundle"))
        if let path = parrotBundle?.path(forResource: currentLanguage, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle
        }
        return nil
    }()
}

extension String {

    var localized: String {
        let localized = Configurations.localizedBundle?.localizedString(forKey: self, value: nil, table: "Framework")
        if let result = localized, result != self {
            return result
        }
        return self
    }
}
