//
//  MathAnswerSheetInputView.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <UIKit/UIKit.h>
#import "MathAnswerSheetInputCell.h"
#import "ArithmeticConstant.h"
@import AppearanceKit;
@import Masonry;
@class MathAnswerSheetInputItem;
@class MathAnswerSheetInputView;
NS_ASSUME_NONNULL_BEGIN

@protocol MathAnswerSheetInputViewDelegate <NSObject>

- (void)mathAnswerSheetInputView:(MathAnswerSheetInputView *)inputView didClickedOperationButton:(ScaleableButton *)btn item:(nullable MathAnswerSheetInputItem *)item;

@end

@interface MathAnswerSheetInputView : UIView

@property (nonatomic, weak) id<MathAnswerSheetInputViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
