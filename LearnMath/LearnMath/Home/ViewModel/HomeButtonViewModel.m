//
//  HomeButtonViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/19.
//

#import "HomeButtonViewModel.h"

@implementation HomeButtonViewModel
- (instancetype)init
{
    if (self == [super init]) {
        [self configureTable];
    }
    return self;
}

- (void)configureTable
{
    NSDictionary *members = @{
        @"CategoryID" : @"TEXT",
        @"CategoryName" : @"TEXT",
        @"Priority" : @"INTEGER"
    };
    [[FMDBManager sharedManager] creatTableWithName:@"Category" andMembers:members andPrimaryKey:@"CategoryID"];
    
    NSArray *detailMembers = @[
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
    
    [[FMDBManager sharedManager] insertIntoTable:@"Category" members:detailMembers];
}

- (void)loadCategoryDate
{
    NSArray *SingBtnResults = [[FMDBManager sharedManager] queryTable:@"Category" columns:@[@"CategoryName",@"CategoryID"] where:@"Priority IN (?, ?, ?, ?)" argument:@[@0,@1,@2,@3] orderBy:@"Priority ASC"];
    NSMutableArray *singBtnCategoryNames = [NSMutableArray array];
    NSMutableArray *singBtncategoryIDs = [NSMutableArray array];
    for (NSDictionary *dict in SingBtnResults) {
        NSString *categoryname = dict[@"CategoryName"];
        NSString *categoryID = dict[@"CategoryID"];
        [singBtnCategoryNames addObject:categoryname];
        [singBtncategoryIDs addObject:categoryID];
    }
    
    NSArray *singleBtnImgArr = @[
        @"home_add",
        @"home_sub",
        @"home_mul",
        @"home_div"
    ];
    
    NSArray<UIColor *> *singleBtnColors = @[
        [UIColor colorForSet:ColorSetDeepOrange],
        [UIColor colorForSet:ColorSetOrange],
        [UIColor colorForSet:ColorSetBlue],
        [UIColor colorForSet:ColorSetGreen]
    ];
    
    _singleButtonModels = [HomeSingleButtonModel modelWithSingleButtonTitle:singBtnCategoryNames andImage:singleBtnImgArr andColor:singleBtnColors andCategoryID:singBtncategoryIDs];
    
    
    NSArray *multiBtnResultsFirst = [[FMDBManager sharedManager] queryTable:@"Category" columns:@[@"CategoryName",@"CategoryID"] where:@"Priority IN (?, ?)" argument:@[@4,@5] orderBy:@"Priority ASC"];
    NSMutableArray *multiBtnCategoryNamesFirst = [NSMutableArray array];
    NSMutableArray *multiBtnCategoryIDsFirst = [NSMutableArray array];
    for (NSDictionary *dict in multiBtnResultsFirst) {
        NSString *categoryname = dict[@"CategoryName"];
        NSString *categoryID = dict[@"CategoryID"];
        [multiBtnCategoryNamesFirst addObject:categoryname];
        [multiBtnCategoryIDsFirst addObject:categoryID];
    }
    
    NSArray *multiBtnImgFirst= @[
        @"nil",
        @"home_history"
    ];
    
    NSArray *multiBtnImgSecond = @[
        @"home_date",
        @"home_help",
        @"home_setting",
        @"home_subscription"
    ];
    
    HomeMultiButtonModel *firstCell = [HomeMultiButtonModel modelWithMultiButtonImgName:multiBtnImgFirst andTitle:multiBtnCategoryNamesFirst andColor:[UIColor colorForSet:ColorSetPink] andCategoryID:multiBtnCategoryIDsFirst];
    
    NSArray *multiBtnResultsSecond = [[FMDBManager sharedManager] queryTable:@"Category" columns:@[@"CategoryName",@"CategoryID"] where:@"Priority IN (?,?,?,?)" argument:@[@6,@7,@8,@9] orderBy:@"Priority ASC"];
    NSMutableArray *multiBtnCategoryNamesSecond = [NSMutableArray array];
    NSMutableArray *multiBtnCategoryIDsSecond = [NSMutableArray array];
    for (NSDictionary *dict in multiBtnResultsSecond) {
        NSString *categoryname = dict[@"CategoryName"];
        NSString *categoryID = dict[@"CategoryID"];
        [multiBtnCategoryNamesSecond addObject:categoryname];
        [multiBtnCategoryIDsSecond addObject:categoryID];
    }
    HomeMultiButtonModel *secondCell = [HomeMultiButtonModel modelWithMultiButtonImgName:multiBtnImgSecond andTitle:multiBtnCategoryNamesSecond andColor:[UIColor colorForSet:ColorSetPurple] andCategoryID:multiBtnCategoryIDsSecond];
    
    _multiButtonModels = @[firstCell, secondCell];
}

@end
