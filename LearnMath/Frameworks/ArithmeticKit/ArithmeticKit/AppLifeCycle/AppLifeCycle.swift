//
//  AppLifeCycle.swift
//  AppearanceKit_Example
//
//  Created by 3commas on 4/14/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import QTEventBus
import AppearanceKit
import ProgressHUD
import FirebaseCore
import FirebasePerformance
import FirebaseAnalytics

final class AppLifeCycle: NSObject, QTAppModule {

    static let shared: AppLifeCycle = AppLifeCycle()

    static func moduleInstance() -> QTAppModule {
        return AppLifeCycle.shared
    }

    func appDidFinishLaunch(_ event: QTAppDidLaunchEvent?) -> [AnyHashable: Any]? {

        guard let launchOptions = event?.launchOptions else { return nil }

        let main = launchOptions["main"] as? [String: Any] ?? [:]
        if let environment = main["environment"] as? String,
           let e = ArithmeticContext.Environment(rawValue: environment) {
            ArithmeticContext.Environment.value = e
        }
        
        // 设置hud样式
        ProgressHUD.colorBackground = UIColor.clear
        ProgressHUD.colorHUD = (UIColor.ap.color(ColorSet.black) ?? UIColor.black).withAlphaComponent(0.8)
        ProgressHUD.colorStatus = UIColor.ap.color(ColorSet.white) ?? UIColor.white
        ProgressHUD.fontStatus = UIFont.ap.poppins(size: 18.0)
        
        // 初始化firebase
        FirebaseApp.configure()
        
        // 开启性能监控
        if ArithmeticContext.Environment.value != .debug {
            Performance.sharedInstance().isDataCollectionEnabled = true
            Performance.sharedInstance().isInstrumentationEnabled = true
        }
        
        // 开启firebase埋点
        Analytics.setAnalyticsCollectionEnabled(true)
        
        return nil
    }
}
