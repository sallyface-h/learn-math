//
//  MathCategoryViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/21.
//

#import "MathCategoryViewModel.h"

@implementation MathCategoryViewModel

- (void)loadDate:(NSString *)CategoryID
{
    NSArray *result = [[FMDBManager sharedManager] queryTable:@"Skill" columns:@[@"SkillName",@"SkillID"] where:@"CategoryID = ?" argument:@[CategoryID] orderBy:@"Priority ASC"];
    NSMutableArray *skillName = [NSMutableArray array];
    NSMutableArray *skillID = [NSMutableArray array];
    for (NSDictionary *dict in result) {
        [skillName addObject:dict[@"SkillName"]];
        [skillID addObject:dict[@"SkillID"]];
    }
    _model = [MathCategoryModels modelWithSkill:skillName];
}

@end
