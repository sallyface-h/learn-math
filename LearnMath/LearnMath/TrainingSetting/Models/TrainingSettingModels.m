//
//  TrainingSettingModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import "TrainingSettingModels.h"

@implementation TrainingSettingModels
- (instancetype)initWithCalculateNum:(NSArray<NSString *> *)calculateNum andCountDownOfQuestion:(NSArray<NSString *> *)countDownOfQuestion
{
    if (self == [super init]) {
        _calculateNum = calculateNum;
        _countDownOfQuestion = countDownOfQuestion;
    }
    return self;
}

+ (instancetype)modelWithCalculateNum:(NSArray<NSString *> *)calculateNum andCountDownOfQuestion:(NSArray<NSString *> *)countDownOfQuestion
{
    return [[self alloc] initWithCalculateNum:calculateNum andCountDownOfQuestion:countDownOfQuestion];
}
@end
