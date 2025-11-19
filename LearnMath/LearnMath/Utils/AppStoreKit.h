//
//  AppStoreKit.h
//  LearnMath
//
//  Created by 基 on 2025/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppStoreKit : NSObject
/// 音效是否关闭
+ (void)soundEffectsDisable:(BOOL)disable;
+ (BOOL)isSoundEffectsDisable;

/// 振动是否关闭
+ (void)hapticsDisable:(BOOL)disable;
+ (BOOL)isHapticsDisable;

/// 设置展示过 appstore 弹窗
+ (void)appStoreCommentAlertShowed:(BOOL)showed;
+ (BOOL)isAppStoreCommentAlertShowed;

/// 设置跳过订阅的时间
+ (void)setSkipAppPurchaseTime:(NSTimeInterval)time;
+ (NSTimeInterval)skipAppPurchaseTime;

/// 设置技巧预览是否已经播放
+ (void)setSkillPreviewIsShow:(BOOL)isShow skillId:(NSString *)skillId;
+ (BOOL)skillPreviewIsShow:(NSString *)skillId;
@end

NS_ASSUME_NONNULL_END
