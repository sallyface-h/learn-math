//
//  UIFont+UIFont_Appearance.m
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import "UIFont+UIFont_Appearance.h"

@implementation UIFont (UIFont_Appearance)
+ (CGFloat)convertPxFontSizeToPtFontSize:(CGFloat)pxFontSize isRawScaled:(BOOL)isRawScaled {
    // 暂时直接返回 pxFontSize，后续你可以在这里加缩放逻辑
    return pxFontSize;
}

+ (UIFont *)fontOfSize:(CGFloat)pxFontSize weight:(UIFontWeight)weight isRawScaled:(BOOL)isRawScaled {
    CGFloat ptFontSize = [self convertPxFontSizeToPtFontSize:pxFontSize isRawScaled:isRawScaled];
    return [UIFont systemFontOfSize:ptFontSize weight:weight];
}

+ (UIFont *)dinFontOfSize:(CGFloat)pxFontSize weight:(UIFontWeight)weight isRawScaled:(BOOL)isRawScaled {
    CGFloat ptFontSize = [self convertPxFontSizeToPtFontSize:pxFontSize isRawScaled:isRawScaled];
    if (weight > UIFontWeightRegular) {
        return [UIFont fontWithName:@"DINAlternate-Bold" size:ptFontSize] ?: [UIFont systemFontOfSize:ptFontSize weight:weight];
    }
    return [UIFont fontWithName:@"DIN Alternate" size:ptFontSize] ?: [UIFont systemFontOfSize:ptFontSize weight:weight];
}

+ (UIFont *)yuantiFontOfSize:(CGFloat)pxFontSize weight:(UIFontWeight)weight isRawScaled:(BOOL)isRawScaled {
    CGFloat ptFontSize = [self convertPxFontSizeToPtFontSize:pxFontSize isRawScaled:isRawScaled];
    // 这里可以替换为你的字体文件名，例如 DIN-Medium / DIN-Bold / DIN-Black
    NSString *customFontName = @"DIN-Medium";

    if (weight >= UIFontWeightMedium && weight <= UIFontWeightBold) {
        customFontName = @"DIN-Bold";
    } else if (weight >= UIFontWeightHeavy) {
        customFontName = @"DIN-Black";
    }

    return [UIFont fontWithName:customFontName size:ptFontSize] ?: [UIFont systemFontOfSize:ptFontSize weight:weight];
}

+ (UIFont *)balooFontOfSize:(CGFloat)size weight:(UIFontWeight)weight {
    if (weight == UIFontWeightRegular) {
        return [UIFont fontWithName:@"Baloo" size:size] ?: [UIFont systemFontOfSize:size weight:weight];
    }
    return [UIFont systemFontOfSize:size weight:weight];
}

+ (UIFont *)poppinsFontOfSize:(CGFloat)size weight:(UIFontWeight)weight {
    if (weight == UIFontWeightBold) {
        return [UIFont fontWithName:@"Poppins-Bold" size:size] ?: [UIFont systemFontOfSize:size weight:weight];
    } else if (weight == UIFontWeightMedium) {
        return [UIFont fontWithName:@"Poppins-Medium" size:size] ?: [UIFont systemFontOfSize:size weight:weight];
    } else {
        return [UIFont systemFontOfSize:size weight:weight];
    }
}

@end
