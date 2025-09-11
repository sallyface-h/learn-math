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
        _skill = skill ?: @[];
    }
    return self;
}

+ (instancetype)modelWithCategory:(MathCategory)category andSkillDict:(NSDictionary <NSNumber * , NSArray <NSString *> *> *)skillDict
{
    NSArray<NSString *> *skills = skillDict[@(category)];
        if (!skills) {
            skills = @[];
        }
    return [[self alloc] initWithSkill:skills];
}

@end

