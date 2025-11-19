//
//  AppStoreKit.swift
//  Alamofire
//
//  Created by Jackie on 8/18/24.
//

import Foundation

public struct AppStoreKit {
    
    /// 音效是否关闭
    public static func soundEffectsDisable(_ disable: Bool) {
        UserDefaults.standard.setValue(disable, forKey: "kSoundEffectsDisable")
        UserDefaults.standard.synchronize()
    }
    
    /// 获取音效是否关闭
    public static func isSoundEffectsDisable() -> Bool {
        return UserDefaults.standard.bool(forKey: "kSoundEffectsDisable")
    }
    
    /// 振动是否关闭
    public static func hapticsDisable(_ disable: Bool) {
        UserDefaults.standard.setValue(disable, forKey: "kHapticsDisable")
        UserDefaults.standard.synchronize()
    }
    
    /// 获取振动是否关闭
    public static func isHapticsDisable() -> Bool {
        return UserDefaults.standard.bool(forKey: "kHapticsDisable")
    }
    
    /// 设置展示过appstore弹窗
    public static func appStoreCommentAlertShowed(_ showed: Bool) {
        UserDefaults.standard.setValue(showed, forKey: "kAppStoreCommentAlertShowed")
        UserDefaults.standard.synchronize()
    }
    
    /// 是否展示过appstore弹窗
    public static func isAppStoreCommentAlertShowed() -> Bool {
        return UserDefaults.standard.bool(forKey: "kAppStoreCommentAlertShowed")
    }
    
    /// 记录第一次跳过订阅的时间
    public static func setSkipAppPurchaseTime(_ time: TimeInterval) {
        UserDefaults.standard.setValue(time, forKey: "kSkipAppPurchaseTime")
        UserDefaults.standard.synchronize()
    }
    
    /// 第一次跳过订阅的时间
    public static func skipAppPurchaseTime() -> TimeInterval {
        return UserDefaults.standard.double(forKey: "kSkipAppPurchaseTime")
    }
    
    /// 设置技巧预览是否已经播放
    public static func setSkillPreviewIsShow(_ isShow: Bool, skillId: String) {
        UserDefaults.standard.setValue(isShow, forKey: "kSkillPreviewIsShow-\(skillId)")
        UserDefaults.standard.synchronize()
    }
    
    /// 技巧预览是否已经播放
    public static func skillPreviewIsShow(skillId: String) -> Bool {
        return UserDefaults.standard.bool(forKey: "kSkillPreviewIsShow-\(skillId)")
    }
    
}
