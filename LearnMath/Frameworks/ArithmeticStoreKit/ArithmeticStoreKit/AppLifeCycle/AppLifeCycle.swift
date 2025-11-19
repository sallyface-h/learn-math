//
//  AppLifeCycle.swift
//  AppearanceKit_Example
//
//  Created by 3commas on 4/14/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import QTEventBus
import RevenueCat
import ArithmeticKit
import AppToolKit
import AppStoreKit

final class AppLifeCycle: NSObject, QTAppModule {

    static let shared: AppLifeCycle = AppLifeCycle()

    static func moduleInstance() -> QTAppModule {
        return AppLifeCycle.shared
    }

    func appDidFinishLaunch(_ event: QTAppDidLaunchEvent?) -> [AnyHashable: Any]? {
        
        // 初始化
        if ArithmeticContext.Environment.value == .debug {
            Purchases.logLevel = .debug
        } else {
            Purchases.logLevel = .info
        }
        
        ArithmeticStore.shared.register()
        
        // 记录跳过订阅的时间
        let skipTime = AppStoreKit.skipAppPurchaseTime()
        if skipTime <= 0 {
            AppStoreKit.setSkipAppPurchaseTime(Date().timeIntervalSince1970)
        }
        
        Task {
            do {
                // 获取当前的用户状态
                _ = try await ArithmeticStore.shared.getCustomerInfo()
                // 优先缓存产品列表
                _ = try await ArithmeticStore.shared.fetchPackages()
            } catch {
                info_print(ArithmeticStore.TAG, message: "获取用户信息失败：\(error)")
            }
        }
        
        return nil
    }
}
