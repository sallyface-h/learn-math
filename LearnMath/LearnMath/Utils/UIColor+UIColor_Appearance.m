//
//  UIColor+UIColor_Appearance.m
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import "UIColor+UIColor_Appearance.h"

@implementation UIColor (UIColor_Appearance)
+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; 
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                           green:((rgbValue & 0x00FF00) >> 8) / 255.0
                            blue:(rgbValue & 0x0000FF) / 255.0
                           alpha:1.0];
}
+ (UIColor *)colorForSet:(ColorSet)colorSet
{
    NSString *hexString = nil;
        switch (colorSet) {
            case ColorSetWhite:
                hexString = @"#FFFFFF";
                break;
            case ColorSetBlack:
                hexString = @"#000000";
                break;
            case ColorSetMain:
                hexString = @"#FFFFFF";
                break;
            case ColorSetTitle:
                hexString = @"#FFFFFF";
                break;
            case ColorSetSubTitle:
                hexString = @"#666666";
                break;
            case ColorSetBg:
                hexString = @"#FFFFFF";
                break;
            case ColorSetDeepOrange:
                hexString = @"#FF7300";
                break;
            case ColorSetOrange:
                hexString = @"#FFAA00";
                break;
            case ColorSetDeepBlue:
                hexString = @"#325FFF";
                break;
            case ColorSetBlue:
                hexString = @"#32AAFF";
                break;
            case ColorSetGreen:
                hexString = @"#02873E";
                break;
            case ColorSetLightGreen:
                hexString = @"#21BC3A";
                break;
            case ColorSetPink:
                hexString = @"#DA6BEA";
                break;
            case ColorSetDeepPink:
                hexString = @"#DA76E9";
                break;
            case ColorSetDeepPink2:
                hexString = @"#FF6B78";
                break;
            case ColorSetLightPink:
                hexString = @"#FF86A3";
                break;
            case ColorSetPurple:
                hexString = @"#7175E5";
                break;
            case ColorSetShadow:
                hexString = @"#D7D9DB";
                break;
            case ColorSetSkillBorder:
                hexString = @"#E5E5E5";
                break;
            case ColorSetSkillShadow:
                hexString = @"#E3E7E9";
                break;
            case ColorSetSkillTitle:
                hexString = @"#2A405A";
                break;
            case ColorSetOptionsShadow:
                hexString = @"#E4E6E7";
                break;
            case ColorSetHeaderSectionTitle:
                hexString = @"#95A0AC";
                break;
            case ColorSetBorderColor:
                hexString = @"#F0F4F8";
                break;
            case ColorSetBorderShadow:
                hexString = @"#5A5EB7";
                break;
            case ColorSetProgressBg:
                hexString = @"#EAECEE";
                break;
            case ColorSetScopeBg:
                hexString = @"#F0F3F6";
                break;
            case ColorSetDeepRed:
                hexString = @"#FF4343";
                break;
            case ColorSetGradient1:
                hexString = @"#FFC42E";
                break;
            case ColorSetGradient2:
                hexString = @"#FFA788";
                break;
            case ColorSetGradient3:
                hexString = @"#FF77A4";
                break;
            case ColorSetGradient4:
                hexString = @"#FF78A3";
                break;
            case ColorSetLightYellow:
                hexString = @"#FFF7E7";
                break;
            default:
                hexString = @"#000000";
                break;
        }
        return [self colorWithHexString:hexString];
}
@end
