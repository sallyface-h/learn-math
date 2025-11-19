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
        @"TrainCount" : @"INTEGER",
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
#pragma mark - Bank表
    NSDictionary *bankMember = @{
        @"BankID" : @"TEXT",
        @"Name" : @"TEXT",
        @"CategoryID" : @"TEXT",
        @"SkillID" : @"TEXT",
    };
    [[FMDBManager sharedManager] creatTableWithName:@"Bank" andMembers:bankMember andPrimaryKey:@"BankID" andForeignKey:@{@"CategoryID" : @"Category(CategoryID)",@"SkillID" : @"Skill(SkillID)"}];

#pragma mark - SkillPreviewImage表
    NSDictionary *previewImageMember = @{
        @"PreviewID" : @"TEXT",
        @"SkillID" : @"TEXT",
        @"ImageName" : @"TEXT",
        @"Position" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"SkillPreviewImage" andMembers:previewImageMember andPrimaryKey:@"PreviewID" andForeignKey:@{@"SkillID" : @"Skill(SkillID)"}];
    
#pragma mark - SkillTip表
    NSDictionary *tipMember = @{
        @"TipID" : @"TEXT",
        @"SkillID" : @"TEXT",
        @"Content" : @"TEXT",
        @"RangeLocation" : @"INTEGER",
        @"RangeLength" : @"INTEGER",
        @"Position" : @"TEXT"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"SkillTip" andMembers:tipMember andPrimaryKey:@"TipID" andForeignKey:@{@"SkillID" : @"Skill(SkillID)"}];
    
#pragma mark - MathWorkBooks表
    NSDictionary *workBookMember = @{
        @"BookID" : @"TEXT",
        @"QuestionID" : @"TEXT",
        @"Total" : @"INTEGER",
        @"Style" : @"TEXT",
        @"SelectedTrainOptions" : @"TEXT",
        @"SelectedTestOptions" : @"TEXT",
        @"Time" : @"INTEGER"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"MathWorkBooks" andMembers:workBookMember andPrimaryKey:@"BookID" andForeignKey:@{@"QuestionID" : @"MathQuestion(QuestionID)"}];

#pragma mark - MathQuestion表
    NSDictionary *quesiton = @{
        @"QuestionID" : @"TEXT",
        @"CategoryID" : @"TEXT",
        @"BankID" : @"TEXT",
        @"SkillID" : @"TEXT",
        @"Digits" : @"INTEGER",
        @"Time" : @"INTEGER",
        @"Answer" : @"TEXT",
    };
    [[FMDBManager sharedManager] creatTableWithName:@"MathQuestion" andMembers:quesiton andPrimaryKey:@"QuestionID" andForeignKey:@{@"CategoryID" : @"Category(CategoryID)",@"BankID" : @"Bank(BankID)",@"SkillID" : @"Skill(SkillID)"}];
    
#pragma mark - MathSuccessRecords表
    NSDictionary *success = @{
        @"RecordID" : @"TEXT",
        @"QuestionID" : @"TEXT",
        @"BookID" : @"TEXT",
        @"CategoryID" : @"TEXT",
        @"SkillID" : @"TEXT",
        @"Style" : @"TEXT",
        @"Time" : @"INTEGER",
    };
    [[FMDBManager sharedManager] creatTableWithName:@"MathSuccessRecords" andMembers:success andPrimaryKey:@"RecordID" andForeignKey:@{@"CategoryID" : @"Category(CategoryID)",@"QuestionID" : @"MathQuestion(QuestionID)",@"SkillID" : @"Skill(SkillID)",@"BookID" : @"MathWorkBooks(BookID)"}];
    
