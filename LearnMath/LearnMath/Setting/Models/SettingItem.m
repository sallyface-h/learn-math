//
//  SettingItem.m
//  LearnMath
//
//  Created by 基 on 2025/11/18.
//

#import "SettingItem.h"

@implementation SettingItem
- (instancetype)initWithType:(SettingItemType)type title:(NSString *)title subTitle:(nullable NSString *)subTitle isOn:(BOOL)isOn {
    if (self = [super init]) {
        self.type = type;
        self.title = title;
        self.subTitle = subTitle;
        self.isOn = isOn;
    }
    return self;
}
@end
