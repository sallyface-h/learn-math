//
//  ObjectWrapper.swift
//  DbService_Example
//
//  Created by Jackie on 7/21/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

public protocol ObjectCapable: Sendable & RealmFetchable {
    var json: [String: Any] { get }
}

public extension ObjectCapable {
    var json: [String : Any] {
        return JSON(self).dictionaryObject ?? [:]
    }
}
