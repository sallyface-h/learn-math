//
//  MathTrainList.swift
//  ArithmeticDbService
//
//  Created by Jackie on 7/27/24.
//

import Foundation
import RealmSwift
import DbService

final public class MathTrainList: Object, @unchecked Sendable, ObjectCapable {
    /// 训练清单id
    @Persisted(primaryKey: true) public var _id: String
    
    /// 位数
    @Persisted public var trainDigits: Map<String, String>
    
    /// 倒计时
    @Persisted public var trainCountdowns: Map<String, String>
}
