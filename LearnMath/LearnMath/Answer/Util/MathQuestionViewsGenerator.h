//
//  MathQuestionViewsGenerator.h
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CategoryExchange.h"
@class MathQuestionsTask;
@class MathAnswerSheetQuestionBaseView;
NS_ASSUME_NONNULL_BEGIN

@interface MathQuestionViewsGenerator : NSObject
+ (nullable MathAnswerSheetQuestionBaseView *)generateWithTask:(MathQuestionsTask *)task
                                                       bgColor:(nullable UIColor *)bgColor
                                                  isShowAnswer:(BOOL)isShowAnswer
                                                         frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
