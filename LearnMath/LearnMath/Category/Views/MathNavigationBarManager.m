//
//  MathNavigationBarManager.m
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import "MathNavigationBarManager.h"

@implementation MathNavigationBarManager
+(UIColor *)configureNavigationViewController:(UICollectionViewController *) vc withMathCategory:(mathCategory)category
{
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    appearance.titleTextAttributes = @{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0],
        NSForegroundColorAttributeName: [UIColor colorForSet:ColorSetWhite]
    };
    appearance.backButtonAppearance.normal.backgroundImage = [UIImage imageNamed:@"back"];
    appearance.shadowColor = [UIColor clearColor]; 
    UIColor *bgcolor;
    switch (category)
    {
        case mathCategoryAddition:
            vc.title = @"Addition";
            appearance.backgroundColor = [UIColor colorForSet:ColorSetDeepOrange];
            break;
        case mathCategorySubtraction:
            vc.title = @"Subtraction";
            appearance.backgroundColor = [UIColor colorForSet:ColorSetOrange];
            break;
        case mathCategoryMultiplication:
            vc.title = @"Multiplication";
            appearance.backgroundColor = [UIColor colorForSet:ColorSetBlue];
            
            break;
        case mathCategoryDivision:
            vc.title = @"Division";
            appearance.backgroundColor = [UIColor colorForSet:ColorSetGreen];
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
