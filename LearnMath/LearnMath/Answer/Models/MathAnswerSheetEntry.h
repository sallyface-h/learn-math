//
//  MathAnswerSheetEntry.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <Foundation/Foundation.h>
#import "MathAnswerSheetMode.h"
#import "MathWorkBooks.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MathAnswerSheetEntryType) {
    MathAnswerSheetEntryTypeTrain,
    MathAnswerSheetEntryTypeTest,
};

@interface MathAnswerSheetEntry : NSObject
@property (nonatomic, assign) MathAnswerSheetEntryType type;
@property (nonatomic, strong, nullable) MathAnswerSheetMode *mode;
@property (nonatomic, strong, nullable) MathWorkSelectedTrainOptions *trainOptions;
@property (nonatomic, strong, nullable) MathWorkSelectedTestOptions *testOptions;
+ (instancetype)trainWithOptions:(MathWorkSelectedTrainOptions *)options;
+ (instancetype)testWithOptions:(MathWorkSelectedTestOptions *)options;

@end

NS_ASSUME_NONNULL_END
