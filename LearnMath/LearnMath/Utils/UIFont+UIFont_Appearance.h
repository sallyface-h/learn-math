//
//  UIFont+UIFont_Appearance.h
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (UIFont_Appearance)
/// Poppins 字体
+ (UIFont *)ap_poppins:(CGFloat)size weight:(UIFontWeight)weight;

/// Baloo 字体
+ (UIFont *)ap_baloo:(CGFloat)size weight:(UIFontWeight)weight;

/// Yuanti 字体（系统默认）
+ (UIFont *)ap_yuanti:(CGFloat)size weight:(UIFontWeight)weight;

/// DIN 字体（系统自带）
+ (UIFont *)ap_din:(CGFloat)size weight:(UIFontWeight)weight;

/// 通用字体（fallback）
+ (UIFont *)ap_font:(CGFloat)size weight:(UIFontWeight)weight;


@end

NS_ASSUME_NONNULL_END
