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
    NSArray *result = [[FMDBManager sharedManager] querySkillsForCategoryID:CategoryID];
    
    NSMutableArray *skillName = [NSMutableArray array];
    NSMutableArray *skillID = [NSMutableArray array];
    NSMutableArray *videoURL = [NSMutableArray array];
    for (NSDictionary *dict in result) {
        [skillName addObject:dict[@"SkillName"]];
        [skillID addObject:dict[@"SkillID"]];
        [videoURL addObject:dict[@"TutorialPath"]];
    }
    
    _model = [MathCategoryModels modelWithSkill:skillName andtutorialVideoURLs:videoURL skillID:skillID];
}

@end
