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
    NSArray *SingBtnResults = [[FMDBManager sharedManager] queryHomeSingeleBtnData];
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
    
    
    NSArray *multiBtnResultsFirst = [[FMDBManager sharedManager] queryHomeFirMultiBtnData];
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
    
    NSArray *multiBtnResultsSecond = [[FMDBManager sharedManager] queryHomeSecMultiBtnData];    NSMutableArray *multiBtnCategoryNamesSecond = [NSMutableArray array];
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
