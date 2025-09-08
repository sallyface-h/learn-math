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
        _calculateNum =calculateNum;
        _countDownOfQuestion = countDownOfQuestion;
    }
    return self;
}

+ (TrainingSettingModels *)trainingSettingModelMake
{
    return [[TrainingSettingModels alloc] initWithCalculateNum:@[@"<10",@"<100"] andCountDownOfQuestion:@[@"No",@"10 Sec",@"20 Sec",@"30 Sec"]];
}
@end
