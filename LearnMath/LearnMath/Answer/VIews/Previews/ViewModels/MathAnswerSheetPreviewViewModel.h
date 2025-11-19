//
//  MathAnswerSheetPreviewViewModel.h
//  LearnMath
//
//  Created by 基 on 2025/10/22.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"
#import "MathAnswerSheetPreviewImages.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathAnswerSheetPreviewViewModel : NSObject
@property (nonatomic, strong, readonly) MathAnswerSheetPreviewImages *model;
- (void)loadPreviewData:(NSString *)skillID;

@end

NS_ASSUME_NONNULL_END
