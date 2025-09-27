//
//  TestSettingViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/25.
//

#import "TestSettingViewModel.h"

@implementation TestSettingViewModel
   
- (NSArray<NSDictionary *> *)loadDigitsDate
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *testDigits = [[FMDBManager sharedManager] queryTable:@"TestDigits" columns:@[@"ButtonID"] where:@"TestID = ?" argument:@[@"9f13a949-d547-4445-9f60-345d6bda11f4"] orderBy:@"Position ASC"];
    for (NSDictionary *dict in testDigits) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTable:@"DigitsButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
        NSString *text = button.firstObject[@"Text"];
        
        [result addObject:@{@"ButtonID" : buttonID,@"Text" : text}];
    }
    return result;
}

- (NSArray<NSDictionary *> *)loadTestScopeDate
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *testScope = [[FMDBManager sharedManager] queryTable:@"TestScope" columns:@[@"ButtonID"] where:@"TestID = ?" argument:@[@"9f13a949-d547-4445-9f60-345d6bda11f4"] orderBy:@"Position ASC"];
    for (NSDictionary *dict in testScope) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTable:@"TestScopeButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
        NSString *text = button.firstObject[@"Text"];
        
        [result addObject:@{@"ButtonID" : buttonID,@"Text" : text}];
    }
    return result;
}

- (NSArray<NSDictionary *> *)loadTestMode
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *testMode = [[FMDBManager sharedManager] queryTable:@"TestMode" columns:@[@"ButtonID"] where:@"TestID = ?" argument:@[@"9f13a949-d547-4445-9f60-345d6bda11f4"] orderBy:@"Position ASC"];
    for (NSDictionary *dict in testMode) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTable:@"TestModeButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
        NSString *text = button.firstObject[@"Text"];
        
        [result addObject:@{@"ButtonID" : buttonID,@"Text" : text}];
    }
    return result;
}

- (NSArray<NSString *> *)loadImgName
{
    NSArray *imgName = @[
        @"TestSetting_option_1",
        @"TestSetting_option_1",
        @"TestSetting_option_1",
        @"TestSetting_option_2",
        @"TestSetting_option_2",
        @"TestSetting_option_2",
        @"TestSetting_option_3"
    ];
    return imgName;
}

- (NSArray<NSString *> *)loadCategoryNames {
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *category = [[FMDBManager sharedManager] queryTable:@"Category" columns:@[@"CategoryName"] where:@"Priority IN (?, ?, ?, ?)" argument:@[@0,@1,@2,@3] orderBy:@"Priority ASC"];
    
    for (NSDictionary *dict in category) {
        NSString *categoryName = dict[@"CategoryName"];
        if (categoryName) {
            [result addObject:categoryName];
        }
    }
    return result;
}

- (NSArray<NSArray<NSString *> *> *)loadSkillName
{
    NSMutableArray *result = [NSMutableArray array];

    NSArray *skill = [[FMDBManager sharedManager] queryTable:@"Skill" columns:@[@"SkillName",@"CategoryID"] where:@"" argument:nil orderBy:@"Priority ASC"];
    NSMutableDictionary<NSString *, NSMutableArray *> *groupedSkills = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in skill) {
        NSString *categoryID = dict[@"CategoryID"];
        NSString *skillName = dict[@"SkillName"];
        if (!groupedSkills[categoryID]) {
            groupedSkills[categoryID] = [NSMutableArray array];
        }
        [groupedSkills[categoryID] addObject:skillName];
    }
    
    NSArray *category = [[FMDBManager sharedManager] queryTable:@"Category" columns:@[@"CategoryID"] where:@"Priority IN (?, ?, ?, ?)" argument:@[@0,@1,@2,@3] orderBy:@"Priority ASC"];
    for (NSDictionary *dict in category) {
        NSString *categoryID = dict[@"CategoryID"];
        NSArray *skillName = groupedSkills[categoryID];
        [result addObject:skillName];
    }
    return result;
}
@end
