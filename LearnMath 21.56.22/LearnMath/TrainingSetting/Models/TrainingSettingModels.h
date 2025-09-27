//
//  TrainingSettingModels.h
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrainingSettingModels : NSObject
@property (nonatomic ,strong) NSArray<NSDictionary *> *calculateNum;
@property (nonatomic, strong) NSArray<NSDictionary *> *countDownOfQuestion;

- (instancetype)initWithCalculateNum:(NSArray<NSDictionary *> *)calculateNum andCountDownOfQuestion:(NSArray<NSDictionary *> *)countDownOfQuestion;
+ (instancetype)modelWithCalculateNum:(NSArray<NSDictionary *> *)calculateNum andCountDownOfQuestion:(NSArray<NSDictionary *> *)countDownOfQuestion;
@end

NS_ASSUME_NONNULL_END
