//
//  SubscribeModel.h
//  LearnMath
//
//  Created by 基 on 2025/9/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubscribeModel : NSObject
@property (nonatomic, copy) NSArray<NSString *> *priceText;
@property (nonatomic, copy) NSArray<NSString *> *timeText;
@property (nonatomic, copy) NSArray<NSString *> *originalPriceText;

- (instancetype)initWithPriceText:(NSArray<NSString *> *)priceText andtimeText:(NSArray<NSString *> *)timeText andoriginalPriceText:(NSArray<NSString *> *)originalPriceText;
+ (instancetype)modelWithPriceText:(NSArray<NSString *> *)priceText andtimeText:(NSArray<NSString *> *)timeText andoriginalPriceText:(NSArray<NSString *> *)originalPriceText;
@end

NS_ASSUME_NONNULL_END
