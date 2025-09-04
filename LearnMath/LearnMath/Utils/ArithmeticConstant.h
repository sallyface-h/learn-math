//
//  ArithmeticConstant.h
//  LearnMath
//
//  Created by 基 on 2025/8/29.
//

#ifndef ArithmeticConstant_h
#define ArithmeticConstant_h
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define LearnMathScale(x) x*(SCREEN_HEIGHT/812.0)
typedef NS_ENUM(NSInteger,mathCategory)
{
    mathCategoryAddition,
    mathCategorySubtraction,
    mathCategoryMultiplication,
    mathCategoryDivision
};
#endif /* ArithmeticConstant_h */
