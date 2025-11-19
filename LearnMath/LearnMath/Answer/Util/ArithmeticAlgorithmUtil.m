//
//  ArithmeticAlgorithmUtil.m
//  LearnMath
//
//  Created by 基 on 2025/10/15.
//

#import "ArithmeticAlgorithmUtil.h"
#import "MathQuestions.h"
#import "MathQuestionAnswer.h"
#import <math.h>

@implementation ArithmeticAlgorithmUtil

+ (NSDictionary *)generateWithCategory:(ArithmeticAlgorithmCategory )category digital:(NSInteger)digital
{
    NSMutableArray<NSNumber *> *numbers = [NSMutableArray array];
    NSMutableArray<NSNumber *> *answers = [NSMutableArray array];
    
    switch (category.type) {
#pragma mark - ➕ Addition
        case ArithmeticAlgorithmTypeAddition: {
            switch (category.skill) {
#pragma mark Make-Ten
                case ArithmeticSkillAddMakeTen: {
                    NSInteger a = 0;
                    do {
                        a = (digital <= 10) ? arc4random_uniform(4) + 6 : arc4random_uniform((uint32_t)(digital - 10)) + 11;
                    } while (a % 10 == 0);
                    
                    NSInteger c = 10;
                    if (digital > c) {
                        c = MIN(ceil(a / 10.0) * 10, digital);
                    }
                    NSInteger r1 = c - a;
                    NSInteger b = arc4random_uniform((uint32_t)(MIN(10, a) - r1)) + r1 + 1;
                    NSInteger r2 = b - r1;
                    NSInteger r3 = a + b;
                    
                    [numbers addObjectsFromArray:@[@(a), @(b), @(c)]];
                    [answers addObjectsFromArray:@[@(r1), @(r2), @(r3)]];
                    break;
                }
#pragma mark Column Vertical Form
                case ArithmeticSkillAddColumnVerticalForm: {
                    NSInteger a = arc4random_uniform((uint32_t)digital) + 1;
                    NSInteger b = arc4random_uniform((uint32_t)digital) + 1;
                    
                    NSInteger aOnes = a % 10;
                    NSInteger aTens = (a / 10) % 10;
                    NSInteger aHundreds = a / 100;
                    NSInteger bOnes = b % 10;
                    NSInteger bTens = (b / 10) % 10;
                    NSInteger bHundreds = b / 100;
                    
                    NSInteger cOnes = aOnes + bOnes;
                    NSInteger eCOnes = cOnes / 10;
                    NSInteger rCOnes = cOnes % 10;
                    
                    NSInteger cTens = aTens + bTens + eCOnes;
                    NSInteger eCTens = cTens / 10;
                    NSInteger rCTens = cTens % 10;
                    
                    NSInteger cHundreds = aHundreds + bHundreds + eCTens;
                    NSInteger eCHundreds = cHundreds / 10;
                    NSInteger rCHundreds = cHundreds % 10;
                    
                    [numbers addObjectsFromArray:@[@(aOnes), @(aTens), @(aHundreds),
                                                   @(bOnes), @(bTens), @(bHundreds)]];
                    [answers addObjectsFromArray:@[@(rCOnes), @(eCOnes),
                                                   @(rCTens), @(eCTens),
                                                   @(rCHundreds), @(eCHundreds)]];
                    break;
                }
#pragma mark Decomposition and Compensation
                case ArithmeticSkillAddDecompositionAndCompensation: {
                    NSInteger random1 = digital <= 10 ? arc4random_uniform(18) + 1 : arc4random_uniform(4) + 1;
                    NSInteger a = digital <= 10 ? (random1 >= 10 ? random1 + 1 : random1)
                                               : (random1 * 10 + arc4random_uniform(9) + 1);
                    
                    NSInteger random2 = digital <= 10 ? arc4random_uniform(18) + 1 : arc4random_uniform(4) + 1;
                    NSInteger c = digital <= 10 ? (random2 >= 10 ? random2 + 1 : random2)
                                               : (random2 * 10 + arc4random_uniform(9) + 1);
                    
                    NSInteger aOnes = a % 10;
                    NSInteger cOnes = c % 10;
                    NSInteger b = 20 - aOnes - cOnes;
                    
                    NSInteger r1 = a + b + c;
                    NSInteger aTens = a / 10;
                    NSInteger cTens = c / 10;
                    
                    NSInteger r2 = (aTens + 1) * 10;
                    NSInteger r3 = (cTens + 1) * 10;
                    NSInteger r4 = r2 - a;
                    NSInteger r5 = r3 - c;
                    
                    [numbers addObjectsFromArray:@[@(a), @(b), @(c)]];
                    [answers addObjectsFromArray:@[@(r1), @(r4), @(r5),@(r2),@(r3)]];
                    break;
                }
#pragma mark Moving The Numbers
                case ArithmeticSkillAddMovingTheNumbers: {
                    NSInteger a = digital <= 10 ? arc4random_uniform(9) + 1 : arc4random_uniform(89) + 1;
                    NSInteger c = digital <= 10 ? (10 - a) : (((a / 10) + 1) * 10 - a);
                    NSInteger b = digital <= 10 ? [self randomNumberExcluding:a inRange:NSMakeRange(1, 9)]
                                               : [self randomNumberExcluding:a inRange:NSMakeRange(1, 99)];
                    NSInteger r1 = a + b + c;
                    NSInteger r2 = a + c;
                    
                    [numbers addObjectsFromArray:@[@(a), @(b), @(c)]];
                    [answers addObjectsFromArray:@[@(r1), @(c), @(b), @(r2)]];
                    break;
                }
#pragma mark Finding Base Number
                case ArithmeticSkillAddFindingTheBaseNumber: {
                    NSInteger base = digital <= 10 ? 10 : (arc4random_uniform(9) + 1) * 10;
                    NSInteger a = base + arc4random_uniform(5) + 1;
                    NSInteger b = base + arc4random_uniform(5) + 1;
                    NSInteger c = base + arc4random_uniform(5) + 1;
                    
                    NSInteger r1 = a + b + c;
                    NSInteger r2 = a - base;
                    NSInteger r3 = b - base;
                    NSInteger r4 = c - base;
                    NSInteger r5 = r2 + r3 + r4;
                    NSInteger d = base * 3;
                    
                    [numbers addObjectsFromArray:@[@(a), @(b), @(c), @(d), @(base)]];
                    [answers addObjectsFromArray:@[@(r1), @(r2), @(r3), @(r4), @(r5)]];
                    break;
                }
                default:
                    break;
            }
            break;
        }
#pragma mark - ➖ Subtraction
        case ArithmeticAlgorithmTypeSubtraction: {
            switch (category.skill) {
                case ArithmeticSkillSubBreakTen: {
                    NSInteger random = (digital <= 10) ? 20 : (arc4random_uniform(7) + 3) * 10;
                    NSInteger a = random + (arc4random_uniform(9) + 1);
                    NSInteger c = random;
                    NSInteger r1 = a - c;

                    NSInteger (^calR2)(NSInteger) = ^NSInteger(NSInteger r1){
                        NSInteger r2;
                        if (digital <= 10) {
                            r2 = arc4random_uniform(9) + 1;
                        } else {
                            r2 = arc4random_uniform((uint32_t)(19 - r1 + 1)) + (11 - r1);
                        }
                        if ((r2 + r1) % 10 == 0) {
                            return calR2(r1);
                        }
                        return r2;
                    };
                    NSInteger r2 = calR2(r1);
                    NSInteger b = r1 + r2;
                    NSInteger r3 = a - b;
                    
                    [numbers addObjectsFromArray:@[@(a), @(b), @(c)]];
                    [answers addObjectsFromArray:@[@(r1), @(r2), @(r3)]];
                    break;
                }
                case ArithmeticSkillSubColumnVerticalForm: {
                    NSInteger a = (digital <= 10) ? (arc4random_uniform(10) + 1) : (arc4random_uniform((uint32_t)(digital - 11 + 1)) + 11);
                    NSInteger b = (digital <= 10) ? (arc4random_uniform((uint32_t)a) + 1) : (arc4random_uniform((uint32_t)a - 11 + 1) + 11);

                    NSInteger aOnes = a % 10;
                    NSInteger aTens = (a / 10) % 10;
                    NSInteger aHundreds = a / 100;

                    NSInteger bOnes = b % 10;
                    NSInteger bTens = (b / 10) % 10;
                    NSInteger bHundreds = b / 100;

                    NSInteger cOnes = aOnes - bOnes;
                    NSInteger eCOnes = (cOnes < 0) ? -1 : 0;
                    NSInteger rCOnes = (eCOnes < 0) ? (10 - labs(cOnes)) : cOnes;

                    NSInteger cTens = (aTens - ((eCOnes < 0) ? 1 : 0)) - bTens;
                    NSInteger eCTens = (cTens < 0) ? -1 : 0;
                    NSInteger rCTens = (eCTens < 0) ? (10 - labs(cTens)) : cTens;

                    NSInteger cHundreds = (aHundreds - ((eCTens < 0) ? 1 : 0)) - bHundreds;
                    NSInteger eCHundreds = (cHundreds < 0) ? -1 : 0;
                    NSInteger rCHundreds = (eCHundreds < 0) ? (10 - labs(cHundreds)) : cHundreds;

                    [numbers addObjectsFromArray:@[@(aOnes), @(aTens), @(aHundreds), @(bOnes), @(bTens), @(bHundreds)]];
                    [answers addObjectsFromArray:@[@(rCOnes), @(eCOnes), @(rCTens), @(eCTens), @(rCHundreds), @(eCHundreds)]];
                    
                    break;
                }
                case ArithmeticSkillSubMovingTheNumbers: {
                    NSInteger a = (digital <= 10) ? (arc4random_uniform(9) + 11) : (arc4random_uniform(79) + 21);
                    NSInteger c = (digital <= 10) ? (a - 10) : (a - ((a / 10 - 1) * 10));
                    NSInteger b = (digital <= 10)
                        ? [self randomNumberExcluding:c aNumber:a inRange:NSMakeRange(1, 9)]
                        : [self randomNumberExcluding:c aNumber:a inRange:NSMakeRange(1, ((a / 10 - 1) * 10))];
                    NSInteger r1 = a - b - c;
                    NSInteger r2 = c;
                    NSInteger r3 = b;
                    NSInteger r4 = a - c;
                    [numbers addObjectsFromArray:@[@(a), @(b), @(c)]];
                    [answers addObjectsFromArray:@[@(r1), @(r2), @(r3), @(r4)]];
                    break;
                }
                case ArithmeticSkillSubMakingUpInteral: {
                    NSInteger c = (digital <= 10) ? (arc4random_uniform(9) + 11) : (arc4random_uniform((uint32_t)(digital - 21)) + 21);
                    NSInteger r2 = (c / 10) * 10 + 10;
                    NSInteger b = r2 - c;
                    NSInteger a = (digital <= 10) ? (arc4random_uniform(30 - (r2 + 1) + 1) + (r2 + 1)) : (arc4random_uniform((digital + 10) - (r2 + 1) + 1) + (r2 + 1));
                    NSInteger r1 = a - b - c;
                    
                    [numbers addObjectsFromArray:@[@(a), @(b), @(c)]];
                    [answers addObjectsFromArray:@[@(r1), @(r2)]];
                    break;
                }
                default:
                    break;
            }
            break;
        }
#pragma mark - ✖ Multiplication
        case ArithmeticAlgorithmTypeMultiplication: {
            switch (category.skill) {
                case ArithmeticSkillMulMultiplicationTable: {
                    NSInteger a = arc4random_uniform(9) + 1;
                    NSInteger b = arc4random_uniform(9) + 1;
                    NSInteger r1 = a * b;
                    [numbers addObjectsFromArray:@[@(a), @(b)]];
                    [answers addObject:@(r1)];
                    break;
                }
                case ArithmeticSkillMulColumnVerticalForm: {
                    NSInteger a = (digital <= 10) ? (arc4random_uniform(10) + 10) : (arc4random_uniform((uint32_t)(digital - 20)) + 20);
                    NSInteger b = (digital <= 10) ? (arc4random_uniform(10) + 10) : (arc4random_uniform((uint32_t)(digital - 20)) + 20);

                    NSInteger aOnes = a % 10;
                    NSInteger aTens = (a / 10) % 10;

                    NSInteger bOnes = b % 10;
                    NSInteger bTens = (b / 10) % 10;

                    NSInteger onesMul = bOnes * aOnes;
                    NSInteger eOnesMul = onesMul / 10;
                    NSInteger rOnesMul = onesMul % 10;

                    NSInteger tensMul = bOnes * aTens + eOnesMul;
                    NSInteger eTensMul = tensMul / 10;
                    NSInteger rTensMul = tensMul % 10;

                    NSInteger r1 = rOnesMul;
                    NSInteger r2 = rTensMul;
                    NSInteger r3 = eTensMul;

                    NSInteger ones1Mul = bTens * aOnes;
                    NSInteger eOnes1Mul = ones1Mul / 10;
                    NSInteger rOnes1Mul = ones1Mul % 10;

                    NSInteger tens1Mul = bTens * aTens + eOnes1Mul;
                    NSInteger eTens1Mul = tens1Mul / 10;
                    NSInteger rTens1Mul = tens1Mul % 10;

                    NSInteger r4 = rOnes1Mul;
                    NSInteger r5 = rTens1Mul;
                    NSInteger r6 = eTens1Mul;

                    NSInteger result = a * b;
                    NSInteger r7 = result % 10;
                    NSInteger r8 = (result / 10) % 10;
                    NSInteger r9 = (result / 100) % 10;
                    NSInteger r10 = (result / 1000) % 10;

                    [numbers addObjectsFromArray:@[@(aOnes), @(aTens), @(bOnes), @(bTens)]];
                    [answers addObjectsFromArray:@[@(r1), @(r2), @(r3), @(r4), @(r5), @(r6), @(r7), @(r8), @(r9), @(r10)]];
                    break;
                }
                case ArithmeticSkillMulEveralTensAndOne: {
                    NSInteger a = arc4random_uniform(9) + 1;
                    NSInteger b = arc4random_uniform(9) + 1;

                    NSInteger c = a + b;
                    NSInteger eC = c / 10;
                    NSInteger rC = c % 10;

                    NSInteger r1 = rC;

                    NSInteger pre = a * b + eC;
                    NSInteger r2 = pre % 10;
                    NSInteger r3 = (pre / 10) % 10;
                    NSInteger r4 = eC;

                    [numbers addObjectsFromArray:@[@(a), @(b)]];
                    [answers addObjectsFromArray:@[@(r1), @(r2), @(r3), @(r4)]];
                    break;
                }
                case ArithmeticSkillMulDecomposingTerms: {
                    NSInteger random = (arc4random_uniform(9) + 1) * 10;
                    NSInteger a = random + (arc4random_uniform(9) + 1);
                    NSInteger b = arc4random_uniform(8) + 2;

                    NSInteger r1 = a * b;
                    NSInteger r2 = random;
                    NSInteger r3 = a - r2;
                    NSInteger r4 = r2 * b;
                    NSInteger r5 = r3 * b;
                    
                    [numbers addObjectsFromArray:@[@(a), @(b)]];
                    [answers addObjectsFromArray:@[@(r1), @(r2), @(r3), @(r4), @(r5)]];
                    break;
                }
                default:
                    break;
            }
            break;
        }
#pragma mark - ➗ Division
        case ArithmeticAlgorithmTypeDivision: {
            switch (category.skill) {
                case ArithmeticSkillDivMultiplicationTable: {
                    NSInteger a = arc4random_uniform(9) + 1;
                    NSInteger b = arc4random_uniform(9) + 1;
                    NSInteger r1 = a * b;

                    [numbers addObjectsFromArray:@[@(r1), @(a)]];
                    [answers addObject:@(b)];
                    break;
                }
                case ArithmeticSkillDivVerticalForm: {
                    NSInteger random = arc4random_uniform(4) + 1;
                    NSInteger result = random * 10 + (arc4random_uniform(9) + 1);
                    NSInteger bVertical = 100 / result;
                    if (bVertical != 2) {
                        bVertical = arc4random_uniform((uint32_t)(bVertical - 1)) + 2;
                    }
                    NSInteger aVertical = result * bVertical;

                    NSInteger aOnes = aVertical % 10;
                    NSInteger aTens = (aVertical / 10) % 10;

                    NSInteger r1Vertical = aTens / bVertical;
                    NSInteger r2Vertical = bVertical * r1Vertical;
                    NSInteger r3Vertical = aTens % bVertical;
                    NSInteger r4Vertical = aOnes;
                    NSInteger r5Vertical = r3Vertical;
                    NSInteger r6Vertical = r4Vertical;
                    NSInteger r7Vertical = (r5Vertical * 10 + r6Vertical) / bVertical;

                    [numbers addObjectsFromArray:@[@(aOnes), @(aTens), @(bVertical)]];
                    [answers addObjectsFromArray:@[@(r1Vertical), @(r2Vertical), @(r3Vertical), @(r4Vertical), @(r5Vertical), @(r6Vertical), @(r7Vertical)]];
                    break;
                }
                case ArithmeticSkillDividedBy5Or25: {
                    NSInteger a;
                    if (digital <= 10) {
                        a = (arc4random_uniform(431) + 60);
                        a = a - (a % 10);
                    } else {
                        a = (arc4random_uniform(2301) + 100);
                        a = a - (a % 100);
                    }

                    NSInteger b = (digital <= 10) ? 5 : 25;
                    NSInteger r1 = a / b;
                    NSInteger r2 = (digital <= 10) ? 10 : 100;
                    NSInteger r3 = (digital <= 10) ? 2 : 4;

                    [numbers addObjectsFromArray:@[@(a), @(b)]];
                    [answers addObjectsFromArray:@[@(r1), @(r2), @(r3)]];
                    break;
                }
                case ArithmeticSkillDivDecomposingTerms: {
                    NSInteger b = arc4random_uniform(8) + 2;
                    NSInteger r1 = 10 * b;
                    NSInteger r2 = (arc4random_uniform(9) + 1) * b;
                    NSInteger a = r1 + r2;
                    NSInteger r3 = r1 / b;
                    NSInteger r4 = r2 / b;
                    
                    NSInteger r = a / b;
                    
                    [numbers addObjectsFromArray:@[@(a), @(b)]];
                    [answers addObjectsFromArray:@[@(r), @(r1), @(r2), @(r3), @(r4)]];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    return @{
            @"numbers": numbers,
            @"answers": answers
        };
}

+ (NSInteger)randomNumberExcluding:(NSInteger)exclude
                            aNumber:(NSInteger)aNumber
                            inRange:(NSRange)range
{
    if (range.length == 0) {
        range = NSMakeRange(1, 9);
    }
    
    NSMutableArray<NSNumber *> *availableNumbers = [NSMutableArray array];
    for (NSInteger i = range.location; i <= range.location + range.length; i++) {
        if (i != exclude) {
            [availableNumbers addObject:@(i)];
        }
    }
    
    if (availableNumbers.count == 0) {
        return 0;
    }
    
    NSInteger randomIndex = arc4random_uniform((uint32_t)availableNumbers.count);
    NSInteger availableNumber = [availableNumbers[randomIndex] integerValue];
    
    if (((aNumber - availableNumber) % 10 == 0) || availableNumber == exclude) {
        return [self randomNumberExcluding:exclude aNumber:aNumber inRange:range];
    }
    
    return availableNumber;
}

+ (NSInteger)randomNumberExcluding:(NSInteger)exclude inRange:(NSRange)range {
    // 默认范围 1...9
    if (range.length == 0) {
        range = NSMakeRange(1, 9);
    }
    
    NSMutableArray<NSNumber *> *availableNumbers = [NSMutableArray array];
    for (NSInteger i = range.location; i <= range.location + range.length; i++) {
        if (i != exclude) {
            [availableNumbers addObject:@(i)];
        }
    }
    
    if (availableNumbers.count == 0) {
        return 0;
    }
    
    NSInteger randomIndex = arc4random_uniform((uint32_t)availableNumbers.count);
    NSInteger availableNumber = [availableNumbers[randomIndex] integerValue];
    
    // 如果 exclude + availableNumber 能凑整，则重新计算
    if (((exclude + availableNumber) % 10 == 0) || availableNumber == exclude) {
        return [self randomNumberExcluding:exclude inRange:range];
    }
    
    return availableNumber;
}
@end
