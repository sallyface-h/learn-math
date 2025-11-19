//
//  MathQuestions.m
//  LearnMath
//
//  Created by 基 on 2025/10/24.
//

#import "MathQuestions.h"
#import "MathWorkBooks.h"
#import "MathQuestionAnswer.h"
@implementation MathQuestions
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _questionID = dict[@"QuestionID"];
        _categoryID = dict[@"CategoryID"];
        _skillID = dict[@"SkillID"];
        _bankID = dict[@"BankID"];
        _digits = [dict[@"Digits"] integerValue];
        _time = [dict[@"Time"] longLongValue];
        
        NSDictionary *answerDict = dict[@"answer"];
        if ([answerDict isKindOfClass:[NSDictionary class]]) {
            _answer = [[MathQuestionAnswer alloc] initWithDictionary:answerDict];
        }
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

@end
