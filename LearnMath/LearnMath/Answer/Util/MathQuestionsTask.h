//
//  MathQuestionsTask.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <Foundation/Foundation.h>
@class MathQuestions;
@class MathWorkBooks;
@class MathQuestionsGenerator;
NS_ASSUME_NONNULL_BEGIN

@interface MathQuestionsTask : NSObject

@property (nonatomic, strong, readonly) MathQuestions *question;
@property (nonatomic, strong, readonly) MathWorkBooks *workBook;
@property (nonatomic, assign, readonly) NSInteger taskIndex;

@property (nonatomic, assign, readonly) NSInteger retryCount;

@property (nonatomic, copy, nullable) void (^successCompletion)(void);
@property (nonatomic, copy, nullable) void (^progressCompletion)(CGFloat progress);
@property (nonatomic, copy, nullable) void (^failureCompletion)(void);
@property (nonatomic, copy, nullable) void (^showAnswerAction)(void);

- (instancetype)initWithQuestion:(MathQuestions *)question workBook:(MathWorkBooks *)workBook taskIndex:(NSInteger)taskIndex generator:(nullable MathQuestionsGenerator *)generator;

- (void)success;

- (void)failure;
@end

NS_ASSUME_NONNULL_END
