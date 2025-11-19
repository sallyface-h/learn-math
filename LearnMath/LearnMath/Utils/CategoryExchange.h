//
//  CategoryExchange.h
//  LearnMath
//
//  Created by 基 on 2025/10/13.
//

#import <Foundation/Foundation.h>
#import "ArithmeticConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryExchange : NSObject
+ (MathCategory)mathCategoryForID:(NSString *)categoryID;
+ (ArithmeticAlgorithmCategory)algorithmCategoryForBankID:(NSString *)bankID;
@end

NS_ASSUME_NONNULL_END
