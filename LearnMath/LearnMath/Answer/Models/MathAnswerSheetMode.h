//
//  MathAnswerSheetMode.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MathAnswerSheetModeType) {
    MathAnswerSheetModeTypeQuestionsLimit,
    MathAnswerSheetModeTypeTimeLimit,
    MathAnswerSheetModeTypeSurvive,
};

@interface MathAnswerSheetMode : NSObject
@property (nonatomic, assign) MathAnswerSheetModeType type;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSTimeInterval limitTime;

+ (instancetype)questionsLimit:(NSInteger)total;
+ (instancetype)timeLimit:(NSTimeInterval)limitTime total:(NSInteger)total;
+ (instancetype)survive;

@end

NS_ASSUME_NONNULL_END
