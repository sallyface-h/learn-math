//
//  MathCategoryModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/7.
//

#import "MathCategoryModels.h"

@implementation MathCategoryModels
- (instancetype)initWithSkill:(NSArray<NSString *> *)skill
{
    if (self == [super init]) {
        _skill = skill;
    }
    return self;
}

+ (instancetype)modelWithSkill:(NSArray<NSString *> *)skill
{
    return [[self alloc] initWithSkill:skill];
}

@end

