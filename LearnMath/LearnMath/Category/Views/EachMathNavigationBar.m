//
//  EachMathNavigationBar.m
//  LearnMath
//
//  Created by 基 on 2025/9/5.
//

#import "EachMathNavigationBar.h"
#import "MathCategoryViewController.h"

@implementation EachMathNavigationBar
+(UIColor *)configureNavigationViewController:(UIViewController *)vc withMathCategoryID:(NSString *)categoryID
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
    if ([categoryID isEqualToString:@"caa56389-602f-4624-b81d-cbe0e7dd20a5"]) {
         vc.title = @"Addition";
         appearance.backgroundColor = [UIColor colorForSet:ColorSetDeepOrange];
     }
     else if ([categoryID isEqualToString:@"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3"]) {
         vc.title = @"Subtraction";
         appearance.backgroundColor = [UIColor colorForSet:ColorSetOrange];
     }
     else if ([categoryID isEqualToString:@"121bae5f-0c9a-4d93-ba4b-c73ce9d58004"]) {
         vc.title = @"Multiplication";
         appearance.backgroundColor = [UIColor colorForSet:ColorSetBlue];
     }
     else if ([categoryID isEqualToString:@"0e47f809-13af-4824-a7b8-00cdab5aa467"]) {
         vc.title = @"Division";
         appearance.backgroundColor = [UIColor colorForSet:ColorSetGreen];
     }
     else if ([categoryID isEqualToString:@"f89a6d93-4ca4-4c3c-9d31-bfcdccaffeea"] ||
              [categoryID isEqualToString:@"0e9aace6-388b-4652-9a72-bb9e8d75eef3"]) {
         appearance.backgroundColor = [UIColor colorForSet:ColorSetPink];
     }
     else if ([categoryID isEqualToString:@"65f3d104-01f6-4cc8-8aeb-2e0e25447a3a"] ||
              [categoryID isEqualToString:@"3464d214-1e65-46e8-ba77-1dba2a2b19b6"] ||
              [categoryID isEqualToString:@"ae3f8481-8616-4b12-a144-f62b3447ef75"] ||
              [categoryID isEqualToString:@"8e827711-2a28-465c-a1b8-d174aaa46351"]) {
         appearance.backgroundColor = [UIColor colorForSet:ColorSetPurple];
     }
    bgcolor = appearance.backgroundColor;
    vc.navigationController.navigationBar.tintColor = [UIColor colorForSet:ColorSetWhite];
    vc.navigationController.navigationBar.standardAppearance = appearance;
    vc.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    vc.navigationController.navigationBar.compactAppearance = appearance;
    return bgcolor;
}

@end
