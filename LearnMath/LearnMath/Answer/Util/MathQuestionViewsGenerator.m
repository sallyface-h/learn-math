//
//  MathQuestionViewsGenerator.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathQuestionViewsGenerator.h"
#import "ArithmeticConstant.h"
#import "MathQuestionAnswer.h"
#import "MathQuestions.h"
#import "MathQuestionsTask.h"
// 加法题型
#import "MathAnswerSheetQuestionAddMakeTenView.h"
#import "MathAnswerSheetQuestionAddColumnVerticalFormView.h"
#import "MathAnswerSheetQuestionAddDecompositionAndCompensation.h"
#import "MathAnswerSheetQuestionAddMovingTheNumbers.h"
#import "MathAnswerSheetQuestionAddFindingTheBaseNumberView.h"

// 减法题型
#import "MathAnswerSheetQuestionSubBreakTenView.h"
#import "MathAnswerSheetQuestionSubColumnVerticalFormView.h"
#import "MathAnswerSheetQuestionSubMovingTheNumbersView.h"
#import "MathAnswerSheetQuestionSubMakingUpInteralView.h"

// 乘法题型
#import "MathAnswerSheetQuestionMultiplicationTableView.h"
#import "MathAnswerSheetQuestionMulColumnVerticalFormTableView.h"
#import "MathAnswerSheetQuestionMulEveralTensAndOneView.h"
#import "MathAnswerSheetQuestionMulDecomposingTermsView.h"

// 除法题型
#import "MathAnswerSheetQuestionDivMultiplicationTableView.h"
#import "MathAnswerSheetQuestionDivVerticalFormTableView.h"
#import "MathAnswerSheetQuestionDividedBy5Or25View.h"
#import "MathAnswerSheetQuestionDivDecomposingTermsView.h"
@implementation MathQuestionViewsGenerator
+ (nullable MathAnswerSheetQuestionBaseView *)generateWithTask:(MathQuestionsTask *)task
                                                       bgColor:(nullable UIColor *)bgColor
                                                  isShowAnswer:(BOOL)isShowAnswer
                                                         frame:(CGRect)frame
{
    NSString *bankID = task.question.bankID;
    ArithmeticAlgorithmCategory category = [CategoryExchange algorithmCategoryForBankID:bankID];
    NSLog(@"bankID: %@, category.type: %ld, category.skill: %ld", task.question.bankID, category.type, category.skill);
    switch (category.type) {
            case ArithmeticAlgorithmTypeAddition: {
                switch (category.skill) {
                    case ArithmeticSkillAddMakeTen:
                        return [[MathAnswerSheetQuestionAddMakeTenView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    case ArithmeticSkillAddColumnVerticalForm:
                        return [[MathAnswerSheetQuestionAddColumnVerticalFormView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    case ArithmeticSkillAddDecompositionAndCompensation:
                        return [[MathAnswerSheetQuestionAddDecompositionAndCompensation alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    case ArithmeticSkillAddMovingTheNumbers:
                        return [[MathAnswerSheetQuestionAddMovingTheNumbers alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    case ArithmeticSkillAddFindingTheBaseNumber:
                        return [[MathAnswerSheetQuestionAddFindingTheBaseNumberView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor
                            frame:CGRectMake(0, 0,
                                             frame.size.width + LearnMathScale(27.5) * 2.0,
                                             frame.size.height + LearnMathScale(23.5) * 2.0)];
                    default:
                        break;
                }
                break;
            }

            case ArithmeticAlgorithmTypeSubtraction: {
                switch (category.skill) {
                    case ArithmeticSkillSubBreakTen:
                        return [[MathAnswerSheetQuestionSubBreakTenView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    case ArithmeticSkillSubColumnVerticalForm:
                        return [[MathAnswerSheetQuestionSubColumnVerticalFormView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    case ArithmeticSkillSubMovingTheNumbers:
                        return [[MathAnswerSheetQuestionSubMovingTheNumbersView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    case ArithmeticSkillSubMakingUpInteral:
                        return [[MathAnswerSheetQuestionSubMakingUpInteralView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    default:
                        break;
                }
                break;
            }

            case ArithmeticAlgorithmTypeMultiplication: {
                switch (category.skill) {
                    case ArithmeticSkillMulMultiplicationTable:
                        return [[MathAnswerSheetQuestionMultiplicationTableView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    case ArithmeticSkillMulColumnVerticalForm:
                        return [[MathAnswerSheetQuestionMulColumnVerticalFormTableView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor
                            frame:CGRectMake(0, 0,
                                             frame.size.width + LearnMathScale(27.5) * 2.0,
                                             frame.size.height + LearnMathScale(23.5) * 2.0)];

                    case ArithmeticSkillMulEveralTensAndOne:
                        return [[MathAnswerSheetQuestionMulEveralTensAndOneView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor
                            frame:CGRectMake(0, 0,
                                             frame.size.width + LearnMathScale(27.5) * 2.0,
                                             frame.size.height + LearnMathScale(23.5) * 2.0)];

                    case ArithmeticSkillMulDecomposingTerms:
                        return [[MathAnswerSheetQuestionMulDecomposingTermsView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor
                            frame:CGRectMake(0, 0,
                                             frame.size.width + LearnMathScale(27.5) * 2.0,
                                             frame.size.height + LearnMathScale(23.5) * 2.0)];

                    default:
                        break;
                }
                break;
            }

            case ArithmeticAlgorithmTypeDivision: {
                switch (category.skill) {
                    case ArithmeticSkillDivMultiplicationTable:
                        return [[MathAnswerSheetQuestionDivMultiplicationTableView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];

                    case ArithmeticSkillDivVerticalForm:
                        return [[MathAnswerSheetQuestionDivVerticalFormTableView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor
                            frame:CGRectMake(0, 0,
                                             frame.size.width + LearnMathScale(27.5) * 2.0,
                                             frame.size.height + LearnMathScale(23.5) * 2.0)];

                    case ArithmeticSkillDividedBy5Or25:
                        return [[MathAnswerSheetQuestionDividedBy5Or25View alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor
                            frame:CGRectMake(0, 0,
                                             frame.size.width + LearnMathScale(27.5) * 2.0,
                                             frame.size.height + LearnMathScale(23.5) * 2.0)];

                    case ArithmeticSkillDivDecomposingTerms:
                        return [[MathAnswerSheetQuestionDivDecomposingTermsView alloc]
                            initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor
                            frame:CGRectMake(0, 0,
                                             frame.size.width + LearnMathScale(27.5) * 2.0,
                                             frame.size.height + LearnMathScale(23.5) * 2.0)];

                    default:
                        break;
                }
                break;
            }

            default:
                break;
        }

        return nil;

}

@end
