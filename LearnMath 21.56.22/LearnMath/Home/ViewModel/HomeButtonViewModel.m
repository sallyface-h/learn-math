//
//  HomeButtonViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/19.
//

#import "HomeButtonViewModel.h"

@implementation HomeButtonViewModel

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
