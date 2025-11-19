//
//  TrainSettingViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/22.
//

#import "TrainSettingViewModel.h"

@implementation TrainSettingViewModel

- (NSArray<NSDictionary *> *)loadDigitsData
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *trainDigits = [[FMDBManager sharedManager] queryTrainDigitsData];
    for (NSDictionary *dict in trainDigits) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTrainDigitsButtonDataForButtonID:buttonID];
        NSString *text = button.firstObject[@"Text"];
        
        [result addObject:@{@"ButtonID" : buttonID,@"Text" : text}];
        
    }
    return result;
}

- (NSArray<NSDictionary *> *)loadCountDownData
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *trainCountDown = [[FMDBManager sharedManager] queryTrainCountDownData];
    for (NSDictionary *dict in trainCountDown) {
        NSString *buttonID = dict[@"ButtonID"];
        
        NSArray *button = [[FMDBManager sharedManager] queryTrainCountDownDataButtonDataForButtonID:buttonID];
        NSString *text = button.firstObject[@"Text"];
        
        [result addObject:@{@"ButtonID" : buttonID,@"Text" : text}];
    }
    return result;
}

@end
