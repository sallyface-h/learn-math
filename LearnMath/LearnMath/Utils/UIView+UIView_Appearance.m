//
//  UIView+UIView_Appearance.m
//  LearnMath
//
//  Created by 基 on 2025/10/13.
//

#import "UIView+UIView_Appearance.h"

@implementation UIView (UIView_Appearance)
- (void)applyGradientWithColors:(NSArray<UIColor *> *)colors
                      direction:(GradientDirection)direction
                      locations:(NSArray<NSNumber *> *)locations
                           rect:(CGRect)rect
                   cornerRadius:(CGFloat)cornerRadius {
    // 移除已存在的渐变层
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAGradientLayer class]]) {
            [obj removeFromSuperlayer];
        }
    }];
    
    // 创建渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    // 设置渐变区域，默认使用视图 bounds
    gradientLayer.frame = CGRectIsEmpty(rect) ? self.bounds : rect;
    
    // 转换UIColor数组为CGColor数组
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    gradientLayer.colors = cgColors;
    
    // 设置颜色位置
    if (locations.count > 0) {
        gradientLayer.locations = locations;
    }
    
    // 设置圆角
    gradientLayer.cornerRadius = cornerRadius;
    
    // 设置渐变方向
    switch (direction) {
        case GradientDirectionTopToBottom:
            gradientLayer.startPoint = CGPointMake(0.5, 0);
            gradientLayer.endPoint = CGPointMake(0.5, 1);
            break;
        case GradientDirectionLeftToRight:
            gradientLayer.startPoint = CGPointMake(0, 0.5);
            gradientLayer.endPoint = CGPointMake(1, 0.5);
            break;
        case GradientDirectionTopLeftToBottomRight:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 1);
            break;
        case GradientDirectionTopRightToBottomLeft:
            gradientLayer.startPoint = CGPointMake(1, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
            break;
    }
    
    // 添加渐变层到最底层
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

// 简化版本，使用默认参数
- (void)applyGradientWithColors:(NSArray<UIColor *> *)colors
                      direction:(GradientDirection)direction {
    [self applyGradientWithColors:colors
                        direction:direction
                        locations:nil
                             rect:CGRectZero
                     cornerRadius:0.0];
}

- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius rect:(CGRect)rect {
    CGRect targetRect = CGRectIsEmpty(rect) ? self.bounds : rect;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    [self roundCorners:corners radius:radius rect:CGRectZero];
}
@end
