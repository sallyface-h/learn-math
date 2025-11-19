//
//  ArithmeticAlgorithmUtil.h
//  LearnMath
//
//  Created by 基 on 2025/10/15.
//

#import <Foundation/Foundation.h>
#import "ArithmeticConstant.h"
#import "CategoryExchange.h"
#import "ArithmeticConstant.h"
@class MathQuestions;
NS_ASSUME_NONNULL_BEGIN

@interface ArithmeticAlgorithmUtil : NSObject

/// 生成算法
+ (NSDictionary *)generateWithCategory:(ArithmeticAlgorithmCategory )category digital:(NSInteger)digital;
@end

NS_ASSUME_NONNULL_END
