//
//  AnalyticsTracker.swift
//  AnalyticsTracker
//
//  Created by Jackie on 10/8/24.
//

import FirebaseAnalytics

public enum AnalyticsTrackerScene: String {
    /// 页面浏览
    case appViewScreen = "AppViewScreen"
    /// 元素点击
    case appClick = "AppClick"
}

public class AnalyticsTracker {
    
    public struct Field {
        public static let exclusiveId = "exclusive_id"
        public static let elementName = "element_name"
        public static let title = "title"
        public static let operation = "operation"
        public static let source = "source"
        public static let pageType = "page_type"
        static let deviceId = "device_id"
    }
    
    public static let shared = AnalyticsTracker()
    
    private init() {}
    
    /// 埋点
    public static func logEvent(scene: AnalyticsTrackerScene, parameters: [String: Any] = [:]) {
        var parameters = parameters
        addExtraData(params: &parameters)
        Analytics.logEvent(scene.rawValue, parameters: parameters)
    }
    
}

// MARK: - Private

private extension AnalyticsTracker {
    
    static func addExtraData(params: inout [String: Any]) {
//        params[Field.deviceId] = ""
    }
    
}
