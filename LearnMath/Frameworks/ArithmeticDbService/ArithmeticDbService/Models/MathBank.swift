//
//  MathBank.swift
//  ArithmeticDbService_Example
//
//  Created by Jackie on 7/23/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import RealmSwift
import DbService

final public class MathBank: Object, @unchecked Sendable, ObjectCapable {
    /// 题库id
    @Persisted(primaryKey: true) public var _id: String
    
    /// 题库名称
    @Persisted public var name: String
    
    /// 分类id
    @Persisted(indexed: true) public var categoryId: String
    
    /// 技巧id
    @Persisted(indexed: true) public var skillId: String
}
