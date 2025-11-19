//
//  MathTestList.swift
//  ArithmeticDbService
//
//  Created by Jackie on 7/27/24.
//

import Foundation
import RealmSwift
import DbService

final public class MathTestList: Object, @unchecked Sendable, ObjectCapable {
    /// 测试清单id
    @Persisted(primaryKey: true) public var _id: String
    
    /// 测试范围
    @Persisted public var testRanges: Map<String, String>
    
    /// 位数
    @Persisted public var testDigits: Map<String, String>
    
    /// 模式
    @Persisted public var testModes: Map<String, String>
}

