//
//  TrainingSettingNavigationBar.m
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import "TrainingSettingNavigationBar.h"

@implementation TrainingSettingNavigationBar

+ (UIColor *)configureNavigationViewController:(UIViewController *)vc withMathCategory:(MathCategory)category
{
    UIColor *bgColor = [super configureNavigationViewController:vc withMathCategory:category];
    vc.title = @"Set Up Test";
    return bgColor;
}

@end
