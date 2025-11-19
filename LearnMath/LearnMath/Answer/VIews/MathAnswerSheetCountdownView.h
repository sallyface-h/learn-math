//
//  MathAnswerSheetCountdownView.h
//  LearnMath
//
//  Created by 基 on 2025/10/23.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "UIView+UIView_Appearance.h"
@import Masonry;
@import AppearanceKit;

NS_ASSUME_NONNULL_BEGIN

@interface MathAnswerSheetCountdownView : UIView
@property (nonatomic, assign) CGFloat progress;

+ (CGFloat)width;
+ (CGFloat)height;

- (void)updateBgColor:(nullable UIColor *)bgColor;
@end

NS_ASSUME_NONNULL_END
