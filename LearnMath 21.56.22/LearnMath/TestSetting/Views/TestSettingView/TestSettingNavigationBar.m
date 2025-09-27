//
//  TestSettingNavigationBar.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingNavigationBar.h"

@implementation TestSettingNavigationBar

+ (UIColor *)configureNavigationViewController:(UIViewController *)vc withMathCategoryID:(NSString *)categoryID
{
    UIColor *bgColor = [super configureNavigationViewController:vc withMathCategoryID:categoryID];
    vc.title = @"Set Up Test";
    return bgColor;
}

@end
