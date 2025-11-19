//
//  AppLifeCycle.swift
//  AppearanceKit_Example
//
//  Created by 3commas on 4/14/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import QTEventBus
import DbService
import RealmSwift
import AppToolKit

final class AppLifeCycle: NSObject, QTAppModule {

    static let shared: AppLifeCycle = AppLifeCycle()

    static func moduleInstance() -> QTAppModule {
        return AppLifeCycle.shared
    }

    func appDidFinishLaunch(_ event: QTAppDidLaunchEvent?) -> [AnyHashable: Any]? {
        
        // 启动数据库
        let migration: MigrationBlock = { migration, oldSchemaVersion in
        }
        
        DbService.shared.bindMigration("Arithmetic", schemaVersion: 19, startAction: {
            let defaultRealmUrl = Configurations.bundle.url(forResource: "Arithmetic", withExtension: "realm")
            return defaultRealmUrl
        }, migrationBlock: migration, complection: { result in
            switch result {
            case .success(let code):
                info_print(ArithmeticDbService.kLogTag, message: "初始化db成功", userInfo: ["code": code])
                // 清理数据
                Task { @MainActor in
                    try await ArithmeticCacheUtil.clearTrainCache()
                }
            case .failure(let error):
                info_print(ArithmeticDbService.kLogTag, message: "初始化db错误", error: error)
            }
        })

        return [:]
    }

}
