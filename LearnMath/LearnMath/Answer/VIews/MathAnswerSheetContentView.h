//
//  MathAnswerSheetContentView.h
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIView+UIView_Appearance.h"
@class MathQuestionsTask;
@class MathAnswerSheetInputItem;
NS_ASSUME_NONNULL_BEGIN

@interface MathAnswerSheetContentView : UIView
- (instancetype)initWithBgColor:(nullable UIColor *)bgColor frame:(CGRect)frame;

/// 更新任务（带颜色与是否展示答案）
- (void)updateTask:(MathQuestionsTask *)task
           bgColor:(nullable UIColor *)bgColor
       isShowAnswer:(BOOL)isShowAnswer;

/// 更新任务（无颜色变化）
- (void)updateTask:(MathQuestionsTask *)task;

/// 接收输入项
- (void)receiveInputItem:(nullable MathAnswerSheetInputItem *)item;
@end

NS_ASSUME_NONNULL_END
