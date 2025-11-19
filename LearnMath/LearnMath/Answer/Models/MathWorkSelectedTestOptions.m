//
//  MathWorkSelectedTestOptions.m
//  LearnMath
//
//  Created by 基 on 2025/11/6.
//

#import "MathWorkSelectedTestOptions.h"

@implementation MathWorkSelectedTestOptions
- (instancetype)init {
    self = [super init];
    if (self) {
        _testRangeKey = @"";
        _testCategoires = @[];
        _testSkills = @[];
        _testDigitKey = @"";
        _testModeKey = @"";
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    return @{
            @"TestRangeKey": self.testRangeKey ?: @"",
            @"TestCategoires": self.testCategoires ?: [NSNull null],
            @"TestSkills" : self.testSkills ?: [NSNull null],
            @"TestDigitKey" : self.testDigitKey ?: @"",
            @"TestModeKey" : self.testModeKey ?: @""
        };
}
@end
