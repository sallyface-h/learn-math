//
//  EachMathNavigationBar.m
//  LearnMath
//
//  Created by 基 on 2025/9/5.
//

#import "EachMathNavigationBar.h"
#import "MathCategoryViewController.h"

@implementation EachMathNavigationBar
+(UIColor *)configureNavigationViewController:(UIViewController *)vc withMathCategory:(MathCategory)category
{
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    appearance.titleTextAttributes = @{
        NSFontAttributeName: [UIFont balooFontOfSize:30.0 weight:UIFontWeightBold],
        NSForegroundColorAttributeName: [UIColor colorForSet:ColorSetWhite]
    };
    appearance.backgroundEffect = nil;
    appearance.shadowColor = [UIColor clearColor];
    appearance.backButtonAppearance.normal.backgroundImage = [UIImage imageNamed:@"back"];
    UIColor *bgcolor;
    switch (category)
    {
        case MathCategoryAddition:
            vc.title = @"Addition";
            appearance.backgroundColor = [UIColor colorForSet:ColorSetDeepOrange];
            break;
        case MathCategorySubtraction:
            vc.title = @"Subtraction";
            appearance.backgroundColor = [UIColor colorForSet:ColorSetOrange];
            break;
        case MathCategoryMultiplication:
            vc.title = @"Multiplication";
            appearance.backgroundColor = [UIColor colorForSet:ColorSetBlue];
            break;
        case MathCategoryDivision:
            vc.title = @"Division";
            appearance.backgroundColor = [UIColor colorForSet:ColorSetGreen];
            break;
        default:
            break;
    }
    bgcolor = appearance.backgroundColor;
    vc.navigationController.navigationBar.tintColor = [UIColor colorForSet:ColorSetWhite];
    vc.navigationController.navigationBar.standardAppearance = appearance;
    vc.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    vc.navigationController.navigationBar.compactAppearance = appearance;
    return bgcolor;
}

@end
