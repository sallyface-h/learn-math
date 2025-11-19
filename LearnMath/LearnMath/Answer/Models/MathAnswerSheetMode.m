//
//  MathAnswerSheetMode.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetMode.h"

@implementation MathAnswerSheetMode
+ (instancetype)questionsLimit:(NSInteger)total {
    MathAnswerSheetMode *m = [[self alloc] init];
    m.type = MathAnswerSheetModeTypeQuestionsLimit;
    m.total = total;
    m.limitTime = 0;
    return m;
}

+ (instancetype)timeLimit:(NSTimeInterval)limitTime total:(NSInteger)total {
    MathAnswerSheetMode *m = [[self alloc] init];
    m.type = MathAnswerSheetModeTypeTimeLimit;
    m.limitTime = limitTime;
    m.total = total;
    return m;
}

+ (instancetype)survive {
    MathAnswerSheetMode *m = [[self alloc] init];
    m.type = MathAnswerSheetModeTypeSurvive;
    m.total = 0;
    m.limitTime = 0;
    return m;
}

@end
