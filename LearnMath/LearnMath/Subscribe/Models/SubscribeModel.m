//
//  SubscribeModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/29.
//

#import "SubscribeModel.h"

@implementation SubscribeModel
- (instancetype)initWithPriceText:(NSArray<NSString *> *)priceText andtimeText:(NSArray<NSString *> *)timeText andoriginalPriceText:(NSArray<NSString *> *)originalPriceText
{
    if (self == [super init]) {
        _priceText = priceText;
        _timeText = timeText;
        _originalPriceText = originalPriceText;
    }
    return self;
}

+ (instancetype)modelWithPriceText:(NSArray<NSString *> *)priceText andtimeText:(NSArray<NSString *> *)timeText andoriginalPriceText:(NSArray<NSString *> *)originalPriceText
{
    return [[self alloc] initWithPriceText:priceText andtimeText:timeText andoriginalPriceText:originalPriceText];
}
@end
