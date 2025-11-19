//
//  MathCategory.swift
//  ArithmeticDbService_Example
//
//  Created by Jackie on 7/23/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import RealmSwift
import DbService

final public class MathCategory: Object, @unchecked Sendable, ObjectCapable {
    /// 分类id
    @Persisted(primaryKey: true) public var _id: String
    
    /// 分类名称
    @Persisted public var name: String = ""
    
    /// 优先级
    @Persisted public var priority: Int64 = 0
}
