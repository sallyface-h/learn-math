//
//  ExpandButtonModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/12.
//

#import "ExpandButtonModels.h"

@implementation ExpandButtonModels
/*- (instancetype)initWithSingleButtonModel:(DateManagerModels *)manager;
{
    if (self = [super init]) {
        
        _title = [DateManagerModels.sharedManager title];
        NSMutableArray<NSArray<NSString *> *> *skills = [NSMutableArray array];
        NSArray<NSNumber *> *category = @[
            @(MathCategoryAddition),
            @(MathCategorySubtraction),
            @(MathCategoryMultiplication),
            @(MathCategoryDivision)
        ];
        for (NSNumber *key in category) {
            NSArray<NSString *> *skillArray = [DateManagerModels.sharedManager skillDict][key];
            [skills addObject:skillArray];
            }
        _skill = [skills copy];
    }
    return self;
}

+ (instancetype)modelWithSingleButtonModel:(DateManagerModels *)manager
{
    return [[self alloc]initWithSingleButtonModel:manager];
}
*/
@end
