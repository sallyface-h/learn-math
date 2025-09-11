//
//  TestSettingModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingModels.h"

@implementation TestSettingModels
- (instancetype)initWithCalculateNum:(NSArray<NSString *> *)calculateNum andTestScope:(NSArray<NSString *> *)testScope
{
    if (self == [super init]) {
        _calculateNum = calculateNum;
        _testScope = testScope;
    }
    return self;
}

+ (instancetype)modelWithCalculateNum:(NSArray<NSString *> *)calculateNum andTestScope:(NSArray<NSString *> *)testScope
{
    return [[self alloc] initWithCalculateNum:calculateNum andTestScope:testScope];
}
@end
