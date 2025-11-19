//
//  MathAnswerSheetViewModel.h
//  LearnMath
//
//  Created by 基 on 2025/10/24.
//

#import <Foundation/Foundation.h>
#import "MathAnswerSheetEntry.h"
#import "MathAnswerSheetMode.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathAnswerSheetViewModel : NSObject
+ (nullable MathAnswerSheetMode *)modeForEntry:(MathAnswerSheetEntry *)entry;

@end

NS_ASSUME_NONNULL_END
