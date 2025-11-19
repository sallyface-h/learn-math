//
//  MathAnswerSheetInputItem.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MathAnswerSheetInputType) {
    MathAnswerSheetInputTypeNumber,
    MathAnswerSheetInputTypeClean,
    MathAnswerSheetInputTypeCheck
};

@interface MathAnswerSheetInputItem : NSObject
@property (nonatomic, assign) MathAnswerSheetInputType type;
@property (nonatomic, copy) NSString *number;

- (instancetype)initWithType:(MathAnswerSheetInputType)type number:(NSString *)number;
@end

NS_ASSUME_NONNULL_END
