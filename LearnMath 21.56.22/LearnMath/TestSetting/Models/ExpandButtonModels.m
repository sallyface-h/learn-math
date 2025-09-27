//
//  ExpandButtonModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/12.
//

#import "ExpandButtonModels.h"

@implementation ExpandButtonModels
- (instancetype)initWithTitle:(NSArray<NSString *> *)title andSkill:(NSArray<NSArray<NSString *> *> *)skill
{
    if (self == [super init]) {
        _title = title;
        _skill = skill;
    }
    return self;
}

+ (instancetype)modelWithTitle:(NSArray<NSString *> *)title andSkill:(NSArray<NSArray<NSString *> *> *)skill
{
    return [[self alloc] initWithTitle:title andSkill:skill];
}

@end
