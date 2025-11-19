//
//  Dog.swift
//  DbService_Example
//
//  Created by Jackie on 7/21/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import RealmSwift

final class Dog: EmbeddedObject, @unchecked Sendable, ObjectCapable {
    @Persisted var name = ""
    @Persisted var age = 0
    @Persisted(originProperty: "dogs") var master: LinkingObjects<Person>
    
    var json: [String : Any] {
        return [:]
    }
}
