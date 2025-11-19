//
//  AppLifeCycle.swift
//  AppearanceKit_Example
//
//  Created by 3commas on 4/14/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import QTEventBus
import AppToolKit

final class AppLifeCycle: NSObject, QTAppModule {

    static let shared: AppLifeCycle = AppLifeCycle()

    static func moduleInstance() -> QTAppModule {
        return AppLifeCycle.shared
    }

    func appDidFinishLaunch(_ event: QTAppDidLaunchEvent?) -> [AnyHashable: Any]? {

        setupAppearance()

        let networkLoggerPrintAction: (Any) -> Void = { msg in
            networkLoggerPlugin_print("Network", message: msg)
        }

        let errorHUDFlashAction: (_ msg: String, _ error: Error) -> Void = { msg, error in
            FlasherViewHUD.flash(style: FlasherStyle.label(text: msg, title: nil))
            error_print("Error", message: msg, error: error)
        }

        return ["networkLoggerPrintAction": networkLoggerPrintAction, "errorHUDFlashAction": errorHUDFlashAction]
    }

}

extension AppLifeCycle {

    private func setupAppearance() {

        UIScrollView.appearance().contentInsetAdjustmentBehavior = .never

        // A Boolean value that determines whether shaking the device displays the undo-redo user interface.
        // 禁用摇晃手机撤销输入操作
        UIApplication.shared.applicationSupportsShakeToEdit = false

        // 防止多个按钮同时点击，push多次
        UIButton.appearance().isExclusiveTouch = true
    }

}
