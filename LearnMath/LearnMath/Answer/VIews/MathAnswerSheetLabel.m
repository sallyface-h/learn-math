//
//  MathAnswerSheetLabel.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetLabel.h"

@implementation MathAnswerSheetLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        //自动缩小字体适应宽度
        self.adjustsFontSizeToFitWidth = YES;
        //缩小字体比例下限
        self.minimumScaleFactor = 0.9;
    }
    return self;
}

@end
