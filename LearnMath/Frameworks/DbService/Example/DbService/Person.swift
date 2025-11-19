//
//  Person.swift
//  DbService_Example
//
//  Created by Jackie on 7/21/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import RealmSwift

final class Person: Object, @unchecked Sendable, ObjectCapable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = ""
    @Persisted var dogs: List<Dog>
    
    var json: [String : Any] {
        return [:]
    }
}
