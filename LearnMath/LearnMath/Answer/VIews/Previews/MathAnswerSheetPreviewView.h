//
//  MathAnswerSheetPreviewView.h
//  LearnMath
//
//  Created by 基 on 2025/10/21.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathAnswerSheetPreviewImages.h"
#import "MathAnswerSheetPreviewViewModel.h"
@import ArithmeticKit;
@import AppearanceKit;
@import Masonry;
@class MathAnswerSheetPreviewView;
NS_ASSUME_NONNULL_BEGIN

@protocol MathAnswerSheetPreviewViewDelegate <NSObject>
- (void)mathAnswerSheetPreviewView:(MathAnswerSheetPreviewView *)mathAnswerSheetPreviewView didClickedBackAction:(BaseBackButton *)sender;

- (void)mathAnswerSheetPreviewView:(MathAnswerSheetPreviewView *)finishedMathAnswerSheetPreviewView skillID:(NSString *)skillID;
@end

@interface MathAnswerSheetPreviewView : UIView

@property (nonatomic, weak) id<MathAnswerSheetPreviewViewDelegate> delegate;

- (instancetype)initWithTrainSkillId:(NSString *)trainSkillId navBarView:(UIView * _Nullable)navBarView;

@end

NS_ASSUME_NONNULL_END
