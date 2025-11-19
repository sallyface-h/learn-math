//
//  ArithmeticDbService.m
//  LearnMath
//
//  Created by 基 on 2025/11/4.
//

#import "ArithmeticDbService.h"
#import "MathWorkBooks.h"
#import "MathQuestions.h"
#import "MathSkills.h"
#import "ArithmeticAlgorithmUtil.h"
#import "FMDBManager.h"
#import "CategoryExchange.h"
#import "MathQuestionAnswer.h"
#import "MathWorkSelectedTrainOptions.h"
#import "MathWorkSelectedTestOptions.h"
@implementation ArithmeticDbService

+ (instancetype)sharedService
{
    static ArithmeticDbService *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[ArithmeticDbService alloc] init];
    });
    return service;
}

/// 生成题目
- (MathQuestions *)generateQuestionWithCategoryId:(NSString *)categoryID
                                         skillId:(NSString *)skillID
                                          digits:(NSInteger)digits
{
    NSString *bankID = [self fetchBankWithSkillID:skillID];
    MathQuestions *question = [[MathQuestions alloc] init];
    question.questionID = [[NSUUID UUID] UUIDString];
    question.categoryID = categoryID;
    question.skillID = skillID;
    question.digits = digits;
    question.bankID = bankID;
    question.time = (NSInteger)[[NSDate date] timeIntervalSince1970];
    
    ArithmeticAlgorithmCategory category = [CategoryExchange algorithmCategoryForBankID:bankID];
    NSDictionary *result = [ArithmeticAlgorithmUtil generateWithCategory:category digital:digits];
    if (result) {
        MathQuestionAnswer *answer = [[MathQuestionAnswer alloc] init];
        answer.numbers = [NSMutableArray arrayWithArray:result[@"numbers"]];
        answer.answers = [NSMutableArray arrayWithArray:result[@"answers"]];
        question.answer = answer;
    }
    
    return question;
}

/// 保存题目
- (void)saveQuestion:(MathQuestions *)question
{
    [[FMDBManager sharedManager] insertIntoTable:@"MathQuestion" members:@[@{
            @"QuestionID": question.questionID ?: @"",
            @"CategoryID": question.categoryID ?: @"",
            @"SkillID": question.skillID ?: @"",
            @"BankID": question.bankID ?: @"",
            @"Digits": @(question.digits),
            @"Time": @(question.time)
        }]];
}

/// 生成作业本
- (MathWorkBooks *)generateWorkBookWithQuestion:(MathQuestions *)question
                                          total:(NSInteger)total
                                          style:(NSString *)style
                           selectedTrainOptions:(MathWorkSelectedTrainOptions * _Nullable)selectedTrainOptions
                            selectedTestOptions:(MathWorkSelectedTestOptions * _Nullable)selectedTestOptions
{
    MathWorkBooks *workbook = [[MathWorkBooks alloc] init];
    workbook.bookID = [[NSUUID UUID] UUIDString];
    workbook.total = total;
    workbook.style = style;
    workbook.time = (long long)[[NSDate date] timeIntervalSince1970];
    workbook.questionID = question.questionID;
    workbook.selectedTestOptions = selectedTestOptions;
    workbook.selectedTrainOptions = selectedTrainOptions;

    NSString *trainOptions = @"";
       if (selectedTrainOptions) {
           NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[selectedTrainOptions toDictionary]
                                                              options:0
                                                                error:nil];
           if (jsonData) {
               trainOptions = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
           }
       }
       
       NSString *testOptions = @"";
       if (selectedTestOptions) {
           NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[selectedTestOptions toDictionary]
                                                              options:0
                                                                error:nil];
           if (jsonData) {
               testOptions = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
           }
       }
    
    [[FMDBManager sharedManager] insertIntoTable:@"MathWorkBooks" members:@[@{
        @"BookID": workbook.bookID,
        @"QuestionID": workbook.questionID,
        @"Total": @(workbook.total),
        @"Style": workbook.style,
        @"SelectedTrainOptions": trainOptions,
        @"SelectedTestOptions": testOptions,
        @"Time": @(workbook.time)
    }]];
    
    return workbook;
}

