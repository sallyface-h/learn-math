//
//  MathAnswerSheetInputItem.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetInputItem.h"

@implementation MathAnswerSheetInputItem
- (instancetype)initWithType:(MathAnswerSheetInputType)type number:(NSString *)number {
    if (self = [super init]) {
        _type = type;
        _number = [number copy];
    }
    return self;
}
@end
