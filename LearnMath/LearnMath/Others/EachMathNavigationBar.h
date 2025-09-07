//
//  EachMathNavigationBar.h
//  LearnMath
//
//  Created by 基 on 2025/9/5.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
#import "ArithmeticConstant.h"
#import "UIFont+UIFont_Appearance.h"
#import "UIColor+UIColor_Appearance.h"
NS_ASSUME_NONNULL_BEGIN

@interface EachMathNavigationBar : UINavigationBar
@property (nonatomic, assign) CGFloat additionalHeight;
+(UIColor *)configureNavigationViewController:(UIViewController *) vc withMathCategory:(MathCategory)category;

@end

NS_ASSUME_NONNULL_END
