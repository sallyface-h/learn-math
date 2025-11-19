//
//  MathAnswerSheetTimeView.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
@import Masonry;
@class MathQuestionsTask;
NS_ASSUME_NONNULL_BEGIN

@interface MathAnswerSheetTimeView : UIView
- (void)updateTask:(MathQuestionsTask *)task;
@end

NS_ASSUME_NONNULL_END
