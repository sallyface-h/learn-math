//
//  MathWorkBooks.swift
//  ArithmeticDbService
//
//  Created by Jackie on 7/27/24.
//

import Foundation
import RealmSwift
import DbService

public enum MathWorkBooksStyle: String, PersistableEnum {
    /// 训练
    case train = "train"
    /// 测试
    case test = "test"
}

final public class MathWorkBooks: Object, @unchecked Sendable, ObjectCapable {
    /// 答题本id
    @Persisted(primaryKey: true) public var _id: String
    
    /// 题目id集合
    @Persisted public var questionIds: List<String>
    
    /// 题目总数
    @Persisted public var total: Int64 = 0
    
    /// 是否为训练
    @Persisted(indexed: true) public var style: MathWorkBooksStyle
    
    /// 训练选项
    @Persisted public var selectedTrainOptions: MathWorkSelectedTrainOptions?
    
    /// 测试选项
    @Persisted public var selectedTestOptions: MathWorkSelectedTestOptions?
    
    /// 创建时间
    @Persisted public var time: Int64 = 0
}

final public class MathWorkSelectedTrainOptions: EmbeddedObject {
    /// 选择位数
    @Persisted public var trainDigitKey: String
    
    /// 选择倒计时
    @Persisted public var trainCountdownKey: String
    
    /// 训练技能
    @Persisted public var trainSkillId: String
}

final public class MathWorkSelectedTestOptions: EmbeddedObject {
    /// 测试范围
    @Persisted public var testRangeKey: String
    
    /// 测试类型
    @Persisted public var testCategoires: List<String>
    
    /// 测试技能
    @Persisted public var testSkills: List<String>
    
    /// 选择位数
    @Persisted public var testDigitKey: String
    
    /// 选择模式
    @Persisted public var testModeKey: String
}
