//
//  AppLifeCycle.swift
//  AppearanceKit_Example
//
//  Created by 3commas on 4/14/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import QTEventBus

final class AppLifeCycle: NSObject, QTAppModule {

    static let shared: AppLifeCycle = AppLifeCycle()

    static func moduleInstance() -> QTAppModule {
        return AppLifeCycle.shared
    }

    func appDidFinishLaunch(_ event: QTAppDidLaunchEvent?) -> [AnyHashable: Any]? {

        let main = event?.launchOptions?["main"] as? [String: Any] ?? [:]
        let environment = main["environment"] as? String ?? environmentKey

        environmentKey = environment

        setupLogger()
        
        // 注册音频
        SoundPlayer.shared.loadSound(type: .btnClick)
        SoundPlayer.shared.loadSound(type: .success)
        SoundPlayer.shared.loadSound(type: .wrong)

        return [:]
    }

}
