//
//  UIFont+UIFont_Appearance.h
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (UIFont_Appearance)
/// 把 px 转换为 pt (可以根据需要加缩放逻辑)
+ (CGFloat)convertPxFontSizeToPtFontSize:(CGFloat)pxFontSize isRawScaled:(BOOL)isRawScaled;

/// 系统字体
+ (UIFont *)fontOfSize:(CGFloat)pxFontSize weight:(UIFontWeight)weight isRawScaled:(BOOL)isRawScaled;

/// DIN Condensed 系统字体
+ (UIFont *)dinFontOfSize:(CGFloat)pxFontSize weight:(UIFontWeight)weight isRawScaled:(BOOL)isRawScaled;

/// Yuanti 自定义字体（需要手动导入字体）
+ (UIFont *)yuantiFontOfSize:(CGFloat)pxFontSize weight:(UIFontWeight)weight isRawScaled:(BOOL)isRawScaled;

/// Baloo 字体
+ (UIFont *)balooFontOfSize:(CGFloat)size weight:(UIFontWeight)weight;

/// Poppins 字体
+ (UIFont *)poppinsFontOfSize:(CGFloat)size weight:(UIFontWeight)weight;

@end

NS_ASSUME_NONNULL_END
