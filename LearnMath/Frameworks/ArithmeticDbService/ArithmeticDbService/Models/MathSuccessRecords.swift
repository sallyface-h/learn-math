//
//  MathSuccessRecords.swift
//  ArithmeticDbService
//
//  Created by Jackie on 8/3/24.
//

import Foundation
import RealmSwift
import DbService

final public class MathSuccessRecords: Object, @unchecked Sendable, ObjectCapable {
    /// 对题id
    @Persisted(primaryKey: true) public var _id: String
    
    /// 答题本id
    @Persisted(indexed: true) public var workbookId: String
    
    /// 题目id
    @Persisted(indexed: true) public var questionId: String
    
    /// 分类id
    @Persisted(indexed: true) public var categoryId: String
    
    /// 技能id
    @Persisted(indexed: true) public var skillId: String
    
    /// 是否为训练
    @Persisted(indexed: true) public var style: MathWorkBooksStyle
    
    /// 对题创建时间
    @Persisted public var time: Int64 = 0
}
