//
//  MathQuestionsGenerator.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <Foundation/Foundation.h>
#import "MathQuestionsTask.h"
#import "FMDBManager.h"
@class MathQuestions;
@class MathWorkBooks;
@class ArithmeticDbService;
@class MathAnswerSheetEntry;
@class MathAnswerSheetMode;
@import DbService;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MathQuestionsGeneratorError) {
    MathQuestionsGeneratorErrorSkillNotFound,
    MathQuestionsGeneratorErrorGenerateQuestionFailure,
    MathQuestionsGeneratorErrorGenerateWorkBookFailure,
    MathQuestionsGeneratorErrorUnknownEntry
};

@interface MathQuestionsGenerator : NSObject
@property (nonatomic, strong, readonly) MathAnswerSheetEntry *entry;
@property (nonatomic, strong) ArithmeticDbService *dbService;
@property (nonatomic, assign, readonly) NSInteger retryCount;

- (instancetype)initWithEntry:(MathAnswerSheetEntry *)entry
               nextTaskAction:(void(^)(MathQuestionsTask *task))nextTaskAction
              completedAction:(void(^)(MathQuestionsTask * _Nullable task))completedAction;

- (void)start;

- (void)stopTimer;

/// 生成题目（异步）
- (NSDictionary *)generateQuestion;

/// 记录对题
- (void)recordSuccessQuestion:(MathQuestionsTask *)task;

/// 记录错题
- (void)recordFailureQuestion:(MathQuestionsTask *)task;

/// 减少生存次数
- (void)reduceCount;

/// 继续下一题
- (void)next;

- (void)finishByUser;

@end

NS_ASSUME_NONNULL_END
