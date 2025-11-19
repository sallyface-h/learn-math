//
//  AppLifeCycle.swift
//  AppearanceKit_Example
//
//  Created by 3commas on 4/14/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import QTEventBus
import AVFoundation
import AppToolKit

final class AppLifeCycle: NSObject, QTAppModule {

    static let shared: AppLifeCycle = AppLifeCycle()

    static func moduleInstance() -> QTAppModule {
        return AppLifeCycle.shared
    }

    func appDidFinishLaunch(_ event: QTAppDidLaunchEvent?) -> [AnyHashable: Any]? {

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
            try audioSession.setActive(true, options: [])
        } catch {
            info_print(ArithmeticPlayer.TAG, message: "Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        return nil
    }
}