#pragma mark - MathErrorRecords表
    NSDictionary *error = @{
        @"RecordID" : @"TEXT",
        @"QuestionID" : @"TEXT",
        @"BookID" : @"TEXT",
        @"CategoryID" : @"TEXT",
        @"SkillID" : @"TEXT",
        @"Style" : @"TEXT",
        @"Time" : @"INTEGER",
    };
    [[FMDBManager sharedManager] creatTableWithName:@"MathErrorRecords" andMembers:error andPrimaryKey:@"RecordID" andForeignKey:@{@"CategoryID" : @"Category(CategoryID)",@"QuestionID" : @"MathQuestion(QuestionID)",@"SkillID" : @"Skill(SkillID)",@"BookID" : @"MathWorkBooks(BookID)"}];
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
        @{@"SkillID" : @"8f93a92f-1092-4a17-987b-4d79bd0c04c9",@"SkillName" : @"Make-Ten", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5", @"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/make_ten.mp4", @"Priority" : @"0",@"TrainCount" : @(0)},
        @{@"SkillID" : @"b6214515-da1a-47d2-917a-028b7290b761",@"SkillName" : @"Column vertical form", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/cloumn_vertical_form_addition.mp4", @"Priority" : @"1",@"TrainCount" : @(0) },
        @{@"SkillID" : @"5310a4df-ae27-48b3-9fce-4821f4962d8f",@"SkillName" : @"Decomposition and compensation", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/decomposition_compensation.mp4", @"Priority" : @"2",@"TrainCount" : @(0) },
        @{@"SkillID" : @"51567e76-c21e-4d8c-b0f1-ce8c42104a70",@"SkillName" : @"Moving the numbers", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/move_the_number.mp4", @"Priority" : @"3",@"TrainCount" : @(0) },
        @{@"SkillID" : @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791",@"SkillName" : @"Finding the base number", @"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/find_the_base_number.mp4", @"Priority" : @"4",@"TrainCount" : @(0) },
        @{@"SkillID" : @"dba1eb30-a0b1-45cd-9960-5282c085a439",@"SkillName" : @"Break-Ten", @"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/sub_break_ten.mp4", @"Priority" : @"5",@"TrainCount" : @(0) },
        @{@"SkillID" : @"43eb2e94-94ca-4142-9107-22c37419519b",@"SkillName" : @"Column vertical form",@"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/sub_column_vertical_form.mp4", @"Priority" : @"6",@"TrainCount" : @(0) },
        @{@"SkillID" : @"0131610a-3bae-422f-b408-d2518f836736",@"SkillName" : @"Moving the numbers", @"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/sub_truncation_move_the_number.mp4", @"Priority" : @"7",@"TrainCount" : @(0) },
        @{@"SkillID" : @"42ed0028-9c03-4077-b527-77a8409ea5d5",@"SkillName" : @"Making up interal", @"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/sub_making_up_interal.mp4", @"Priority" : @"8",@"TrainCount" : @(0) },
        @{@"SkillID" : @"a66f4910-f1be-48d9-bf13-6813446475b7",@"SkillName" : @"Multiplication Table",@"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/mul_multiplication_table.mp4", @"Priority" : @"9",@"TrainCount" : @(0) },
        @{@"SkillID" : @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e",@"SkillName" : @"Column vertical form", @"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/mul_column_vertical_form.mp4", @"Priority" : @"10" ,@"TrainCount" : @(0)},
        @{@"SkillID" : @"dd6c07af-7105-47a5-bbfc-8c4be2360efd",@"SkillName" : @"Everal tens and one", @"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/mul_everal_tens_and_one.mp4", @"Priority" : @"11",@"TrainCount" : @(0) },
        @{@"SkillID" : @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a",@"SkillName" : @"Decomposing terms", @"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/mul_decomposing_terms.mp4", @"Priority" : @"12" ,@"TrainCount" : @(0)},
        @{@"SkillID" : @"4bc5a67b-2da1-4e7c-8e2b-c6331c93f255",@"SkillName" : @"Multiplication Table", @"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/div_multiplication_table.mp4", @"Priority" : @"13",@"TrainCount" : @(0) },
        @{@"SkillID" : @"d8e100a2-95bc-4c97-8999-81c3bb17208a",@"SkillName" : @"Vertical form", @"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/div_column_vertical_form.mp4", @"Priority" : @"14",@"TrainCount" : @(0) },
        @{@"SkillID" : @"249dcb28-f3aa-47ae-a4a4-71e2ccb3338e",@"SkillName" : @"Divded by 5 or 25", @"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/mul_multiply_by_5_or_25.mp4", @"Priority" : @"15",@"TrainCount" : @(0) },
        @{@"SkillID" : @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a",@"SkillName" : @"Decomposing terms", @"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467",@"TutorialPath" : @"https://fun-lives.com/wp-content/uploads/2024/10/div_decomposing_terms.mp4", @"Priority" : @"16" ,@"TrainCount" : @(0)},
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
    
#pragma mark - Bank表
    NSArray *bank = @[
        @{@"BankID" : @"96a51b91-d079-4ec8-9a46-ba0cf1da14fc",@"name" : @"Make-Ten",@"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"SkillID" : @"8f93a92f-1092-4a17-987b-4d79bd0c04c9"},
        @{@"BankID" : @"770b6bc4-3d16-4fc9-9ce9-c43c1f8ff7ef",@"name" : @"Column vertical form",@"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"SkillID" : @"b6214515-da1a-47d2-917a-028b7290b761"},
        @{@"BankID" : @"b88aa1d2-c9da-4932-bd33-2930c919eae9",@"name" : @"Decomposition and compensation ",@"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"SkillID" : @"5310a4df-ae27-48b3-9fce-4821f4962d8f"},
        @{@"BankID" : @"5efdf943-d75e-4c4b-ad66-f39c8d8653b9",@"name" : @"Moving the numbers",@"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"SkillID" : @"51567e76-c21e-4d8c-b0f1-ce8c42104a70"},
        @{@"BankID" : @"e345c800-b109-4105-ba4e-7a86e1e83bf1",@"name" : @"Finding the base number",@"CategoryID" : @"caa56389-602f-4624-b81d-cbe0e7dd20a5",@"SkillID" : @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791"},
        @{@"BankID" : @"491c4f6b-efe7-4830-aef4-6cd3762eaab0",@"name" : @"Break-Ten",@"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3",@"SkillID" : @"dba1eb30-a0b1-45cd-9960-5282c085a439"},
        @{@"BankID" : @"ab85a52e-9a07-4081-9faf-86a34bf7d8b8",@"name" : @"Column vertical form",@"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3",@"SkillID" : @"43eb2e94-94ca-4142-9107-22c37419519b"},
        @{@"BankID" : @"f8e768d1-7e1e-44db-9820-f41d7f7cd642",@"name" : @"Moving the numbers",@"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3",@"SkillID" : @"0131610a-3bae-422f-b408-d2518f836736"},
        @{@"BankID" : @"7ccf63aa-f313-4809-8518-71eb292603af",@"name" : @"Making up interal",@"CategoryID" : @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3",@"SkillID" : @"42ed0028-9c03-4077-b527-77a8409ea5d5"},
        @{@"BankID" : @"f7627bc1-3f15-4439-a5c6-8cd7788ec68c",@"name" : @"Multiplication Table",@"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004",@"SkillID" : @"a66f4910-f1be-48d9-bf13-6813446475b7"},
        @{@"BankID" : @"c88fb5db-4ed6-4f97-9619-88b7a0277da5",@"name" : @"Column vertical form",@"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004",@"SkillID" : @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e"},
        @{@"BankID" : @"75f83afe-a01c-4b3f-8751-97595b142ef5",@"name" : @"Everal tens and one",@"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004",@"SkillID" : @"dd6c07af-7105-47a5-bbfc-8c4be2360efd"},
        @{@"BankID" : @"86ef29a9-a895-483d-b946-26f7186ff9ab",@"name" : @"Decomposing terms",@"CategoryID" : @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004",@"SkillID" : @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a"},
        @{@"BankID" : @"eee00c61-f03a-4285-a726-e4965c252128",@"name" : @"Multiplication Table",@"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467",@"SkillID" : @"4bc5a67b-2da1-4e7c-8e2b-c6331c93f255"},
        @{@"BankID" : @"021f5ee2-d346-4c0e-a7fe-cd394980044b",@"name" : @"Vertical form",@"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467",@"SkillID" : @"d8e100a2-95bc-4c97-8999-81c3bb17208a"},
        @{@"BankID" : @"d83ca152-225e-45ca-9f35-65ca683b1ac5",@"name" : @"Divided by 5 or 25",@"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467",@"SkillID" : @"249dcb28-f3aa-47ae-a4a4-71e2ccb3338e"},
        @{@"BankID" : @"72c3dc81-4e07-42e6-af0d-52a57f108acd",@"name" : @"Decomposing terms",@"CategoryID" : @"0e47f809-13af-4824-a7b8-00cdab5aa467",@"SkillID" : @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a"},
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"Bank" members:bank];
    
#pragma mark - SkillPreviewImage表
    NSArray *skillPreviews = @[
        @{@"PreviewID": @"1", @"SkillID": @"8f93a92f-1092-4a17-987b-4d79bd0c04c9", @"ImageName": @"add_make_ten_preview_01", @"Position": @"0"},
        @{@"PreviewID": @"2", @"SkillID": @"8f93a92f-1092-4a17-987b-4d79bd0c04c9", @"ImageName": @"add_make_ten_preview_02", @"Position": @"1"},
        @{@"PreviewID": @"3", @"SkillID": @"8f93a92f-1092-4a17-987b-4d79bd0c04c9", @"ImageName": @"add_make_ten_preview_03", @"Position": @"3"},
        @{@"PreviewID": @"4", @"SkillID": @"8f93a92f-1092-4a17-987b-4d79bd0c04c9", @"ImageName": @"add_make_ten_preview_04", @"Position": @"4"},
        @{@"PreviewID": @"5", @"SkillID": @"b6214515-da1a-47d2-917a-028b7290b761", @"ImageName": @"add_column_vertical_form_preview_01", @"Position": @"5"},
        @{@"PreviewID": @"6", @"SkillID": @"b6214515-da1a-47d2-917a-028b7290b761", @"ImageName": @"add_column_vertical_form_preview_02", @"Position": @"6"},
        @{@"PreviewID": @"7", @"SkillID": @"b6214515-da1a-47d2-917a-028b7290b761", @"ImageName": @"add_column_vertical_form_preview_03", @"Position": @"7"},
        @{@"PreviewID": @"8", @"SkillID": @"5310a4df-ae27-48b3-9fce-4821f4962d8f", @"ImageName": @"add_decomposition_and_compensation_preview_01", @"Position": @"8"},
        @{@"PreviewID": @"9", @"SkillID": @"5310a4df-ae27-48b3-9fce-4821f4962d8f", @"ImageName": @"add_decomposition_and_compensation_preview_02", @"Position": @"9"},
        @{@"PreviewID": @"10", @"SkillID": @"5310a4df-ae27-48b3-9fce-4821f4962d8f", @"ImageName": @"add_decomposition_and_compensation_preview_03", @"Position": @"10"},
        @{@"PreviewID": @"11", @"SkillID": @"5310a4df-ae27-48b3-9fce-4821f4962d8f", @"ImageName": @"add_decomposition_and_compensation_preview_04", @"Position": @"11"},
        @{@"PreviewID": @"12", @"SkillID": @"51567e76-c21e-4d8c-b0f1-ce8c42104a70", @"ImageName": @"add_moving_the_numbers_preview_01", @"Position": @"12"},
        @{@"PreviewID": @"13", @"SkillID": @"51567e76-c21e-4d8c-b0f1-ce8c42104a70", @"ImageName": @"add_moving_the_numbers_preview_02", @"Position": @"13"},
        @{@"PreviewID": @"14", @"SkillID": @"51567e76-c21e-4d8c-b0f1-ce8c42104a70", @"ImageName": @"add_moving_the_numbers_preview_03", @"Position": @"14"},
        @{@"PreviewID": @"15", @"SkillID": @"51567e76-c21e-4d8c-b0f1-ce8c42104a70", @"ImageName": @"add_moving_the_numbers_preview_04", @"Position": @"15"},
        @{@"PreviewID": @"16", @"SkillID": @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791", @"ImageName": @"add_finding_the_base_number_preview_01", @"Position": @"16"},
        @{@"PreviewID": @"17", @"SkillID": @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791", @"ImageName": @"add_finding_the_base_number_preview_01", @"Position": @"17"},
        @{@"PreviewID": @"18", @"SkillID": @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791", @"ImageName": @"add_finding_the_base_number_preview_01", @"Position": @"18"},
        @{@"PreviewID": @"19", @"SkillID": @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791", @"ImageName": @"add_finding_the_base_number_preview_01", @"Position": @"19"},
        @{@"PreviewID": @"20", @"SkillID": @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791", @"ImageName": @"add_finding_the_base_number_preview_01", @"Position": @"20"},
        @{@"PreviewID": @"21", @"SkillID": @"dba1eb30-a0b1-45cd-9960-5282c085a439", @"ImageName": @"sub_break_ten_preview_01", @"Position": @"21"},
        @{@"PreviewID": @"22", @"SkillID": @"dba1eb30-a0b1-45cd-9960-5282c085a439", @"ImageName": @"sub_break_ten_preview_02", @"Position": @"22"},
        @{@"PreviewID": @"23", @"SkillID": @"dba1eb30-a0b1-45cd-9960-5282c085a439", @"ImageName": @"sub_break_ten_preview_03", @"Position": @"23"},
        @{@"PreviewID": @"24", @"SkillID": @"dba1eb30-a0b1-45cd-9960-5282c085a439", @"ImageName": @"sub_break_ten_preview_04", @"Position": @"24"},
        @{@"PreviewID": @"25", @"SkillID": @"43eb2e94-94ca-4142-9107-22c37419519b", @"ImageName": @"sub_column_vertical_form_preview_01", @"Position": @"25"},
        @{@"PreviewID": @"26", @"SkillID": @"43eb2e94-94ca-4142-9107-22c37419519b", @"ImageName": @"sub_column_vertical_form_preview_02", @"Position": @"26"},
        @{@"PreviewID": @"27", @"SkillID": @"43eb2e94-94ca-4142-9107-22c37419519b", @"ImageName": @"sub_column_vertical_form_preview_03", @"Position": @"27"},
        @{@"PreviewID": @"28", @"SkillID": @"0131610a-3bae-422f-b408-d2518f836736", @"ImageName": @"sub_moving_the_numbers_preview_01", @"Position": @"28"},
        @{@"PreviewID": @"29", @"SkillID": @"0131610a-3bae-422f-b408-d2518f836736", @"ImageName": @"sub_moving_the_numbers_preview_02", @"Position": @"29"},
        @{@"PreviewID": @"30", @"SkillID": @"0131610a-3bae-422f-b408-d2518f836736", @"ImageName": @"sub_moving_the_numbers_preview_03", @"Position": @"30"},
        @{@"PreviewID": @"31", @"SkillID": @"0131610a-3bae-422f-b408-d2518f836736", @"ImageName": @"sub_moving_the_numbers_preview_04", @"Position": @"31"},
        @{@"PreviewID": @"32", @"SkillID": @"42ed0028-9c03-4077-b527-77a8409ea5d5", @"ImageName": @"sub_making_up_interal_preview_01", @"Position": @"32"},
        @{@"PreviewID": @"33", @"SkillID": @"42ed0028-9c03-4077-b527-77a8409ea5d5", @"ImageName": @"sub_making_up_interal_preview_02", @"Position": @"33"},
        @{@"PreviewID": @"34", @"SkillID": @"42ed0028-9c03-4077-b527-77a8409ea5d5", @"ImageName": @"sub_making_up_interal_preview_03", @"Position": @"34"},
        @{@"PreviewID": @"35", @"SkillID": @"a66f4910-f1be-48d9-bf13-6813446475b7", @"ImageName": @"mul_multiplication_table_preview_01", @"Position": @"35"},
        @{@"PreviewID": @"36", @"SkillID": @"a66f4910-f1be-48d9-bf13-6813446475b7", @"ImageName": @"mul_multiplication_table_preview_02", @"Position": @"36"},
        @{@"PreviewID": @"37", @"SkillID": @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e", @"ImageName": @"mul_column_vertical_form_preview_01", @"Position": @"37"},
        @{@"PreviewID": @"38", @"SkillID": @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e", @"ImageName": @"mul_column_vertical_form_preview_02", @"Position": @"38"},
        @{@"PreviewID": @"39", @"SkillID": @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e", @"ImageName": @"mul_column_vertical_form_preview_03", @"Position": @"39"},
        @{@"PreviewID": @"40", @"SkillID": @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e", @"ImageName": @"mul_column_vertical_form_preview_04", @"Position": @"40"},
        @{@"PreviewID": @"41", @"SkillID": @"dd6c07af-7105-47a5-bbfc-8c4be2360efd", @"ImageName": @"mul_everal_tens_and_one_preview_01", @"Position": @"41"},
        @{@"PreviewID": @"42", @"SkillID": @"dd6c07af-7105-47a5-bbfc-8c4be2360efd", @"ImageName": @"mul_everal_tens_and_one_preview_02", @"Position": @"42"},
        @{@"PreviewID": @"43", @"SkillID": @"dd6c07af-7105-47a5-bbfc-8c4be2360efd", @"ImageName": @"mul_everal_tens_and_one_preview_03", @"Position": @"43"},
        @{@"PreviewID": @"44", @"SkillID": @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a", @"ImageName": @"mul_decomposing_terms_preview_01", @"Position": @"44"},
        @{@"PreviewID": @"45", @"SkillID": @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a", @"ImageName": @"mul_decomposing_terms_preview_02", @"Position": @"45"},
        @{@"PreviewID": @"46", @"SkillID": @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a", @"ImageName": @"mul_decomposing_terms_preview_03", @"Position": @"46"},
        @{@"PreviewID": @"47", @"SkillID": @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a", @"ImageName": @"mul_decomposing_terms_preview_04", @"Position": @"47"},
        @{@"PreviewID": @"48", @"SkillID": @"4bc5a67b-2da1-4e7c-8e2b-c6331c93f255", @"ImageName": @"div_pmultiplication_table_preview_01", @"Position": @"48"},
        @{@"PreviewID": @"49", @"SkillID": @"4bc5a67b-2da1-4e7c-8e2b-c6331c93f255", @"ImageName": @"div_pmultiplication_table_preview_02", @"Position": @"49"},
        @{@"PreviewID": @"50", @"SkillID": @"d8e100a2-95bc-4c97-8999-81c3bb17208a", @"ImageName": @"div_column_vertical_form_preview_01", @"Position": @"50"},
        @{@"PreviewID": @"51", @"SkillID": @"d8e100a2-95bc-4c97-8999-81c3bb17208a", @"ImageName": @"div_column_vertical_form_preview_02", @"Position": @"51"},
        @{@"PreviewID": @"52", @"SkillID": @"d8e100a2-95bc-4c97-8999-81c3bb17208a", @"ImageName": @"div_column_vertical_form_preview_03", @"Position": @"52"},
        @{@"PreviewID": @"53", @"SkillID": @"249dcb28-f3aa-47ae-a4a4-71e2ccb3338e", @"ImageName": @"div_divided_by_5_or_25_preview_01", @"Position": @"53"},
        @{@"PreviewID": @"54", @"SkillID": @"249dcb28-f3aa-47ae-a4a4-71e2ccb3338e", @"ImageName": @"div_divided_by_5_or_25_preview_02", @"Position": @"54"},
        @{@"PreviewID": @"55", @"SkillID": @"249dcb28-f3aa-47ae-a4a4-71e2ccb3338e", @"ImageName": @"div_divided_by_5_or_25_preview_03", @"Position": @"55"},
        @{@"PreviewID": @"56", @"SkillID": @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a", @"ImageName": @"div_decomposing_terms_preview_01", @"Position": @"56"},
        @{@"PreviewID": @"57", @"SkillID": @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a", @"ImageName": @"div_decomposing_terms_preview_02", @"Position": @"57"},
        @{@"PreviewID": @"58", @"SkillID": @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a", @"ImageName": @"div_decomposing_terms_preview_03", @"Position": @"58"},
        @{@"PreviewID": @"59", @"SkillID": @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a", @"ImageName": @"div_decomposing_terms_preview_04", @"Position": @"59"},
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"SkillPreviewImage" members:skillPreviews];
    
#pragma mark - SkillTip表
    NSArray *skillTips = @[
        @{@"TipID" : @"1", @"SkillID" : @"8f93a92f-1092-4a17-987b-4d79bd0c04c9" , @"Content" : @"In order to make 8 to 10,\n7 need to be splited into 2 plus ?\nthen 8 plus 2 is 10" , @"RangeLocation" : @"12" , @"RangeLength" : @"12" , @"Position" : @"1"},
        @{@"TipID" : @"2", @"SkillID" : @"8f93a92f-1092-4a17-987b-4d79bd0c04c9" , @"Content" : @"7 minus 2 is 5" , @"RangeLocation" : @"0" , @"RangeLength" : @"9" , @"Position" : @"2"},
        @{@"TipID" : @"3", @"SkillID" : @"8f93a92f-1092-4a17-987b-4d79bd0c04c9" , @"Content" : @"10 plus 5 is 15" , @"RangeLocation" : @"0" , @"RangeLength" : @"9" , @"Position" : @"3"},
        @{@"TipID" : @"4", @"SkillID" : @"b6214515-da1a-47d2-917a-028b7290b761" , @"Content" : @"For the one-digit, 7 plus 4 is 11. \n The ten digit is advanced by 1." , @"RangeLocation" : @"19" , @"RangeLength" : @"8" , @"Position" : @"4"},
        @{@"TipID" : @"5", @"SkillID" : @"b6214515-da1a-47d2-917a-028b7290b761" , @"Content" : @"In the ten’s place, \n 2 plus 3 plus 1 is 6." , @"RangeLocation" : @"22" , @"RangeLength" : @"8" , @"Position" : @"5"},
        @{@"TipID" : @"6", @"SkillID" : @"5310a4df-ae27-48b3-9fce-4821f4962d8f" , @"Content" : @"In order to make 6 to 10,\n9 need to split into 4 plus a digit\nthen 6 plus 4 is 10." , @"RangeLocation" : @"12" , @"RangeLength" : @"12" , @"Position" : @"6"},
        @{@"TipID" : @"7", @"SkillID" : @"5310a4df-ae27-48b3-9fce-4821f4962d8f" , @"Content" : @"9 minus 4 happen to be 5,\nmake 15 to 20." , @"RangeLocation" : @"25" , @"RangeLength" : @"14" , @"Position" : @"7"},
        @{@"TipID" : @"8", @"SkillID" : @"5310a4df-ae27-48b3-9fce-4821f4962d8f" , @"Content" : @"10 plus 20 is 30." , @"RangeLocation" : @"0" , @"RangeLength" : @"10" , @"Position" : @"8"},
        @{@"TipID" : @"9", @"SkillID" : @"51567e76-c21e-4d8c-b0f1-ce8c42104a70" , @"Content" : @"2 is just enough to form 10 with\n8.Move 2 and 8 are added first." , @"RangeLocation" : @"40" , @"RangeLength" : @"18" , @"Position" : @"9"},
        @{@"TipID" : @"10", @"SkillID" : @"51567e76-c21e-4d8c-b0f1-ce8c42104a70" , @"Content" : @"8 plus 2 is 10." , @"RangeLocation" : @"0" , @"RangeLength" : @"8" , @"Position" : @"10"},
        @{@"TipID" : @"11", @"SkillID" : @"51567e76-c21e-4d8c-b0f1-ce8c42104a70" , @"Content" : @"0 plus 1 is 11." , @"RangeLocation" : @"0" , @"RangeLength" : @"9" , @"Position" : @"11"},
        @{@"TipID" : @"12", @"SkillID" : @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791" , @"Content" : @"Both 13 and 12 can\nsplit into 10 + a digit,\n13 can be spilt into 10 and 3,\n12 can be spilt into 10 and 2." , @"RangeLocation" : @"19" , @"RangeLength" : @"23" , @"Position" : @"12"},
        @{@"TipID" : @"13", @"SkillID" : @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791" , @"Content" : @"Three times 10 is 30." , @"RangeLocation" : @"0" , @"RangeLength" : @"14" , @"Position" : @"13"},
        @{@"TipID" : @"14", @"SkillID" : @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791" , @"Content" : @"3 plus 2 plus 2 is 7." , @"RangeLocation" : @"0" , @"RangeLength" : @"15" , @"Position" : @"14"},
        @{@"TipID" : @"15", @"SkillID" : @"5fe1c31d-5726-49c5-9d7d-1eb2d08cf791" , @"Content" : @"7 plus 30 is 37." , @"RangeLocation" : @"0" , @"RangeLength" : @"9" , @"Position" : @"15"},
        @{@"TipID" : @"16", @"SkillID" : @"dba1eb30-a0b1-45cd-9960-5282c085a439" , @"Content" : @"In order to make 24 to 20,\n13 need to split into 4 plus a\ndigit\nthen 24 minus 4 is 20" , @"RangeLocation" : @"12" , @"RangeLength" : @"13" , @"Position" : @"16"},
        @{@"TipID" : @"17", @"SkillID" : @"dba1eb30-a0b1-45cd-9960-5282c085a439" , @"Content" : @"13 minus 4 equals 9" , @"RangeLocation" : @"0" , @"RangeLength" : @"10" , @"Position" : @"17"},
        @{@"TipID" : @"18", @"SkillID" : @"dba1eb30-a0b1-45cd-9960-5282c085a439" , @"Content" : @"20 minus 9 is 11" , @"RangeLocation" : @"0" , @"RangeLength" : @"10" , @"Position" : @"18"},
        @{@"TipID" : @"19", @"SkillID" : @"43eb2e94-94ca-4142-9107-22c37419519b" , @"Content" : @"The one-digit, 2 minus 9 not\nenough, the ten digit has to\nreduce by 1 to make 12 - 9,\nequals 3" , @"RangeLocation" : @"73" , @"RangeLength" : @"11" , @"Position" : @"19"},
        @{@"TipID" : @"20", @"SkillID" : @"43eb2e94-94ca-4142-9107-22c37419519b" , @"Content" : @"In the ten’s place,\n2 is reduced to 1,\n1 minus 1 is 0." , @"RangeLocation" : @"39" , @"RangeLength" : @"9" , @"Position" : @"20"},
        @{@"TipID" : @"21", @"SkillID" : @"0131610a-3bae-422f-b408-d2518f836736" , @"Content" : @"11 minus 1 is 10. Move\n1 to the front to be subtracted\nfirst." , @"RangeLocation" : @"23" , @"RangeLength" : @"31" , @"Position" : @"21"},
        @{@"TipID" : @"22", @"SkillID" : @"0131610a-3bae-422f-b408-d2518f836736" , @"Content" : @"11 minus 1 is 10." , @"RangeLocation" : @"0" , @"RangeLength" : @"11" , @"Position" : @"22"},
        @{@"TipID" : @"23", @"SkillID" : @"0131610a-3bae-422f-b408-d2518f836736" , @"Content" : @"10 minus 6 is 4." , @"RangeLocation" : @"0" , @"RangeLength" : @"10" , @"Position" : @"23"},
        @{@"TipID" : @"24", @"SkillID" : @"42ed0028-9c03-4077-b527-77a8409ea5d5" , @"Content" : @"7 and 13 need to\nbe subtracted at the same time,\nadd up 7 and 13 first,\nmake it to 20" , @"RangeLocation" : @"49" , @"RangeLength" : @"21" , @"Position" : @"24"},
        @{@"TipID" : @"25", @"SkillID" : @"42ed0028-9c03-4077-b527-77a8409ea5d5" , @"Content" : @"22 minus 20 is 2" , @"RangeLocation" : @"0" , @"RangeLength" : @"11" , @"Position" : @"25"},
        @{@"TipID" : @"26", @"SkillID" : @"a66f4910-f1be-48d9-bf13-6813446475b7" , @"Content" : @"Consider multiplication table,\n8 times 4 is 32" , @"RangeLocation" : @"31" , @"RangeLength" : @"9" , @"Position" : @"26"},
        @{@"TipID" : @"27", @"SkillID" : @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e" , @"Content" : @"Focus on the 1st number and\nthe 2nd number’s one-digit.\n19x2 can be\ndivided into 9x2 and 10x2.\nThe ten-digit is advance by 1." , @"RangeLocation" : @"68" , @"RangeLength" : @"26" , @"Position" : @"27"},
        @{@"TipID" : @"28", @"SkillID" : @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e" , @"Content" : @"Focus on the 1st number and\nthe 2nd number’s ten-digit.\n19x1 is 19." , @"RangeLocation" : @"56" , @"RangeLength" : @"5" , @"Position" : @"28"},
        @{@"TipID" : @"29", @"SkillID" : @"5c3cbacd-37d9-4a6a-beb3-e83c09b0476e" , @"Content" : @"Add up the numbers\ndigit by digit with vertical form" , @"RangeLocation" : @"19" , @"RangeLength" : @"33" , @"Position" : @"29"},
        @{@"TipID" : @"30", @"SkillID" : @"dd6c07af-7105-47a5-bbfc-8c4be2360efd" , @"Content" : @"Result’s one-digit will always be\n1 and the ten-digit is the sum by\nten digit numbers, 3+4 is 7." , @"RangeLocation" : @"40" , @"RangeLength" : @"45" , @"Position" : @"30"},
        @{@"TipID" : @"31", @"SkillID" : @"dd6c07af-7105-47a5-bbfc-8c4be2360efd" , @"Content" : @"Now we get 71, place the ten\ndigit numbers multiplied result\nat the front, 3x4 is 12, that’s 1271" , @"RangeLocation" : @"15" , @"RangeLength" : @"58" , @"Position" : @"31"},
        @{@"TipID" : @"32", @"SkillID" : @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a" , @"Content" : @"73 can split into 70 plus a digit,\n70 multiply 2 is 140" , @"RangeLocation" : @"0" , @"RangeLength" : @"33" , @"Position" : @"32"},
        @{@"TipID" : @"33", @"SkillID" : @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a" , @"Content" : @"73 minus 70 is 3\n3 multiply 2 is 6" , @"RangeLocation" : @"0" , @"RangeLength" : @"11" , @"Position" : @"33"},
        @{@"TipID" : @"34", @"SkillID" : @"38f96c25-0ff2-4550-9ce3-2a1bd565a31a" , @"Content" : @"140 plus 6 is 146" , @"RangeLocation" : @"0" , @"RangeLength" : @"10" , @"Position" : @"34"},
        @{@"TipID" : @"35", @"SkillID" : @"4bc5a67b-2da1-4e7c-8e2b-c6331c93f255" , @"Content" : @"Consider multiplication table,\n9 times 3 is 27" , @"RangeLocation" : @"31" , @"RangeLength" : @"9" , @"Position" : @"35"},
        @{@"TipID" : @"36", @"SkillID" : @"d8e100a2-95bc-4c97-8999-81c3bb17208a" , @"Content" : @"Focus on the ten-digit 9, get\nthe maximum product less then or\nequals 9, 2x4 is 8, 9 minus 8 is 1" , @"RangeLocation" : @"73" , @"RangeLength" : @"3" , @"Position" : @"36"},
        @{@"TipID" : @"37", @"SkillID" : @"d8e100a2-95bc-4c97-8999-81c3bb17208a" , @"Content" : @"Move the one-digit number 2 down,\nwe get 12, 2x6 is 12,\nso 46 is the result" , @"RangeLocation" : @"45" , @"RangeLength" : @"3" , @"Position" : @"37"},
        @{@"TipID" : @"38", @"SkillID" : @"249dcb28-f3aa-47ae-a4a4-71e2ccb3338e" , @"Content" : @"Divided by 5 can be replaced by\ndivided by 10 and multiply 2,\n380 ÷ 10 is 38 , 38 x 2 is 76" , @"RangeLocation" : @"32" , @"RangeLength" : @"29" , @"Position" : @"38"},
        @{@"TipID" : @"39", @"SkillID" : @"249dcb28-f3aa-47ae-a4a4-71e2ccb3338e" , @"Content" : @"Divided by 25 can be replaced by\ndivided by 100 and multiply 4,\n300 ÷ 100 is 3 , 3 x 4 is 12" , @"RangeLocation" : @"33" , @"RangeLength" : @"30" , @"Position" : @"39"},
        @{@"TipID" : @"40", @"SkillID" : @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a" , @"Content" : @"40 divided by 4 can get 10,\n72 can split into 40 plus a digit" , @"RangeLocation" : @"28" , @"RangeLength" : @"33" , @"Position" : @"40"},
        @{@"TipID" : @"41", @"SkillID" : @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a" , @"Content" : @"72 minus 40 is 32\n32 divided by 4 is 8" , @"RangeLocation" : @"0" , @"RangeLength" : @"11" , @"Position" : @"41"},
        @{@"TipID" : @"42", @"SkillID" : @"c27a9473-75b1-4ba9-9c46-be41c8e9fe5a" , @"Content" : @"10 plus 8 is 18" , @"RangeLocation" : @"0" , @"RangeLength" : @"9" , @"Position" : @"42"},
    ];
    [[FMDBManager sharedManager] insertIntoTable:@"SkillTip" members:skillTips];
}

@end
