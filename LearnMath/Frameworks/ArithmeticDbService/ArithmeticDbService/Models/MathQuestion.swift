//
//  MathQuestion.swift
//  ArithmeticDbService_Example
//
//  Created by Jackie on 7/23/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import RealmSwift
import DbService

final public class MathQuestion: Object, @unchecked Sendable, ObjectCapable {
    /// 题目id
    @Persisted(primaryKey: true) public var _id: String
    
    /// 分类id
    @Persisted(indexed: true) public var categoryId: String
    
    /// 技巧id
    @Persisted(indexed: true) public var skillId: String
    
    /// 题库id
    @Persisted(indexed: true) public var bankId: String
    
    /// 位数
    @Persisted(indexed: true) public var digits: Int64
    
    /// 生成的数字和答案
    @Persisted public var answer: MathQuestionAnswer?
    
    /// 题目创建时间
    @Persisted public var time: Int64 = 0
}

final public class MathQuestionAnswer: EmbeddedObject {
    /// 生成的数字
    @Persisted public var numbers: List<Int>
    
    /// 答案
    @Persisted public var answers: List<Int>
}
