//
//  TrainingSettingModels.h
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrainingSettingModels : NSObject
@property (nonatomic ,strong) NSArray <NSString *> *calculateNum;
@property (nonatomic, strong) NSArray <NSString *> *countDownOfQuestion;

- (instancetype)initWithCalculateNum:(NSArray <NSString *> *)calculateNum andCountDownOfQuestion:(NSArray <NSString *> *)countDownOfQuestion;
+ (instancetype)modelWithCalculateNum:(NSArray<NSString *> *)calculateNum andCountDownOfQuestion:(NSArray<NSString *> *)countDownOfQuestion;
@end

NS_ASSUME_NONNULL_END