/// 更新作业本题目
- (void)updateWorkBook:(MathWorkBooks *)workBook withQuestion:(MathQuestions *)question
{
    
}

/// 成功记录
- (void)generateSuccessRecordWithQuestionId:(NSString *)questionID
                                workbookId:(NSString *)workbookID
                                categoryId:(NSString *)categoryID
                                   skillId:(NSString *)skillID
                                     style:(NSString *)style
{
    [[FMDBManager sharedManager] insertIntoTable:@"MathSuccessRecords" members:@[@{
            @"RecordID": [[NSUUID UUID] UUIDString],
            @"QuestionID": questionID ?: @"",
            @"BookID": workbookID ?: @"",
            @"CategoryID": categoryID ?: @"",
            @"SkillID": skillID ?: @"",
            @"Style": style ?: @"",
            @"Time": @((NSInteger)[[NSDate date] timeIntervalSince1970])
        }]];
}

/// 错误记录
- (void)generateErrorRecordWithQuestionId:(NSString *)questionID
                              workbookId:(NSString *)workbookID
                              categoryId:(NSString *)categoryID
                                 skillId:(NSString *)skillID
                                   style:(NSString *)style
{
    [[FMDBManager sharedManager] insertIntoTable:@"MathErrorRecords" members:@[@{
            @"RecordID": [[NSUUID UUID] UUIDString],
            @"QuestionID": questionID ?: @"",
            @"BookID": workbookID ?: @"",
            @"CategoryID": categoryID ?: @"",
            @"SkillID": skillID ?: @"",
            @"Style": style ?: @"",
            @"Time": @((NSInteger)[[NSDate date] timeIntervalSince1970])
        }]];
}

- (NSString *)fetchBankWithSkillID:(NSString *)skillID
{
    NSDictionary *dict = [[FMDBManager sharedManager] queryBankWithSkillID:skillID].firstObject;
    NSString *bankID = dict[@"BankID"];
    return bankID;
}

- (NSString *)fetchCategoryIDSkillID:(NSString *)skillID
{
    NSDictionary *dict = [[FMDBManager sharedManager] queryCategoryIDWithSkillID:skillID].firstObject;
    NSString *categoryID = dict[@"CategoryID"];
    return categoryID;
}

- (MathWorkBooks *)fetchWorkBookWithId:(NSString *)workbookID
{
    NSArray *results = [[FMDBManager sharedManager] queryTable:@"MathWorkBooks" columns:@[@"BookID",@"QuestionID",@"Total",@"Time",@"Style",@"SelectedTrainOptions",@"SelectedTestOptions"] where:@"BookID = ?" argument:@[workbookID] orderBy:nil];
    NSDictionary *dict = results.firstObject;
    if (!dict) return nil;
    MathWorkBooks *model = [[MathWorkBooks alloc] initWithDictionary:dict];
    return model;
}

- (MathSkills *)fetchSkillWithSkillID:(NSString *)skillID
{
    NSArray *result = [[FMDBManager sharedManager] queryTable:@"Skill" columns:@[@"SkillID",@"CategoryID",@"SkillName",@"TutorialPath",@"Priority",@"TrainCount"] where:@"SkillID = ?" argument:@[skillID] orderBy:nil];
    NSDictionary *dict = result.firstObject;
    if (!dict) return nil;
    MathSkills *model = [[MathSkills alloc] initWithDict:dict];
    return model;
}

- (void)updateSkillTrainCount:(NSString *)skillID trainCount:(NSInteger)count
{
    [[FMDBManager sharedManager] updateTable:@"Skill" set:@{@"TrainCount" : @(count)} where:@"SkillID = ?" arguments:@[skillID]];
}
@end
