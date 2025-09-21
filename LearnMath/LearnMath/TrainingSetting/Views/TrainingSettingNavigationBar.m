//
//  TrainingSettingNavigationBar.m
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import "TrainingSettingNavigationBar.h"

@implementation TrainingSettingNavigationBar

+ (UIColor *)configureNavigationViewController:(UIViewController *)vc withMathCategoryID:(NSString *)categoryID
{
    UIColor *bgColor = [super configureNavigationViewController:vc withMathCategoryID:categoryID];
    vc.title = @"Set Up Training";
    return bgColor;
}

@end
