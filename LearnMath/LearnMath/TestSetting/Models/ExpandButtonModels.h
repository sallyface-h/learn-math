//
//  ExpandButtonModels.h
//  LearnMath
//
//  Created by 基 on 2025/9/12.
//

#import <Foundation/Foundation.h>
#import "ArithmeticConstant.h"
NS_ASSUME_NONNULL_BEGIN
@class DateManagerModels;
@interface ExpandButtonModels : NSObject
@property (nonatomic, strong)NSArray <NSString *> *title;
@property (nonatomic, strong)NSArray<NSArray<NSString *> *> *skill;;

- (instancetype)initWithSingleButtonModel:(DateManagerModels *)manager;
+ (instancetype)modelWithSingleButtonModel:(DateManagerModels *)manager;
@end

NS_ASSUME_NONNULL_END
