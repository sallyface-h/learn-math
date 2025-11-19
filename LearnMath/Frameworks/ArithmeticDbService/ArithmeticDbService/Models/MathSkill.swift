//
//  MathSkill.swift
//  ArithmeticDbService_Example
//
//  Created by Jackie on 7/23/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import RealmSwift
import DbService

final public class MathSkill: Object, @unchecked Sendable, ObjectCapable {
    /// 技巧id
    @Persisted(primaryKey: true) public var _id: String
    
    /// 技巧名称
    @Persisted public var name: String = ""
    
    /// 优先级
    @Persisted public var priority: Int64 = 0
    
    /// 分类id
    @Persisted(indexed: true) public var categoryId: String
    
    /// 教程链接
    @Persisted public var tutorialPath: String
    
    /// 训练次数
    @Persisted public var trainCount: Int64 = 0
    
    /// 是否隐藏
    @Persisted public var isHidden: Bool = false
    
    /// 描述
    @Persisted public var desc: String
}
