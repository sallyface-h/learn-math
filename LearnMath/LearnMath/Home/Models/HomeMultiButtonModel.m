//
//  HomeMultiButtonModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/6.
//

#import "HomeMultiButtonModel.h"

@implementation HomeMultiButtonModel
-(instancetype)initWithImage:(NSArray <NSString *> *)imgName andColor:(UIColor *)color andCategory:(NSArray<NSNumber *> *)category
{
    if (self == [super init]) {
        _imgName = imgName;
        _color = color;
        _category =category;
    }
    return self;
}

-(MathCategory)categoryAtIndex:(NSInteger)index {
    return (MathCategory)[self.category[index] integerValue];
}

+(NSArray<HomeMultiButtonModel*> *)multiButtonModelMake{
    return @[
        [[HomeMultiButtonModel alloc] initWithImage:@[@"nil",@"home_history"] andColor:[UIColor colorForSet:ColorSetPink] andCategory:@[@(MathCategoryTest),@(MathCategoryHistory)]],
        [[HomeMultiButtonModel alloc] initWithImage:@[@"home_date",@"home_help",@"home_setting",@"home_subscription"] andColor:[UIColor colorForSet:ColorSetPurple] andCategory:@[@(MathCategoryDate),@(MathCategoryHelp),@(MathCategorySetting),@(MathCategorySubtraction)]]
    ];
}
@end
