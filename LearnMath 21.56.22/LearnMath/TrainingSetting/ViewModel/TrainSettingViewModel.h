//
//  TrainSettingViewModel.h
//  LearnMath
//
//  Created by 基 on 2025/9/22.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"
#import "TrainingSettingModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface TrainSettingViewModel : NSObject
@property (nonatomic, strong, readonly) TrainingSettingModels *model;
- (NSArray<NSDictionary *> *)loadDigitsDate;
- (NSArray<NSDictionary *> *)loadCountDownDate;
@end

NS_ASSUME_NONNULL_END
