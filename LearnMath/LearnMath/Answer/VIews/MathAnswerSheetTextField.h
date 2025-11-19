//
//  MathAnswerSheetTextField.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@import AppearanceKit;
@import ArithmeticKit;
NS_ASSUME_NONNULL_BEGIN

@interface MathAnswerSheetTextField : UITextField
- (instancetype)initWithPadding:(UIEdgeInsets)padding bgColor:(nullable UIColor *)bgColor;

@end

NS_ASSUME_NONNULL_END
