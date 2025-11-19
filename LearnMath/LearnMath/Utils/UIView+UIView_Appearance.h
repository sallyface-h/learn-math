//
//  UIView+UIView_Appearance.h
//  LearnMath
//
//  Created by 基 on 2025/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, GradientDirection) {
    GradientDirectionTopToBottom,          // 从上到下
    GradientDirectionLeftToRight,          // 从左到右
    GradientDirectionTopLeftToBottomRight, // 从左上到右下
    GradientDirectionTopRightToBottomLeft  // 从右上到左下
};

@interface UIView (UIView_Appearance)
/**
 为视图应用渐变色
 
 @param colors 渐变颜色数组
 @param direction 渐变方向
 @param locations 颜色位置数组(可选)
 @param rect 渐变区域(可选，默认使用视图 bounds)
 @param cornerRadius 圆角半径(可选)
 */
- (void)applyGradientWithColors:(NSArray<UIColor *> *)colors
                      direction:(GradientDirection)direction
                      locations:(NSArray<NSNumber *> *)locations
                           rect:(CGRect)rect
                   cornerRadius:(CGFloat)cornerRadius;

// 简化版本，使用默认参数
- (void)applyGradientWithColors:(NSArray<UIColor *> *)colors
                      direction:(GradientDirection)direction;
- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius;
- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius rect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
