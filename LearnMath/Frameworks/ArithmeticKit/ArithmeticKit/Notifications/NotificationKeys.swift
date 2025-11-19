//
//  NotificationKeys.swift
//  EmperorKit_Example
//
//  Created by 黄杰 on 2021/4/17.
//  Copyright © 2021 3commas. All rights reserved.
//

import Foundation

struct NotificationKeys {
    enum Keys: String {
        /// 进入教程
        case enterTutorial = "enterTutorial"
        /// 离开教程
        case leaveTutorial = "leaveTutorial"
    }
}

// MARK: - Chat

extension Notification.Name {
    /// 进入教程
    public static let enterTutorial = Notification.Name(NotificationKeys.Keys.enterTutorial.rawValue)
    
    /// 离开教程
    public static let leaveTutorial = Notification.Name(NotificationKeys.Keys.leaveTutorial.rawValue)
}
