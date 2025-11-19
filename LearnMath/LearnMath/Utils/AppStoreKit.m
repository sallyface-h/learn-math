//
//  AppStoreKit.m
//  LearnMath
//
//  Created by 基 on 2025/11/10.
//

#import "AppStoreKit.h"

@implementation AppStoreKit
+ (void)soundEffectsDisable:(BOOL)disable {
    [[NSUserDefaults standardUserDefaults] setBool:disable forKey:@"kSoundEffectsDisable"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isSoundEffectsDisable {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"kSoundEffectsDisable"];
}

+ (void)hapticsDisable:(BOOL)disable {
    [[NSUserDefaults standardUserDefaults] setBool:disable forKey:@"kHapticsDisable"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isHapticsDisable {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"kHapticsDisable"];
}

+ (void)appStoreCommentAlertShowed:(BOOL)showed {
    [[NSUserDefaults standardUserDefaults] setBool:showed forKey:@"kAppStoreCommentAlertShowed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isAppStoreCommentAlertShowed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"kAppStoreCommentAlertShowed"];
}

+ (void)setSkipAppPurchaseTime:(NSTimeInterval)time {
    [[NSUserDefaults standardUserDefaults] setDouble:time forKey:@"kSkipAppPurchaseTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSTimeInterval)skipAppPurchaseTime {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:@"kSkipAppPurchaseTime"];
}

+ (void)setSkillPreviewIsShow:(BOOL)isShow skillId:(NSString *)skillId {
    NSString *key = [NSString stringWithFormat:@"kSkillPreviewIsShow-%@", skillId];
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)skillPreviewIsShow:(NSString *)skillId {
    NSString *key = [NSString stringWithFormat:@"kSkillPreviewIsShow-%@", skillId];
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
