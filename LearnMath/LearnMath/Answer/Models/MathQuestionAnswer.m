//
//  MathQuestionAnswer.m
//  LearnMath
//
//  Created by 基 on 2025/11/3.
//

#import "MathQuestionAnswer.h"

@implementation MathQuestionAnswer
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _numbers = dict[@"Numbers"];
        _answers = dict[@"Answers"];
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}
@end
