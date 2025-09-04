//
//  MathNavigationBarManager.h
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import <Foundation/Foundation.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathNavigationBarManager : NSObject
+(UIColor *)configureNavigationViewController:(UICollectionViewController *) vc withMathCategory:(mathCategory)category;
@end

NS_ASSUME_NONNULL_END
