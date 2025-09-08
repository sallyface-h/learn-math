//
//  HomeSingleButtonModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/6.
//

#import "HomeSingleButtonModel.h"

@implementation HomeSingleButtonModel
-(instancetype)initWithTitle:(NSString *)title andImage:(NSString *)imgName andColor:(UIColor *)color andCategory:(MathCategory)category
{
    if (self == [super init]) {
        _title = title;
        _imgName = imgName;
        _color = color;
        _category = category;
    }
    return self;
}

+ (NSArray<HomeSingleButtonModel *> *)singleButtonModelMake
{
    return @[
        [[HomeSingleButtonModel alloc] initWithTitle:@"Addition" andImage:@"home_add" andColor:[UIColor colorForSet:ColorSetDeepOrange] andCategory:MathCategoryAddition],
        [[HomeSingleButtonModel alloc] initWithTitle:@"Subteaction" andImage:@"home_sub" andColor:[UIColor colorForSet:ColorSetOrange] andCategory:MathCategorySubtraction],
        [[HomeSingleButtonModel alloc] initWithTitle:@"Multiplication" andImage:@"home_mul" andColor:[UIColor colorForSet:ColorSetBlue] andCategory:MathCategoryMultiplication],
        [[HomeSingleButtonModel alloc] initWithTitle:@"Division" andImage:@"home_div" andColor:[UIColor colorForSet:ColorSetGreen] andCategory:MathCategoryDivision]
    ];
}
@end
