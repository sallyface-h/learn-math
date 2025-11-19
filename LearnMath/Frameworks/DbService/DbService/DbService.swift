//
//  DbService.swift
//  DbService_Example
//
//  Created by Jackie on 7/21/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation

public class DbService: NSObject, @unchecked Sendable {
    
    public static let shared: DbService = DbService()
    
    private var service: DbServiceable?
    
    private override init() {
        super.init()
        
        generateService()
    }
}

// MARK: - Private

private extension DbService {
    
    func generateService() {
        service = DbFactory.createService(.realm)
    }
    
}

// MARK: - DbServiceable

extension DbService: DbServiceable {
    
    /// 绑定版本
    public func bindMigration<Block: Sendable>(_ dbName:String, schemaVersion: UInt64, startAction: DbServiceStartAction?, migrationBlock: Block?, complection: @escaping @Sendable (Result<Int, Error>) -> Void) {
        guard let service = self.service else {
            complection(.failure(DbServiceError.serviceNotExist))
            return
        }
        service.bindMigration(dbName, schemaVersion: schemaVersion, startAction: startAction, migrationBlock: migrationBlock, complection: complection)
    }
    
    /// 创建db
    @MainActor
    public func create(_ objs: [any ObjectCapable]) async throws {
        guard let service = self.service else {
            throw DbServiceError.serviceNotExist
        }
        try await service.create(objs)
    }
    
    /// 更新db
    @MainActor
    public func update(_ objs: [any ObjectCapable]) async throws {
        guard let service = self.service else {
            throw DbServiceError.serviceNotExist
        }
        try await service.update(objs)
    }
    
    /// 获取db
    @MainActor
    public func fetchObj<T: NSObject>(_ type: T.Type, forPrimaryKey primaryKey: String?) async throws -> T? {
        guard let service = self.service else {
            throw DbServiceError.serviceNotExist
        }
        return try await service.fetchObj(type, forPrimaryKey: primaryKey)
    }
    
    /// 获取db列表
    @MainActor
    public func fetchList<T: ObjectCapable, R: RandomAccessCollection>(_ type: T.Type) async throws -> R? {
        guard let service = self.service else {
            throw DbServiceError.serviceNotExist
        }
        return try await service.fetchList(type)
    }
    
    /// 删除db
    @MainActor
    public func delete(_ objs: [any ObjectCapable]) async throws {
        guard let service = self.service else {
            throw DbServiceError.serviceNotExist
        }
        try await service.delete(objs)
    }
    
    /// 事务处理
    @MainActor
    public func transactions<Db>(_ acion: @escaping @Sendable (_ db: Db) -> Void) async throws {
        guard let service = self.service else {
            throw DbServiceError.serviceNotExist
        }
        try await service.transactions(acion)
    }
    
}
