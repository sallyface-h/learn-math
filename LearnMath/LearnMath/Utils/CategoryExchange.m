//
//  CategoryExchange.m
//  LearnMath
//
//  Created by 基 on 2025/10/13.
//

#import "CategoryExchange.h"

@implementation CategoryExchange
+ (MathCategory)mathCategoryForID:(NSString *)categoryID
{
    NSDictionary<NSString *, NSNumber *> *mapping = @{
        @"caa56389-602f-4624-b81d-cbe0e7dd20a5" : @(MathCategoryAddition),
        @"b740d3e1-0d4e-4e38-9bd0-bb1a52113df3" : @(MathCategorySubtraction),
        @"121bae5f-0c9a-4d93-ba4b-c73ce9d58004" : @(MathCategoryMultiplication),
        @"0e47f809-13af-4824-a7b8-00cdab5aa467" : @(MathCategoryDivision),
        @"f89a6d93-4ca4-4c3c-9d31-bfcdccaffeea" : @(MathCategoryTest),
        @"0e9aace6-388b-4652-9a72-bb9e8d75eef3" : @(MathCategoryHistory),
        @"65f3d104-01f6-4cc8-8aeb-2e0e25447a3a" : @(MathCategoryData),
        @"3464d214-1e65-46e8-ba77-1dba2a2b19b6" : @(MathCategoryHelp),
        @"ae3f8481-8616-4b12-a144-f62b3447ef75" : @(MathCategorySetting),
        @"8e827711-2a28-465c-a1b8-d174aaa46351" : @(MathCategorySubscription)
    };
    return [mapping[categoryID] integerValue];
}

+ (ArithmeticAlgorithmCategory)algorithmCategoryForBankID:(NSString *)bankID
{
    // 默认返回值
    ArithmeticAlgorithmCategory category = { ArithmeticAlgorithmTypeAddition, ArithmeticSkillAddMakeTen };

    // 加法
    NSDictionary *addMapping = @{
        @"96a51b91-d079-4ec8-9a46-ba0cf1da14fc" : @(ArithmeticSkillAddMakeTen),
        @"770b6bc4-3d16-4fc9-9ce9-c43c1f8ff7ef" : @(ArithmeticSkillAddColumnVerticalForm),
        @"b88aa1d2-c9da-4932-bd33-2930c919eae9" : @(ArithmeticSkillAddDecompositionAndCompensation),
        @"5efdf943-d75e-4c4b-ad66-f39c8d8653b9" : @(ArithmeticSkillAddMovingTheNumbers),
        @"e345c800-b109-4105-ba4e-7a86e1e83bf1" : @(ArithmeticSkillAddFindingTheBaseNumber)
    };

    // 减法
    NSDictionary *subMapping = @{
        @"491c4f6b-efe7-4830-aef4-6cd3762eaab0" : @(ArithmeticSkillSubBreakTen),
        @"ab85a52e-9a07-4081-9faf-86a34bf7d8b8" : @(ArithmeticSkillSubColumnVerticalForm),
        @"f8e768d1-7e1e-44db-9820-f41d7f7cd642" : @(ArithmeticSkillSubMovingTheNumbers),
        @"7ccf63aa-f313-4809-8518-71eb292603af" : @(ArithmeticSkillSubMakingUpInteral)
    };

    // 乘法
    NSDictionary *mulMapping = @{
        @"f7627bc1-3f15-4439-a5c6-8cd7788ec68c" : @(ArithmeticSkillMulMultiplicationTable),
        @"c88fb5db-4ed6-4f97-9619-88b7a0277da5" : @(ArithmeticSkillMulColumnVerticalForm),
        @"75f83afe-a01c-4b3f-8751-97595b142ef5" : @(ArithmeticSkillMulEveralTensAndOne),
        @"86ef29a9-a895-483d-b946-26f7186ff9ab" : @(ArithmeticSkillMulDecomposingTerms)
    };

    // 除法
    NSDictionary *divMapping = @{
        @"eee00c61-f03a-4285-a726-e4965c252128" : @(ArithmeticSkillDivMultiplicationTable),
        @"021f5ee2-d346-4c0e-a7fe-cd394980044b" : @(ArithmeticSkillDivVerticalForm),
        @"d83ca152-225e-45ca-9f35-65ca683b1ac5" : @(ArithmeticSkillDividedBy5Or25),
        @"72c3dc81-4e07-42e6-af0d-52a57f108acd" : @(ArithmeticSkillDivDecomposingTerms)
    };

    if (addMapping[bankID]) {
        category.type = ArithmeticAlgorithmTypeAddition;
        category.skill = [addMapping[bankID] integerValue];
    } else if (subMapping[bankID]) {
        category.type = ArithmeticAlgorithmTypeSubtraction;
        category.skill = [subMapping[bankID] integerValue];
    } else if (mulMapping[bankID]) {
        category.type = ArithmeticAlgorithmTypeMultiplication;
        category.skill = [mulMapping[bankID] integerValue];
    } else if (divMapping[bankID]) {
        category.type = ArithmeticAlgorithmTypeDivision;
        category.skill = [divMapping[bankID] integerValue];
    }

    return category;
}

@end
