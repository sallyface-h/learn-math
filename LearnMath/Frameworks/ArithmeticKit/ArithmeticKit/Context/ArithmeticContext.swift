//
//  EmperorContext.swift
//  EmperorKit_Example
//
//  Created by Limon F. on 2/7/2020.
//  Copyright © 2020 3commas. All rights reserved.
//

import Foundation

public struct ArithmeticContext {

    public enum Environment: String {
        case debug
        case adHoc
        case enterprise
        case testFlight
        case release

        public static var value: Environment = .release
    }

    public enum Version {
        case `default`

        public static var value: Version {
            let bundleID = Bundle.main.bundleIdentifier ?? ""
            switch bundleID {
            default:
                return .default
            }
        }
    }

    public struct Configuration {
        /// 审核状态
        public static var adt: Bool = false
    }
}


