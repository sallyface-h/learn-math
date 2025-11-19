//
//  RealmDbService.swift
//  DbService_Example
//
//  Created by Jackie on 7/21/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDbService: NSObject {
    
    private var realm: Realm?
    
    override init() {
        super.init()
    }
    
}

// MARK: - Private

private extension RealmDbService {
    
    func findDbPath(with dbName: String, defaultRealmAction: DbServiceStartAction?) -> (url: URL, isSeekFilePath: Bool)? {
        
        guard var dbLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
#if targetEnvironment(simulator)
        dbLocation = URL(fileURLWithPath: "/Users/a1-6/Desktop")
#endif
        
        if #available(iOS 16.0, *) {
            dbLocation.append(component: "Db/Realm")
        } else {
            dbLocation = dbLocation.appendingPathComponent("Db/Realm")
        }
        
        let addDbNameAction: ((URL) -> URL) = { location in
            var location = location
            if #available(iOS 16.0, *) {
                location.append(component: dbName + ".realm")
            } else {
                location = location.appendingPathComponent(dbName + ".realm")
            }
            return location
        }
        
        let useDefaultRealmAction: ((URL) -> (url: URL, isSeekFilePath: Bool)) = { location in
            if FileManager.default.fileExists(atPath: location.path) {
                // 如果文件已经存在，则直接返回
                return (url: location, isSeekFilePath: false)
            } else {
                // 从bundle copy一份
                if let defaultRealmAction = defaultRealmAction, let defaultRealmUrl = defaultRealmAction() as? URL, FileManager.default.fileExists(atPath: defaultRealmUrl.path) {
                    do {
                        try FileManager.default.copyItem(atPath: defaultRealmUrl.path, toPath: location.path)
                        return (url: location, isSeekFilePath: false)
                    } catch {
                        return (url: location, isSeekFilePath: false)
                    }
                } else {
                    return (url: location, isSeekFilePath: false)
                }
            }
        }
        
        if FileManager.default.fileExists(atPath: dbLocation.path) {
            let realmPath = addDbNameAction(dbLocation)
            return useDefaultRealmAction(realmPath)
        } else {
            // 不存在，则创建
            do {
                try FileManager.default.createDirectory(at: dbLocation, withIntermediateDirectories: true)
                let realmPath = addDbNameAction(dbLocation)
                return useDefaultRealmAction(realmPath)
            } catch {
                let realmPath = addDbNameAction(dbLocation)
                return useDefaultRealmAction(realmPath)
            }
        }
    }
    
}

// MARK: - DbServiceable

extension RealmDbService: DbServiceable {
    
    func bindMigration<Block: Sendable>(_ dbName:String, schemaVersion: UInt64, startAction: DbServiceStartAction?, migrationBlock: Block?, complection: @escaping @Sendable (Result<Int, Error>) -> Void) {
        guard let dbLocationTuple = findDbPath(with: dbName, defaultRealmAction: startAction) else {
            complection(.failure(DbServiceError.dbPathNotCorrect))
            return
        }
        do {
            var configuration = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: { migration, oldSchemaVersion in
                if let block = migrationBlock as? MigrationBlock {
                    block(migration, oldSchemaVersion)
                }
            }, deleteRealmIfMigrationNeeded: false)
            if dbLocationTuple.isSeekFilePath {
                configuration.fileURL = dbLocationTuple.url
            } else {
                configuration.fileURL = dbLocationTuple.url
            }
            let realm = try Realm(configuration: configuration)
            self.realm = realm
            complection(.success(0))
        } catch {
            complection(.failure(error))
        }
    }
    
    @MainActor
    public func create(_ objs: [any ObjectCapable]) async throws {
        guard !objs.isEmpty else {
            throw DbServiceError.paramsError
        }
        guard let realm = self.realm else {
            throw DbServiceError.realmNotExist
        }
        
        try await realm.asyncWrite {
            for obj in objs {
                if let entity = obj as? Object {
                    realm.add(entity)
                }
            }
        }
    }
    
    @MainActor
    public func update(_ objs: [any ObjectCapable]) async throws {
        guard !objs.isEmpty else {
            throw DbServiceError.paramsError
        }
        guard let realm = self.realm else {
            throw DbServiceError.realmNotExist
        }
        
        try await realm.asyncWrite {
            for obj in objs {
                if let entity = obj as? Object {
                    realm.add(entity, update: .modified)
                }
            }
        }
    }
    
    @MainActor
    func fetchObj<T: NSObject>(_ type: T.Type, forPrimaryKey primaryKey: String?) async throws -> T? {
        guard let realm = self.realm else {
            throw DbServiceError.realmNotExist
        }
        guard let type = type as? Object.Type else {
            throw DbServiceError.paramsError
        }
        
        let id = try ObjectId(string: primaryKey ?? "0")
        let obj = realm.object(ofType: type, forPrimaryKey: id)
        return obj as? T
    }
    
    @MainActor
    func fetchList<T: ObjectCapable, R: RandomAccessCollection>(_ type: T.Type) async throws -> R? {
        guard let realm = self.realm else {
            throw DbServiceError.realmNotExist
        }

        let list = realm.objects(type) as? R
        return list
    }
    
    @MainActor
    public func delete(_ objs: [any ObjectCapable]) async throws {
        guard !objs.isEmpty else {
            throw DbServiceError.paramsError
        }
        guard let realm = self.realm else {
            throw DbServiceError.realmNotExist
        }
        
        try await realm.asyncWrite {
            for obj in objs {
                if let entity = obj as? Object {
                    realm.delete(entity)
                }
            }
        }
    }
    
    @MainActor
    public func transactions<Db>(_ acion: @escaping @Sendable (_ db: Db) -> Void) async throws {
        guard let realm = self.realm else {
            throw DbServiceError.realmNotExist
        }
        
        try await realm.asyncWrite { [weak self] in
            if let r = self?.realm as? Db {
                acion(r)
            }
        }
    }
    
}
