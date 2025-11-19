//
//  UIFont+UIFont_Appearance.m
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import "UIFont+UIFont_Appearance.h"

@implementation UIFont (UIFont_Appearance)
+ (UIFont *)ap_poppins:(CGFloat)size weight:(UIFontWeight)weight {
    NSString *fontName = @"Poppins-Regular";
    
    if (fabs(weight - UIFontWeightBold) < DBL_EPSILON) {
        fontName = @"Poppins-Bold";
    } else if (fabs(weight - UIFontWeightMedium) < DBL_EPSILON) {
        fontName = @"Poppins-Medium";
    }
    return [self ap_fontWithName:fontName size:size weight:weight];
}

+ (UIFont *)ap_baloo:(CGFloat)size weight:(UIFontWeight)weight {
    NSString *fontName = @"Baloo";
    return [self ap_fontWithName:fontName size:size weight:weight];
}

+ (UIFont *)ap_yuanti:(CGFloat)size weight:(UIFontWeight)weight {
    NSString *fontName = @"Yuanti-SC-Regular";
    return [self ap_fontWithName:fontName size:size weight:weight];
}

+ (UIFont *)ap_din:(CGFloat)size weight:(UIFontWeight)weight {
    NSString *fontName = (weight > UIFontWeightRegular)
        ? @"DINAlternate-Bold"
        : @"DIN Alternate";
    return [self ap_fontWithName:fontName size:size weight:weight];
}

+ (UIFont *)ap_font:(CGFloat)size weight:(UIFontWeight)weight {
    return [UIFont systemFontOfSize:size weight:weight];
}

#pragma mark - Private
+ (UIFont *)ap_fontWithName:(NSString *)fontName size:(CGFloat)size weight:(UIFontWeight)weight {
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size weight:weight];
#ifdef DEBUG
        NSLog(@"⚠️ Font not found: %@, fallback to system font", fontName);
#endif
    }
    return font;
}

@end
