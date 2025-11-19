//
//  MathAnswerSheetQuestionBaseView.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "MathAnswerSheetTextField.h"
#import "MathAnswerSheetInputItem.h"
#import "MathAnswerSheetResultPopupView.h"
#import "MathQuestionsTask.h"
#import "MathQuestionsGenerator.h"
#import "MathWorkBooks.h"
#import "MathQuestions.h"
#import "MathQuestionAnswer.h"
#import "ArithmeticDbService.h"
#import "AppStoreKit.h"
@class MathQuestionsTask;

NS_ASSUME_NONNULL_BEGIN

@interface MathAnswerSheetQuestionBaseView : UIView
@property (nonatomic, strong) NSMutableArray<MathAnswerSheetTextField *> *inputTextFields;
@property (nonatomic, strong) NSMutableArray<UITextField *> *lostFirstResponseTextFields;
@property (nonatomic, weak) MathAnswerSheetResultPopupView *resultPopupView;
@property (nonatomic, strong) MathQuestionsTask *task;
@property (nonatomic, assign) ArithmeticAlgorithmCategory category;
@property (nonatomic, assign) BOOL isShowAnswer;
@property (nonatomic, strong, nullable) UIColor *bgColor;
@property (nonatomic, strong) ArithmeticDbService *dbService;
- (instancetype)initWithTask:(MathQuestionsTask *)task
                    category:(ArithmeticAlgorithmCategory)category
                isShowAnswer:(BOOL)isShowAnswer
                     bgColor:(nullable UIColor *)bgColor
                       frame:(CGRect)frame;

/// 更新任务
- (void)updateTask:(MathQuestionsTask *)task;

/// 接收输入
- (void)receiveInputItem:(nullable MathAnswerSheetInputItem *)item;
- (void)receiveInputItem:(nullable MathAnswerSheetInputItem *)item firstResponder:(nullable MathAnswerSheetTextField *)firstResponder;

/// 检查按钮点击
- (void)check:(nullable MathAnswerSheetTextField *)firstResponder;

/// 清空输入框
- (void)clean:(nullable MathAnswerSheetTextField *)firstResponder;

/// 输入数字
- (void)input:(NSString *)number firstResponder:(nullable MathAnswerSheetTextField *)firstResponder;
@end

NS_ASSUME_NONNULL_END
