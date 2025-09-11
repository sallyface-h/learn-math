//
//  TestSettingNavigationBar.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingNavigationBar.h"

@implementation TestSettingNavigationBar

+ (UIColor *)configureNavigationViewController:(UIViewController *)vc withMathCategory:(MathCategory)category
{
    UIColor *bgColor = [super configureNavigationViewController:vc withMathCategory:category];
    vc.title = @"Set Up Test";
    return bgColor;
}

@end
