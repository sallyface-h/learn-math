//
//  ArithmeticDbService.h
//  LearnMath
//
//  Created by 基 on 2025/11/4.
//

#import <Foundation/Foundation.h>
#import "ArithmeticConstant.h"
@class MathWorkBooks;
@class MathQuestions;
@class MathWorkSelectedTrainOptions;
@class MathWorkSelectedTestOptions;
@class MathSkills;
NS_ASSUME_NONNULL_BEGIN

@interface ArithmeticDbService : NSObject
+ (instancetype)sharedService;

/// 生成题目
- (MathQuestions *)generateQuestionWithCategoryId:(NSString *)categoryID
                                         skillId:(NSString *)skillID
                                          digits:(NSInteger)digits;

/// 保存题目
- (void)saveQuestion:(MathQuestions *)question;

/// 生成作业本
- (MathWorkBooks *)generateWorkBookWithQuestion:(MathQuestions *)question
                                          total:(NSInteger)total
                                          style:(NSString *)style
                           selectedTrainOptions:(MathWorkSelectedTrainOptions * _Nullable)selectedTrainOptions
                            selectedTestOptions:(MathWorkSelectedTestOptions * _Nullable)selectedTestOptions;

/// 更新作业本题目
- (void)updateWorkBook:(MathWorkBooks *)workBook withQuestion:(MathQuestions *)question;

/// 成功记录
- (void)generateSuccessRecordWithQuestionId:(NSString *)questionID
                                workbookId:(NSString *)workbookID
                                categoryId:(NSString *)categoryID
                                   skillId:(NSString *)skillID
                                     style:(NSString *)style;

/// 错误记录
- (void)generateErrorRecordWithQuestionId:(NSString *)questionID
                              workbookId:(NSString *)workbookID
                              categoryId:(NSString *)categoryID
                                 skillId:(NSString *)skillID
                                   style:(NSString *)style;

- (NSString *)fetchBankWithSkillID:(NSString *)skillID;
- (NSString *)fetchCategoryIDSkillID:(NSString *)skillID;
- (MathWorkBooks *)fetchWorkBookWithId:(NSString *)workbookID;
- (MathSkills *)fetchSkillWithSkillID:(NSString *)skillID;
- (void)updateSkillTrainCount:(NSString *)skillID trainCount:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
