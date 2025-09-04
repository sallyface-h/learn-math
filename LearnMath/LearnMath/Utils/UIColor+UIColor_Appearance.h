//
//  UIColor+UIColor_Appearance.h
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ColorSet)
{
    ColorSetWhite,
    ColorSetBlack,
    ColorSetMain,
    ColorSetTitle,
    ColorSetSubTitle,
    ColorSetBg,
    ColorSetDeepOrange,
    ColorSetOrange,
    ColorSetDeepBlue,
    ColorSetBlue,
    ColorSetGreen,
    ColorSetLightGreen,
    ColorSetPink,
    ColorSetDeepPink,
    ColorSetDeepPink2,
    ColorSetLightPink,
    ColorSetPurple,
    ColorSetShadow,
    ColorSetSkillBorder,
    ColorSetSkillShadow,
    ColorSetSkillTitle,
    ColorSetOptionsShadow,
    ColorSetHeaderSectionTitle,
    ColorSetBorderColor,
    ColorSetBorderShadow,
    ColorSetProgressBg,
    ColorSetScopeBg,
    ColorSetDeepRed,
    ColorSetGradient1,
    ColorSetGradient2,
    ColorSetGradient3,
    ColorSetGradient4,
    ColorSetLightYellow
};
@interface UIColor (UIColor_Appearance)
+ (UIColor *)colorForSet:(ColorSet)colorSet;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
