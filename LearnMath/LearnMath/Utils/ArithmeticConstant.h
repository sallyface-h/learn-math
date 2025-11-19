//
//  ArithmeticConstant.h
//  LearnMath
//
//  Created by 基 on 2025/8/29.
//

#ifndef ArithmeticConstant_h
#define ArithmeticConstant_h
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define LearnMathScale(x) x*(SCREEN_HEIGHT/812.0)
typedef NS_ENUM(NSInteger,MathCategory)
{
    MathCategoryAddition,
    MathCategorySubtraction,
    MathCategoryMultiplication,
    MathCategoryDivision,
    MathCategoryTest,
    MathCategoryTrain,
    MathCategoryHistory,
    MathCategorySubscription,
    MathCategorySetting,
    MathCategoryHelp,
    MathCategoryData
};

typedef NS_ENUM(NSInteger, ArithmeticAlgorithmType) {
    ArithmeticAlgorithmTypeAddition,
    ArithmeticAlgorithmTypeSubtraction,
    ArithmeticAlgorithmTypeMultiplication,
    ArithmeticAlgorithmTypeDivision
};

typedef NS_ENUM(NSInteger, ArithmeticSkillType) {
    // 加法技能
    ArithmeticSkillAddMakeTen,
    ArithmeticSkillAddColumnVerticalForm,
    ArithmeticSkillAddDecompositionAndCompensation,
    ArithmeticSkillAddMovingTheNumbers,
    ArithmeticSkillAddFindingTheBaseNumber,
    
    // 减法技能
    ArithmeticSkillSubBreakTen,
    ArithmeticSkillSubColumnVerticalForm,
    ArithmeticSkillSubMovingTheNumbers,
    ArithmeticSkillSubMakingUpInteral,
    
    // 乘法技能
    ArithmeticSkillMulMultiplicationTable,
    ArithmeticSkillMulColumnVerticalForm,
    ArithmeticSkillMulEveralTensAndOne,
    ArithmeticSkillMulDecomposingTerms,
    
    // 除法技能
    ArithmeticSkillDivMultiplicationTable,
    ArithmeticSkillDivVerticalForm,
    ArithmeticSkillDividedBy5Or25,
    ArithmeticSkillDivDecomposingTerms
};

typedef struct {
    ArithmeticAlgorithmType type;
    ArithmeticSkillType skill;
} ArithmeticAlgorithmCategory;
#endif /* ArithmeticConstant_h */
