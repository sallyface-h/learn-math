//
//  MathCategoryViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/21.
//

#import "MathCategoryViewModel.h"

@implementation MathCategoryViewModel
- (instancetype)init
{
    if (self == [super init]) {
        [self configureTable];
    }
    return self;
}

- (void)configureTable{
    NSDictionary *members = @{
        @"SkillID" : @"TEXT",
        @"SkillName" : @"TEXT",
        @"CategoryID" : @"TEXT",
        @"TutorialPath" : @"TEXT",
        @"FinshedCount" : @"INTEGER",
        @"Priority" : @"INTEGER"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"Skill" andMembers:members andPrimaryKey:@"SkillID"];
    
    NSArray *detailMembers = @[
        @{@"SkillID" : @"8f93a92f-1092-4a17-987b-4d79bd0c04c9",@"SkillName" : @"Make-Ten", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5", @"Priority" : @"0" },
        @{@"SkillID" : @"b6214515-da1a-47d2-917a-028b7290b761",@"SkillName" : @"Column vertical form", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5", @"Priority" : @"1" },
        @{@"SkillID" : @"5310a4df-ae27-48b3-9fce-4821f4962d8f",@"SkillName" : @"Decomposition and compensation", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5", @"Priority" : @"2" },
        @{@"SkillID" : @"51567e76-c21e-4d8c-b0f1-ce8c42104a70",@"SkillName" : @"Moving the numbers", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5", @"Priority" : @"3" },
        @{@"SkillID" : @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791",@"SkillName" : @"Finding the base number", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5", @"Priority" : @"4" },
        @{@"SkillID" : @"dba1eb30-a0b1-45cd-9960-5282c085a439",@"SkillName" : @"Break-Ten", @"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3", @"Priority" : @"5" },
        @{@"SkillID" : @"43eb2e94-94ca-4142-9107-22c37419519b",@"SkillName" : @"Column vertical form",@"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3", @"Priority" : @"6" },
        @{@"SkillID" : @"0131610a-3bae-422f-b408-d2518f836736",@"SkillName" : @"Moving the numbers", @"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3", @"Priority" : @"7" },
        @{@"SkillID" : @"42ed0028-9c03-4077-b527-77a8409ea5d5",@"SkillName" : @"Making up interal", @"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3", @"Priority" : @"8" },
        @{@"SkillID" : @"a66f4910-f1be-48d9-bf13-6813446475b7",@"SkillName" : @"Multiplication Table",@"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004", @"Priority" : @"9" },
        @{@"SkillID" : @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e",@"SkillName" : @"Column vertical form", @"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004", @"Priority" : @"10" },
        @{@"SkillID" : @"dd6c07af-7105-47a5-bbfc-8c4be2360efd",@"SkillName" : @"Everal tens and one", @"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004", @"Priority" : @"11" },
        @{@"SkillID" : @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a",@"SkillName" : @"Decomposing terms", @"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004", @"Priority" : @"12" },
        @{@"SkillID" : @"4bc5a67b-2da1-4e7c-8e2b-c6331c93f255",@"SkillName" : @"Multiplication Table", @"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467", @"Priority" : @"13" },
        @{@"SkillID" : @"d8e100a2-95bc-4c97-8999-81c3bb17208a",@"SkillName" : @"Vertical form", @"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467", @"Priority" : @"14" },
        @{@"SkillID" : @"249dcb28-f3aa-47ae-a4a4-71e2ccb3338e",@"SkillName" : @"Divded by 5 or 25", @"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467", @"Priority" : @"15" },
        @{@"SkillID" : @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a",@"SkillName" : @"Decomposing terms", @"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467", @"Priority" : @"16" },
    ];
    
    [[FMDBManager sharedManager] insertIntoTable:@"Skill" members:detailMembers];
}

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
    NSLog(@"CategoryID = %@", CategoryID);
    NSLog(@"result = %@", result);
    NSLog(@"skillName = %@", skillName);
}

@end
