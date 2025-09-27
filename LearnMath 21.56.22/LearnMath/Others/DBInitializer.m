//
//  DBInitializer.m
//  LearnMath
//
//  Created by 基 on 2025/9/27.
//

#import "DBInitializer.h"

@implementation DBInitializer
+ (void)creatTable
{
#pragma mark - Category表
    NSDictionary *categoryMembers = @{
        @"CategoryID" : @"TEXT",
        @"CategoryName" : @"TEXT",
        @"Priority" : @"INTEGER"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"Category" andMembers:categoryMembers andPrimaryKey:@"CategoryID" andForeignKey:nil];
    
#pragma mark - Skill表
    NSDictionary *skillMembers = @{
        @"SkillID" : @"TEXT",
        @"SkillName" : @"TEXT",
        @"CategoryID" : @"TEXT",
        @"TutorialPath" : @"TEXT",
        @"FinshedCount" : @"INTEGER",
        @"Priority" : @"INTEGER"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"Skill" andMembers:skillMembers andPrimaryKey:@"SkillID" andForeignKey:nil];

#pragma mark - Train表
    NSDictionary *trainMembers = @{
        @"TrainID" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"Train" andMembers:trainMembers andPrimaryKey:@"TrainID" andForeignKey:nil];
    
    NSDictionary *digitButtonMembers = @{
           @"ButtonID" : @"TEXT",
           @"Text" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"DigitsButton" andMembers:digitButtonMembers andPrimaryKey:@"ButtonID" andForeignKey:nil];
    
    NSDictionary *countDownButtonMembers = @{
           @"ButtonID" : @"TEXT",
           @"Text" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"CountDownButton" andMembers:countDownButtonMembers andPrimaryKey:@"ButtonID" andForeignKey:nil];
    
    NSDictionary *trainDigits = @{
        @"TrainDigitsID" : @"TEXT",
        @"ButtonID" : @"TEXT",
        @"Position" : @"INTEGER",
        @"TrainID" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"TrainDigits" andMembers:trainDigits andPrimaryKey:@"TrainDigitsID" andForeignKey:@{@"TrainID" : @"Train(TrainID)",@"ButtonID" : @"DigitsButton(ButtonID)"}];
    
    NSDictionary *trainCountDown = @{
        @"TrainCountDownID" : @"TEXT",
        @"ButtonID" : @"TEXT",
        @"Position" : @"INTEGER",
        @"TrainID" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"TrainCountDown" andMembers:trainCountDown andPrimaryKey:@"TrainCountDownID" andForeignKey:@{@"TrainID" : @"Train(TrainID)",@"ButtonID" : @"CountDownButton(ButtonID)"}];
    
#pragma mark - Test表
    NSDictionary *testMember = @{
        @"TestID" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"Test" andMembers:testMember andPrimaryKey:@"TestID" andForeignKey:nil];
    
    NSDictionary *digitsButtonMembers = @{
        @"ButtonID" : @"TEXT",
        @"Text" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"DigitsButton" andMembers:digitsButtonMembers andPrimaryKey:@"ButtonID" andForeignKey:nil];
    
    NSDictionary *TestScopeButtonMembers = @{
        @"ButtonID" : @"TEXT",
        @"Text" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"TestScopeButton" andMembers:TestScopeButtonMembers andPrimaryKey:@"ButtonID" andForeignKey:nil];
    
    NSDictionary *TestModeButtonMembers = @{
        @"ButtonID" : @"TEXT",
        @"Text" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"TestModeButton" andMembers:TestModeButtonMembers andPrimaryKey:@"ButtonID" andForeignKey:nil];
    
    NSDictionary *digitsMembers = @{
        @"DigitsID" : @"TEXT",
        @"ButtonID" : @"TEXT",
        @"Position" : @"INTEGER",
        @"TestID" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"TestDigits" andMembers:digitsMembers andPrimaryKey:@"DigitsID" andForeignKey:@{@"TestID" : @"Test(TestID)",@"ButtonID" : @"DigitsButton(ButtonID)"}];
    
    NSDictionary *testScopeMembers = @{
        @"TestScopeID" : @"TEXT",
        @"ButtonID" : @"TEXT",
        @"Position" : @"INTEGER",
        @"TestID" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"TestScope" andMembers:testScopeMembers andPrimaryKey:@"TestScopeID" andForeignKey:@{@"TestID" : @"Test(TestID)",@"ButtonID" : @"TestScopeButton(ButtonID)"}];
    
    NSDictionary *selectedModeMembers = @{
        @"TestModeID" : @"TEXT",
        @"ButtonID" : @"TEXT",
        @"Position" : @"INTEGER",
        @"TestID" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"TestMode" andMembers:selectedModeMembers andPrimaryKey:@"TestModeID" andForeignKey:@{@"TestID" : @"Test(TestID)",@"ButtonID" : @"TestModeButton(ButtonID)"}];
}

