//
//  DbServiceable.swift
//  DbService_Example
//
//  Created by Jackie on 7/21/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import RealmSwift

public typealias DbServiceStartAction = (() -> Any?)

public protocol DbServiceable {
    /// 绑定版本
    func bindMigration<Block: Sendable>(_ dbName:String, schemaVersion: UInt64, startAction: DbServiceStartAction?, migrationBlock: Block?, complection: @escaping @Sendable (Result<Int, Error>) -> Void)
    
    /// 创建db
    @MainActor
    func create(_ objs: [any ObjectCapable]) async throws
    
    /// 更新db
    @MainActor
    func update(_ objs: [any ObjectCapable]) async throws
    
    /// 读取db
    @MainActor
    func fetchObj<T: NSObject>(_ type: T.Type, forPrimaryKey primaryKey: String?) async throws -> T?
    
    /// 读取db列表
    @MainActor
    func fetchList<T: ObjectCapable, R: RandomAccessCollection>(_ type: T.Type) async throws -> R?
    
    /// 删除db
    @MainActor
    func delete(_ objs: [any ObjectCapable]) async throws
    
    /// 事务处理
    @MainActor
    func transactions<Db>(_ acion: @escaping @Sendable (_ db: Db) -> Void) async throws
}
