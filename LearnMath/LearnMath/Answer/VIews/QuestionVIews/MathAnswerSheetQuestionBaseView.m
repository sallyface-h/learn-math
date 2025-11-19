//
//  MathAnswerSheetQuestionBaseView.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetQuestionBaseView.h"

@implementation MathAnswerSheetQuestionBaseView
- (instancetype)initWithTask:(MathQuestionsTask *)task
                    category:(ArithmeticAlgorithmCategory)category
                 isShowAnswer:(BOOL)isShowAnswer
                      bgColor:(UIColor *)bgColor
                        frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _task = task;
        _category = category;
        _isShowAnswer = isShowAnswer;
        _bgColor = bgColor;
        _inputTextFields = [NSMutableArray array];
        _lostFirstResponseTextFields = [NSMutableArray array];
        _dbService = [[ArithmeticDbService alloc] init];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateTask:task];
        });
    }
    return self;
}

- (void)updateTask:(MathQuestionsTask *)task {
    _task = task;
    
    __weak typeof(self) weakSelf = self;
    
    _task.successCompletion = ^{
        __strong typeof(weakSelf) selfStrong = weakSelf;
        [selfStrong.resultPopupView hide];
        
        MathAnswerSheetResultPopupView *popupView = [[MathAnswerSheetResultPopupView alloc] initWithResult:MathAnswerSheetResultCorrect
                                                                                                     frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
        [keyWindow addSubview:popupView];
        [popupView show];
        selfStrong.resultPopupView = popupView;
        
    /*    if (![AppStoreKit isSoundEffectsDisable]) {
            [[SoundPlayer shared] playSoundWithType:SoundPlayerTypeSuccess];
        }*/
    };
    
    _task.failureCompletion = ^{
        __strong typeof(weakSelf) selfStrong = weakSelf;
        [selfStrong.resultPopupView hide];
        
        MathAnswerSheetResultPopupView *popupView = [[MathAnswerSheetResultPopupView alloc] initWithResult:MathAnswerSheetResultWrong
                                                                                                     frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
        [keyWindow addSubview:popupView];
        [popupView show];
        selfStrong.resultPopupView = popupView;
        
     /*   if (![AppStoreKit isSoundEffectsDisable]) {
            [[SoundPlayer shared] playSoundWithType:SoundPlayerTypeWrong];
        }*/
    };
    
    _task.showAnswerAction = ^{
        __strong typeof(weakSelf) selfStrong = weakSelf;
        selfStrong.isShowAnswer = YES;
        if (selfStrong.task) {
            [selfStrong updateTask:selfStrong.task];
        }
    };
}

- (void)receiveInputItem:(MathAnswerSheetInputItem *)item {
    if (self.isShowAnswer) return;
    
    MathAnswerSheetTextField *firstResponder = nil;
    for (MathAnswerSheetTextField *tf in self.inputTextFields) {
        if (tf.isFirstResponder) {
            firstResponder = tf;
            break;
        }
    }
    
    if (firstResponder) {
        NSUInteger index = [self.lostFirstResponseTextFields indexOfObject:firstResponder];
        if (index != NSNotFound) {
            firstResponder.text = nil;
            [self.lostFirstResponseTextFields removeObjectAtIndex:index];
        }
    }
    
    switch (item.type) {
        case MathAnswerSheetInputTypeCheck:
            [self check:firstResponder];
            break;
        case MathAnswerSheetInputTypeClean:
            [self clean:firstResponder];
            break;
        case MathAnswerSheetInputTypeNumber: {
            NSString *preText = firstResponder.text ?: @"";
            NSString *finalText = [preText stringByAppendingString:item.number ?: @""];
            
            if (self.category.type == ArithmeticAlgorithmTypeMultiplication ||
                self.category.type == ArithmeticAlgorithmTypeDivision) {
                if (finalText.length >= 5) return;
            } else {
                if (finalText.length >= 4) return;
            }
            
            [self input:finalText firstResponder:firstResponder];
            break;
        }
        default:
            break;
    }
    
    [self receiveInputItem:item firstResponder:firstResponder];
}

- (void)receiveInputItem:(MathAnswerSheetInputItem *)item firstResponder:(MathAnswerSheetTextField *)firstResponder {
    // 子类可重写
}

- (void)check:(MathAnswerSheetTextField *)firstResponder {
    
}

- (void)clean:(MathAnswerSheetTextField *)firstResponder {
    // 子类可重写
}

- (void)input:(NSString *)number firstResponder:(MathAnswerSheetTextField *)firstResponder {
    // 子类可重写
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 可选实现
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.lostFirstResponseTextFields addObject:textField];
}


@end
