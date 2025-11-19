//
//  MathAnswerSheetNavView.h
//  LearnMath
//
//  Created by 基 on 2025/10/29.
//

#import <UIKit/UIKit.h>
#import "MathWorkBooks.h"
#import "MathWorkBooksViewModel.h"
@class MathQuestionsTask;
@class MathAnswerSheetNavView;
@class MathAnswerSheetEntry;
@class MathAnswerSheetMode;
@import ArithmeticKit;

NS_ASSUME_NONNULL_BEGIN
@protocol MathAnswerSheetNavViewDelegate <NSObject>
- (void)mathAnswerSheetNavView:(MathAnswerSheetNavView *)navView
 didClickedTutorialViewAction:(UIView *)sender
                         task:(MathQuestionsTask * _Nullable)task;

/// 点击了返回
- (void)mathAnswerSheetNavView:(MathAnswerSheetNavView *)navView
          didClickedBackAction:(BaseBackButton *)sender;

@end

@interface MathAnswerSheetNavView : UIView

@property (nonatomic, weak) id<MathAnswerSheetNavViewDelegate> delegate;

- (instancetype)initWithEntry:(MathAnswerSheetEntry *)entry;
- (void)updateTask:(MathQuestionsTask *)task;
- (void)hitContentView;

@end

NS_ASSUME_NONNULL_END
