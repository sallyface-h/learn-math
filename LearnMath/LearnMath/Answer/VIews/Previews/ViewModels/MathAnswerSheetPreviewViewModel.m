//
//  MathAnswerSheetPreviewViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/10/22.
//

#import "MathAnswerSheetPreviewViewModel.h"

@implementation MathAnswerSheetPreviewViewModel
- (void)loadPreviewData:(NSString *)skillID
{
    NSArray *result1 = [[FMDBManager sharedManager] queryTrainPreviewImage:skillID];
    NSArray *result2 = [[FMDBManager sharedManager] queryTrainTip:skillID];
    NSMutableArray *content = [NSMutableArray array];
    NSMutableArray *rangeLocation = [NSMutableArray array];
    NSMutableArray *rangeLength = [NSMutableArray array];
    NSMutableArray *previewImage = [NSMutableArray array];
    for (NSDictionary *dict in result1) {
        [previewImage addObject:dict[@"ImageName"]];

    }
    for (NSDictionary *dict in result2) {
        [content addObject:dict[@"Content"]];
        [rangeLocation addObject:dict[@"RangeLocation"]];
        [rangeLength addObject:dict[@"RangeLength"]];
    }
    _model = [MathAnswerSheetPreviewImages modelWithImgName:previewImage content:content rangeLocation:rangeLocation rangeLength:rangeLength];
}

@end
