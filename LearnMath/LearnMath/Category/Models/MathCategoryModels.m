//
//  MathCategoryModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/7.
//

#import "MathCategoryModels.h"

@implementation MathCategoryModels
-(instancetype)initWithSkill:(NSArray<NSString *> *)skill
{
    if (self == [super init]) {
        _skill = skill;
    }
    return self;
}

+ (MathCategoryModels *)skillsModelWithCategory:(MathCategory)category
{
    NSDictionary<NSNumber *, NSArray <NSString *> *> *skillDict = @{
    @(MathCategoryAddition) : @[
        @"Column vertical form(add)",
        @"Make-Ten",@"Decomposition and compensation",
        @"Moving the numbers",
        @"Finding the base number"
    ],
    @(MathCategorySubtraction) : @[
            @"Column vertical Form(sub)",
            @"Break-Ten",
            @"Moving the numbers",
            @"Making up interal"
        ],
    @(MathCategoryMultiplication) : @[
        @"Multiplication Table",
        @"Column vertical form(mul)",
        @"Everal tens and one",
        @"Decomposing terms",
        @"Plus 5 or 25"
    ],
    @(MathCategoryDivision) : @[
        @"Division Table",
        @"Column vertical Form(sub)",
        @"Divded by 5 or 25",
        @"Decomposing terms"
    ]
};
    NSArray<NSString *> *skill = skillDict[@(category)];
    if (!skill) {
        skill = @[];
    }
    return [[MathCategoryModels alloc] initWithSkill:skill];
}
@end

