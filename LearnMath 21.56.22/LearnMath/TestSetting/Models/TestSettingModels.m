//
//  TestSettingModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingModels.h"

@implementation TestSettingModels
- (instancetype)initWithCalculateNum:(NSArray <NSDictionary *> *)calculateNum andTestScope:(NSArray <NSDictionary *> *)testScope
{
    if (self == [super init]) {
        _calculateNum = calculateNum;
        _testScope = testScope;
    }
    return self;
}

+ (instancetype)modelWithCalculateNum:(NSArray<NSDictionary *> *)calculateNum andTestScope:(NSArray<NSDictionary *> *)testScope
{
    return [[self alloc] initWithCalculateNum:calculateNum andTestScope:testScope];
}
@end
