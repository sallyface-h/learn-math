//
//  ArithmeticTrackers.swift
//  AnalyticsTracker
//
//  Created by Jackie on 10/8/24.
//

import Foundation
import AnalyticsTracker

public enum ArithmeticTrackersCategoryOperation: String {
    /// 加法
    case add = "add"
    /// 减法
    case sub = "sub"
    /// 乘法
    case mul = "mul"
    /// 除法
    case div = "div"
}

public enum ArithmeticTrackersSubscriptionSource: String {
    /// 首页
    case index = "index"
    /// 技巧界面
    case tricks = "tricks"
}

public enum ArithmeticTrackersAnswerSource: String {
    /// 训练
    case trainning = "trainning"
    /// 测试
    case test = "test"
}

public enum ArithmeticTrackersAnswerPageType: String {
    /// 答题界面
    case problems = "problems"
    /// 引导界面
    case walkthrough = "walkthrough"
}

public struct ArithmeticTrackers {
    
    /// 获取category操作
    public static func getCategoryOperation(categoryId: String) -> ArithmeticTrackersCategoryOperation? {
        var operation: ArithmeticTrackersCategoryOperation?
        switch categoryId {
        case "57AA8010B8C94065AAAC14E9DA79EAC7":
            operation = .add
        case "853FC88B2E604EB5B1EE8A7364580278":
            operation = .sub
        case "01FF947894774BCAAF1F61A43608BE8F":
            operation = .mul
        case "8FD515C7776642BEB37CCA9A3D69C141":
            operation = .div
        default:
            break
        }
        return operation
    }
    
}

// MARK: - 页面曝光

public extension ArithmeticTrackers {
    
    /// 首页曝光
    static func homePageViewScreen() {
        AnalyticsTracker.logEvent(scene: .appViewScreen, parameters: [
            AnalyticsTracker.Field.exclusiveId: "AVS2024100701",
            AnalyticsTracker.Field.title: "index",
        ])
    }
    
    /// 技巧页曝光
    static func skillPageViewScreen(operation: ArithmeticTrackersCategoryOperation) {
        AnalyticsTracker.logEvent(scene: .appViewScreen, parameters: [
            AnalyticsTracker.Field.exclusiveId: "AVS2024100702",
            AnalyticsTracker.Field.title: "tricks",
            AnalyticsTracker.Field.operation: operation.rawValue,
        ])
    }
    
    /// 做题页曝光
    static func answerPageViewScreen(operation: ArithmeticTrackersCategoryOperation, skillName: String, pageType: ArithmeticTrackersAnswerPageType) {
        AnalyticsTracker.logEvent(scene: .appViewScreen, parameters: [
            AnalyticsTracker.Field.exclusiveId: "AVS2024100703",
            AnalyticsTracker.Field.title: "problems",
            AnalyticsTracker.Field.operation: operation.rawValue,
            AnalyticsTracker.Field.source: skillName,
            AnalyticsTracker.Field.pageType: pageType.rawValue
        ])
    }
    
    /// 订阅页曝光
    static func subscriptionPageViewScreen(source: ArithmeticTrackersSubscriptionSource) {
        AnalyticsTracker.logEvent(scene: .appViewScreen, parameters: [
            AnalyticsTracker.Field.exclusiveId: "AVS2024100704",
            AnalyticsTracker.Field.title: "plans",
            AnalyticsTracker.Field.source: source.rawValue,
        ])
    }
    
}

// MARK: - 元素点击

public extension ArithmeticTrackers {
    
    /// 点击了check按钮
    static func answerCheckButtonClick(operation: ArithmeticTrackersCategoryOperation, source: ArithmeticTrackersAnswerSource, skillName: String) {
        AnalyticsTracker.logEvent(scene: .appClick, parameters: [
            AnalyticsTracker.Field.exclusiveId: "AC2024100701",
            AnalyticsTracker.Field.elementName: "check",
            AnalyticsTracker.Field.title: skillName,
            AnalyticsTracker.Field.operation: operation.rawValue,
            AnalyticsTracker.Field.source: source.rawValue,
        ])
    }
    
    /// 点击了订阅按钮
    static func subscribeButtonClick(source: ArithmeticTrackersSubscriptionSource) {
        AnalyticsTracker.logEvent(scene: .appClick, parameters: [
            AnalyticsTracker.Field.exclusiveId: "AC2024100702",
            AnalyticsTracker.Field.elementName: "subscribe",
            AnalyticsTracker.Field.title: "订阅",
            AnalyticsTracker.Field.source: source.rawValue,
        ])
    }
    
    /// 引导页点击了try it
    static func tryItButtonClick(skillName: String, operation: ArithmeticTrackersCategoryOperation) {
        AnalyticsTracker.logEvent(scene: .appClick, parameters: [
            AnalyticsTracker.Field.exclusiveId: "AC2024101901",
            AnalyticsTracker.Field.elementName: "tryit",
            AnalyticsTracker.Field.title: skillName,
            AnalyticsTracker.Field.operation: operation.rawValue,
        ])
    }
    
}
