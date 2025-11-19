//
//  MathQuestionsTask.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathQuestionsTask.h"
#import "MathQuestionsGenerator.h"
#import "MathWorkBooks.h"
#import "MathQuestions.h"
@interface MathQuestionsTask ()
@property (nonatomic, weak) MathQuestionsGenerator *generator;

@end

@implementation MathQuestionsTask
- (instancetype)initWithQuestion:(MathQuestions *)question
                        workBook:(MathWorkBooks *)workBook
                       taskIndex:(NSInteger)taskIndex
                       generator:(MathQuestionsGenerator *)generator {
    if (self = [super init]) {
        _question = question;
        _workBook = workBook;
        _taskIndex = taskIndex;
        _generator = generator;
    }
    return self;
}

- (NSInteger)retryCount {
    return self.generator.retryCount;
}

- (void)success {
    [self.generator recordSuccessQuestion:self];
    if (self.successCompletion) self.successCompletion();
    [self.generator next];
}

- (void)failure {

    [self.generator recordFailureQuestion:self];
    [self.generator reduceCount];
    if (self.failureCompletion) self.failureCompletion();
    
    if (self.workBook.isTrain) {
        if (self.showAnswerAction) self.showAnswerAction();
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf= weakSelf;
            [strongSelf.generator next];
        });
    } else {
        [self.generator next];
    }
}
@end

