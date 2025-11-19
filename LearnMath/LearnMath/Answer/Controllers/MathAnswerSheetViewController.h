//
//  MathAnswerSheetViewController.h
//  LearnMath
//
//  Created by 基 on 2025/10/21.
//

#import "BaseViewOCController.h"
@class MathWorkSelectedTestOptions;
@class MathWorkSelectedTrainOptions;
@class MathAnswerSheetEntry;
@import AppStoreKit;
NS_ASSUME_NONNULL_BEGIN

@interface MathAnswerSheetViewController : BaseViewOCController
@property (nonatomic, strong, nullable) MathWorkSelectedTrainOptions *selectedTrainOptions;
@property (nonatomic, strong, nullable) MathWorkSelectedTestOptions *selectedTestOptions;
+ (CGFloat)finalWidth;
- (instancetype)initWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
