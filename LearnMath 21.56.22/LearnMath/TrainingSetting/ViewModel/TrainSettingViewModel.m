//
//  TrainSettingViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/22.
//

#import "TrainSettingViewModel.h"

@implementation TrainSettingViewModel

- (NSArray<NSDictionary *> *)loadDigitsDate
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *trainDigits = [[FMDBManager sharedManager] queryTable:@"TrainDigits" columns:@[@"ButtonID"] where:@"TrainID = ?" argument:@[@"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9"] orderBy:@"Position ASC"];
    for (NSDictionary *dict in trainDigits) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTable:@"DigitsButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
        NSString *text = button.firstObject[@"Text"];
        
        [result addObject:@{@"ButtonID" : buttonID,@"Text" : text}];
        
    }
    return result;
}

- (NSArray<NSDictionary *> *)loadCountDownDate
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *trainCountDown = [[FMDBManager sharedManager] queryTable:@"TrainCountDown" columns:@[@"ButtonID"] where:@"TrainID = ?" argument:@[@"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9"] orderBy:@"Position ASC"];
    for (NSDictionary *dict in trainCountDown) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTable:@"CountDownButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
        NSString *text = button.firstObject[@"Text"];
        
        [result addObject:@{@"ButtonID" : buttonID,@"Text" : text}];
    }
    return result;
}

@end
