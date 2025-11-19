//
//  SettingItem.h
//  LearnMath
//
//  Created by 基 on 2025/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, SettingItemType) {
    SettingItemTypeSoundEffects,
    SettingItemTypeHaptics,
    SettingItemTypeClearCache
};

@interface SettingItem : NSObject
@property (nonatomic, assign) SettingItemType type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) BOOL isOn;

- (instancetype)initWithType:(SettingItemType)type title:(NSString *)title subTitle:(nullable NSString *)subTitle isOn:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
