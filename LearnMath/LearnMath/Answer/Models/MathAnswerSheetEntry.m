//
//  MathAnswerSheetEntry.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetEntry.h"

@implementation MathAnswerSheetEntry
+ (instancetype)trainWithOptions:(MathWorkSelectedTrainOptions *)options
{
    MathAnswerSheetEntry *entry = [[MathAnswerSheetEntry alloc] init];
    entry.type = MathAnswerSheetEntryTypeTrain;
    entry.trainOptions = options;
    return entry;
}

+ (instancetype)testWithOptions:(MathWorkSelectedTestOptions *)options
{
    MathAnswerSheetEntry *entry = [[MathAnswerSheetEntry alloc] init];
    entry.type = MathAnswerSheetEntryTypeTest;
    entry.testOptions = options;
    return entry;
}

@end
