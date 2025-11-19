//
//  MathWorkSelectedTrainOptions.m
//  LearnMath
//
//  Created by 基 on 2025/11/6.
//

#import "MathWorkSelectedTrainOptions.h"

@implementation MathWorkSelectedTrainOptions
- (instancetype)init {
    self = [super init];
    if (self) {
        _trainDigitKey = @"";
        _trainCountdownKey = @"";
        _skillID = @"";
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    return @{
        @"TrainDigitKey": self.trainDigitKey,
        @"TrainCountdownKey": self.trainCountdownKey,
        @"SkillID" : self.skillID
    };
}
@end
