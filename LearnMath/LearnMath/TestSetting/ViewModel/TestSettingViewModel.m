//
//  TestSettingViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/25.
//

#import "TestSettingViewModel.h"

@implementation TestSettingViewModel
   
- (NSArray<NSDictionary *> *)loadDigitsData
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *testDigits = [[FMDBManager sharedManager] queryTestDigitsData];
    for (NSDictionary *dict in testDigits) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTestDigitsButtonDataForButtonID:buttonID];
        NSString *text = button.firstObject[@"Text"];
        
        [result addObject:@{@"ButtonID" : buttonID,@"Text" : text}];
    }
    return result;
}

- (NSArray<NSDictionary *> *)loadTestScopeData
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *testScope = [[FMDBManager sharedManager] queryTestScopeData];
    for (NSDictionary *dict in testScope) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTestScopeButtonDataForButtonID:buttonID];
        NSString *text = button.firstObject[@"Text"];
        
        [result addObject:@{@"ButtonID" : buttonID,@"Text" : text}];
    }
    return result;
}

- (NSArray<NSDictionary *> *)loadTestMode
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *testMode = [[FMDBManager sharedManager] queryTestModeData];
    for (NSDictionary *dict in testMode) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTestModeButtonDataForButtonID:buttonID];
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
    
    NSArray *category = [[FMDBManager sharedManager] queryHomeSingeleBtnData];
    
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

    NSArray *skill = [[FMDBManager sharedManager] queryTestSkillData];
    NSMutableDictionary<NSString *, NSMutableArray *> *groupedSkills = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in skill) {
        NSString *categoryID = dict[@"CategoryID"];
        NSString *skillName = dict[@"SkillName"];
        if (!groupedSkills[categoryID]) {
            groupedSkills[categoryID] = [NSMutableArray array];
        }
        [groupedSkills[categoryID] addObject:skillName];
    }
    
    NSArray *category = [[FMDBManager sharedManager] queryHomeSingeleBtnData];
    for (NSDictionary *dict in category) {
        NSString *categoryID = dict[@"CategoryID"];
        NSArray *skillName = groupedSkills[categoryID];
        [result addObject:skillName];
    }
    return result;
}

- (ExpandButtonModels *)loadExpandModelWithButtonID:(NSString *)buttonID
{
    ExpandButtonModels *model = [[ExpandButtonModels alloc] init];
    
    if ([buttonID isEqualToString:@"2"]) {
        // “2” 表示选择测试范围（标题模式）
        NSArray *titles = [self loadCategoryNames];
        model.title = titles;
    }
    else if ([buttonID isEqualToString:@"3"]) {
        // “3” 表示选择技能（分组模式）
        NSArray *titles = [self loadCategoryNames];
        NSArray *skills = [self loadSkillName];
        model.title = titles;
        model.skill = skills;
    }

    return model;
}

+ (NSArray<NSString *> *)loadSkillIDWithDict:(NSArray<NSDictionary *> *)dict
{
    NSMutableArray *skillIDs = [NSMutableArray array];
        
    for (NSDictionary *pair in dict) {
        NSString *skillName = pair[@"skillName"];
        NSString *categoryName = pair[@"categoryName"];
        NSString *categoryID = [TestSettingViewModel loadCategoryIDWithCategoryName:categoryName];
        NSString *skillID = [[FMDBManager sharedManager] querySkillIDWithSkillName:skillName categoryID:categoryID].firstObject[@"SkillID"];
        if (skillID) {
            [skillIDs addObject:skillID];
        }
    }

    return skillIDs;
}


+ (NSString *)loadCategoryIDWithCategoryName:(NSString *)categoryName
{
    NSString *categoryID = [[FMDBManager sharedManager] queryCategoryIDWithCategoryName:categoryName].firstObject[@"CategoryID"];
    return categoryID;
}

+ (NSArray<NSString *> *)loadCategoryIDsWithCategoryName:(NSArray<NSString *> *)categoryName
{
    NSMutableArray *result = [NSMutableArray array];
    for (NSString *name in categoryName) {
        NSString *categoryID = [[FMDBManager sharedManager] queryCategoryIDWithCategoryName:name].firstObject[@"CategoryID"];
        [result addObject:categoryID];
    }
    return result;
}

+ (NSArray<NSString *> *)loadSkillIDsWithCategoryID:(NSArray<NSString *> *)categoryIDs
{
    NSMutableArray *skillIDs = [NSMutableArray array];
    for (NSString *categoryID in categoryIDs) {
        NSArray *skillIDict = [[FMDBManager sharedManager] querySkillIDsWithCategoryID:categoryID];
        for (NSDictionary *dict in skillIDict) {
            NSString *skillID = dict[@"SkillID"];
            [skillIDs addObject:skillID];
        }
    }
    return skillIDs;
}
@end
