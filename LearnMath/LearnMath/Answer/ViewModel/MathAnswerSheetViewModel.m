//
//  MathAnswerSheetViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/10/24.
//

#import "MathAnswerSheetViewModel.h"
#import "MathWorkSelectedTestOptions.h"
#import "MathWorkSelectedTrainOptions.h"
@implementation MathAnswerSheetViewModel
+ (nullable MathAnswerSheetMode *)modeForEntry:(MathAnswerSheetEntry *)entry {
    switch (entry.type) {
        case MathAnswerSheetEntryTypeTrain: {
            NSString *key = entry.trainOptions.trainCountdownKey;
            if ([key isEqualToString:@"1"]) {
                return [MathAnswerSheetMode questionsLimit:20];
            } else if ([key isEqualToString:@"2"]) {
                return [MathAnswerSheetMode timeLimit:10.0 total:20];
            } else if ([key isEqualToString:@"3"]) {
                return [MathAnswerSheetMode timeLimit:20.0 total:20];
            } else if ([key isEqualToString:@"4"]) {
                return [MathAnswerSheetMode timeLimit:30.0 total:20];
            } else {
                return nil;
            }
        }
        case MathAnswerSheetEntryTypeTest: {
            NSString *key = entry.testOptions.testModeKey;
            if ([key isEqualToString:@"1"]) {
                return [MathAnswerSheetMode questionsLimit:10];
            } else if ([key isEqualToString:@"2"]) {
                return [MathAnswerSheetMode questionsLimit:25];
            } else if ([key isEqualToString:@"3"]) {
                return [MathAnswerSheetMode questionsLimit:50];
            } else if ([key isEqualToString:@"4"]) {
                return [MathAnswerSheetMode timeLimit:(1.0 * 60.0) total:0];
            } else if ([key isEqualToString:@"5"]) {
                return [MathAnswerSheetMode timeLimit:(5.0 * 60.0) total:0];
            } else if ([key isEqualToString:@"6"]) {
                return [MathAnswerSheetMode timeLimit:(15.0 * 60.0) total:0];
            } else if ([key isEqualToString:@"7"]) {
                return [MathAnswerSheetMode survive];
            } else {
                return nil;
            }
        }
        default:
            return nil;
    }
}
@end