+ (void)insertDateToTable
{
#pragma mark - Category表
    NSArray *categoryMembers = @[
        @{@"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"CategoryName" : @"Addition",@"Priority" : @"0"},
        @{@"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3",@"CategoryName" : @"Subtraction",@"Priority" : @"1"},
        @{@"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004",@"CategoryName" : @"Multiplication",@"Priority" : @"2"},
        @{@"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467",@"CategoryName" : @"Division",@"Priority" : @"3"},
        @{@"CategoryID" : @"f89a6d93-4ca4-4c3c-9d31-bfcdccaffeea",@"CategoryName" : @"Do a Test!",@"Priority" : @"4"},
        @{@"CategoryID" : @"0e9aace6-388b-4652-9a72-bb9e8d75eef3",@"CategoryName" : @"nil",@"Priority" : @"5"},
        @{@"CategoryID" : @"65f3d104-01f6-4cc8-8aeb-2e0e25447a3a",@"CategoryName" : @"nil",@"Priority" : @"6"},
        @{@"CategoryID" : @"3464d214-1e65-46e8-ba77-1dba2a2b19b6",@"CategoryName" : @"nil",@"Priority" : @"7"},
        @{@"CategoryID" : @"ae3f8481-8616-4b12-a144-f62b3447ef75",@"CategoryName" : @"nil",@"Priority" : @"8"},
        @{@"CategoryID" : @"8e827711-2a28-465c-a1b8-d174aaa46351",@"CategoryName" : @"nil",@"Priority" : @"9"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"Category" members:categoryMembers];
    
#pragma mark - Skill表
    NSArray *skillMembers = @[
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
    [[FMDBManager sharedManager] insertIntoTable:@"Skill" members:skillMembers];
    
#pragma mark - Train表
    [[FMDBManager sharedManager] insertIntoTable:@"Train" members:@[@{@"TrainID" : @"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9"}]];
    
    NSArray *digitButton = @[
        @{@"ButtonID" : @"1",@"Text" : @"<10"},
        @{@"ButtonID" : @"2",@"Text" : @"<100"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"DigitsButton" members:digitButton];
    
    NSArray *countDownButton = @[
        @{@"ButtonID" : @"1",@"Text" : @"No"},
        @{@"ButtonID" : @"2",@"Text" : @"10 Sec"},
        @{@"ButtonID" : @"3",@"Text" : @"20 Sec"},
        @{@"ButtonID" : @"4",@"Text" : @"30 Sec"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"CountDownButton" members:countDownButton];
    
    NSArray *digitsMembers = @[
        @{@"TrainDigitsID" : @"0ee956e9-3dc8-45ad-8e1b-3f98c5dabc79",@"TrainID": @"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9",@"Position" : @"0",@"ButtonID" : @"1"},
        @{@"TrainDigitsID" : @"4983eb96-f012-46d0-b875-b037fe8aa6b2",@"TrainID": @"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9",@"Position" : @"1",@"ButtonID" : @"2"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"TrainDigits" members:digitsMembers];
    
    NSArray *countDownMember = @[
        @{@"TrainCountDownID" : @"92487b34-14fc-473e-bfab-ac162a835600",@"TrainID": @"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9",@"Position" : @"0",@"ButtonID" : @"1"},
        @{@"TrainCountDownID" : @"6f713656-224a-4a96-bf32-20e0c61c16e5",@"TrainID": @"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9",@"Position" : @"1",@"ButtonID" : @"2"},
        @{@"TrainCountDownID" : @"9bcc0782-6c00-4f89-904d-64cfbd6f9c59",@"TrainID": @"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9",@"Position" : @"2",@"ButtonID" : @"3"},
        @{@"TrainCountDownID" : @"d0a5aa53-ba52-4110-b934-edcdcceb6808",@"TrainID": @"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9",@"Position" : @"3",@"ButtonID" : @"4"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"TrainCountDown" members:countDownMember];
    
#pragma mark - Test表
    [[FMDBManager sharedManager] insertIntoTable:@"Test" members:@[@{@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"}]];
    
    NSArray *digitsButton = @[
        @{@"ButtonID" : @"1",@"Text" : @"<10"},
        @{@"ButtonID" : @"2",@"Text" : @"<100"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"DigitsButton" members:digitsButton];
    
    NSArray *testScopeButton = @[
        @{@"ButtonID" : @"1",@"Text" : @"All you've learned"},
        @{@"ButtonID" : @"2",@"Text" : @"Choose by operations"},
        @{@"ButtonID" : @"3",@"Text" : @"Choose by skills"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"TestScopeButton" members:testScopeButton];
    
    NSArray *testModeButton = @[
        @{@"ButtonID" : @"1",@"Text" : @"10 Questions (Unlimit time)"},
        @{@"ButtonID" : @"2",@"Text" : @"25 Questions (Unlimit time)"},
        @{@"ButtonID" : @"3",@"Text" : @"50 Questions (Unlimit time)"},
        @{@"ButtonID" : @"4",@"Text" : @"1 Min (Unlimited question)"},
        @{@"ButtonID" : @"5",@"Text" : @"5 Min (Unlimited question)"},
        @{@"ButtonID" : @"6",@"Text" : @"15 Min (Unlimited question)"},
        @{@"ButtonID" : @"7",@"Text" : @"Survive: 3 times error will end"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"TestModeButton" members:testModeButton];
    
    NSArray *trainDigits = @[
        @{@"DigitsID" : @"b1e7bac4-4a2b-4052-972a-afaaa5ff81e8",@"ButtonID" : @"1",@"Position" : @"0",@"TestID" :  @"9f13a949-d547-4445-9f60-345d6bda11f4"},
        @{@"DigitsID" : @"9ef53d9f-ade2-46a5-a1d8-9814036a0361",@"ButtonID" : @"2",@"Position" : @"0",@"TestID" :  @"9f13a949-d547-4445-9f60-345d6bda11f4"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"TestDigits" members:trainDigits];
    
    NSArray *testScope = @[
        @{@"TestScopeID" : @"0c172ee6-f460-40cb-9a0f-4d307b16f4c6",@"ButtonID" : @"1",@"Position" : @"0",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"},
        @{@"TestScopeID" : @"e384de1d-fb94-4094-8645-f4b8dc128bbf",@"ButtonID" : @"2",@"Position" : @"1",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"},
        @{@"TestScopeID" : @"70ff1ced-4b2a-4ec2-8071-be4533978f82",@"ButtonID" : @"3",@"Position" : @"2",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"TestScope" members:testScope];
    
    NSArray *testMode = @[
        @{@"TestModeID" : @"19ff17b3-6eaa-400e-8b77-d961b67c0b8f",@"ButtonID" : @"1",@"Position" : @"0",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"},
        @{@"TestModeID" : @"8cfd221d-c72e-47af-805e-e981b870806c",@"ButtonID" : @"2",@"Position" : @"1",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"},
        @{@"TestModeID" : @"8bd78364-de3a-46cc-8096-6baf698088b8",@"ButtonID" : @"3",@"Position" : @"2",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"},
        @{@"TestModeID" : @"498f7b1d-4fe6-4644-b934-85d48c9f60b6",@"ButtonID" : @"4",@"Position" : @"3",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"},
        @{@"TestModeID" : @"8a86ec94-4015-4872-b962-9c09ae8c33a8",@"ButtonID" : @"5",@"Position" : @"4",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"},
        @{@"TestModeID" : @"a9da56d1-4f5c-4046-8311-0f34ab578e73",@"ButtonID" : @"6",@"Position" : @"5",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"},
        @{@"TestModeID" : @"a94116f1-066e-42ab-b87b-0aa0a933bbc5",@"ButtonID" : @"7",@"Position" : @"6",@"TestID" : @"9f13a949-d547-4445-9f60-345d6bda11f4"}
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"TestMode" members:testMode];
}
@end
