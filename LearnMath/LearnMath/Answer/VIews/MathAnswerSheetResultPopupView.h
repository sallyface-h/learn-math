//
//  MathAnswerSheetResultPopupView.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <UIKit/UIKit.h>
@import Masonry;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MathAnswerSheetResult) {
    MathAnswerSheetResultCorrect,
    MathAnswerSheetResultWrong
};

@interface MathAnswerSheetResultPopupView : UIView
- (instancetype)initWithResult:(MathAnswerSheetResult)result frame:(CGRect)frame;

- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
