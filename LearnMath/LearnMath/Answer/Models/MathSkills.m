//
//  MathSkills.m
//  LearnMath
//
//  Created by 基 on 2025/11/10.
//

#import "MathSkills.h"

@implementation MathSkills
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        _skillID = dict[@"SkillID"];
        _categoryID = dict[@"CategoryID"];
        _tutorialPath = dict[@"TutorialPath"];
        _trainCount = [dict[@"TrainCount"] integerValue];
        _name = dict[@"Name"];
        _priority = dict[@"Priority"];
    }
    return self;
}
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
