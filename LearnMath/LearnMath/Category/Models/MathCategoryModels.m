//
//  MathCategoryModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/7.
//

#import "MathCategoryModels.h"

@implementation MathCategoryModels
- (instancetype)initWithSkill:(NSArray<NSString *> *)skill andtutorialVideoURLs:(nonnull NSArray<NSString *> *)tutorialVideoURLs skillID:(NSArray<NSString *> *)skillID
{
    if (self == [super init]) {
        _skill = skill;
        _tutorialVideoURLs = tutorialVideoURLs;
        _skillID = skillID;
    }
    return self;
}

+ (instancetype)modelWithSkill:(NSArray<NSString *> *)skill andtutorialVideoURLs:(nonnull NSArray<NSString *> *)tutorialVideoURLs skillID:(NSArray<NSString *> *)skillID
{
    return [[self alloc] initWithSkill:skill andtutorialVideoURLs:tutorialVideoURLs skillID:skillID];
}

@end

