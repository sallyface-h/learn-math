//
//  MathAnswerSheetQuestionAddDecompositionAndCompensation.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionAddDecompositionAndCompensation.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "MathQuestionAnswer.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"

@interface MathAnswerSheetQuestionAddDecompositionAndCompensation ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plusLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plus2Label;
@property (nonatomic, strong) MathAnswerSheetLabel *cNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plus3Label;

@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *dTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *eTextField;

@end

@implementation MathAnswerSheetQuestionAddDecompositionAndCompensation

- (instancetype)initWithTask:(MathQuestionsTask *)task
                    category:(ArithmeticAlgorithmCategory )category
               isShowAnswer:(BOOL)isShowAnswer
                    bgColor:(UIColor *)bgColor
                      frame:(CGRect)frame {
    self = [super initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];
    if (self) {
        [self setupSubViews];
        [self drawLines];
    }
    return self;
}

#pragma mark - Lazy Loads

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.spacing = 0.0;
    }
    return _stackView;
}

- (MathAnswerSheetLabel *)labelWithText:(NSString *)text
{
    MathAnswerSheetLabel *label = [[MathAnswerSheetLabel alloc] init];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    return label;
}

- (MathAnswerSheetTextField *)textField
{
    UIEdgeInsets padding = UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0));
    MathAnswerSheetTextField *tf = [[MathAnswerSheetTextField alloc] initWithPadding:padding bgColor:self.bgColor];
    tf.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    return tf;
}

- (MathAnswerSheetLabel *)aNumberLabel {
    if (!_aNumberLabel) _aNumberLabel = [self labelWithText:nil];
    return _aNumberLabel;
}
- (MathAnswerSheetLabel *)plusLabel {
    if (!_plusLabel) _plusLabel = [self labelWithText:@"+"];
    return _plusLabel;
}
- (MathAnswerSheetLabel *)bNumberLabel {
    if (!_bNumberLabel) _bNumberLabel = [self labelWithText:nil];
    return _bNumberLabel;
}
- (MathAnswerSheetLabel *)plus2Label {
    if (!_plus2Label) _plus2Label = [self labelWithText:@"+"];
    return _plus2Label;
}
- (MathAnswerSheetLabel *)cNumberLabel {
    if (!_cNumberLabel) _cNumberLabel = [self labelWithText:nil];
    return _cNumberLabel;
}
- (MathAnswerSheetLabel *)equalLabel {
    if (!_equalLabel) _equalLabel = [self labelWithText:@"="];
    return _equalLabel;
}
- (MathAnswerSheetLabel *)plus3Label {
    if (!_plus3Label) _plus3Label = [self labelWithText:@"+"];
    return _plus3Label;
}

- (MathAnswerSheetTextField *)aTextField {
    if (!_aTextField) _aTextField = [self textField];
    return _aTextField;
}
- (MathAnswerSheetTextField *)bTextField {
    if (!_bTextField) _bTextField = [self textField];
    return _bTextField;
}
- (MathAnswerSheetTextField *)cTextField {
    if (!_cTextField) _cTextField = [self textField];
    return _cTextField;
}
- (MathAnswerSheetTextField *)dTextField {
    if (!_dTextField) _dTextField = [self textField];
    return _dTextField;
}
- (MathAnswerSheetTextField *)eTextField {
    if (!_eTextField) _eTextField = [self textField];
    return _eTextField;
}

#pragma mark - Override

- (void)updateTask:(MathQuestionsTask *)task {
    [super updateTask:task];
    
    CGFloat fontSize = task.question.digits >= 100 ? LearnMathScale(30.0) : LearnMathScale(35.0);
    UIFont *font = [UIFont ap_font:fontSize weight:UIFontWeightRegular];
    self.aNumberLabel.font = font;
    self.bNumberLabel.font = font;
    self.cNumberLabel.font = font;
    self.plusLabel.font = font;
    self.plus2Label.font = font;
    self.plus3Label.font = font;
    self.equalLabel.font = font;
    
    NSArray *numbers = task.question.answer.numbers;
    if (numbers.count >= 3) {
        self.aNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.bNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.cNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[2]];
    } else {
        self.aNumberLabel.text = @"";
        self.bNumberLabel.text = @"";
        self.cNumberLabel.text = @"";
    }
    
    if (self.isShowAnswer) {
        NSArray *answers = task.question.answer.answers;
        NSArray *fields = @[self.aTextField, self.bTextField, self.cTextField, self.dTextField, self.eTextField];
        for (int i = 0; i < fields.count; i++) {
            MathAnswerSheetTextField *f = fields[i];
            f.userInteractionEnabled = NO;
            f.text = i < answers.count ? [NSString stringWithFormat:@"%@", answers[i]] : @"";
            f.layer.borderColor = self.bgColor.CGColor;
            f.textColor = self.bgColor;
        }
    } else {
        self.aTextField.userInteractionEnabled = YES;
        self.bTextField.userInteractionEnabled = YES;
        self.cTextField.userInteractionEnabled = YES;
        self.dTextField.userInteractionEnabled = YES;
        self.eTextField.userInteractionEnabled = YES;
    }
}

- (void)check:(MathAnswerSheetTextField *)firstResponder {
    [super check:firstResponder];
    
    NSArray *fields = @[self.aTextField, self.bTextField, self.cTextField, self.dTextField, self.eTextField];
    for (MathAnswerSheetTextField *f in fields) {
        if (f.text.length == 0) {
         
            return;
        }
    }
    
    NSArray *answers = self.task.question.answer.answers;
    if (!answers || answers.count < 4) {
        
        return;
    }
    
    NSString *aAnswer = [NSString stringWithFormat:@"%@", answers[0]];
    NSString *bAnswer = [NSString stringWithFormat:@"%@", answers[1]];
    NSString *cAnswer = [NSString stringWithFormat:@"%@", answers[2]];
    NSString *dAnswer = [NSString stringWithFormat:@"%@", answers[3]];
    NSString *eAnswer = [NSString stringWithFormat:@"%@", answers[4]];
    
    if ([self.aTextField.text isEqualToString:aAnswer] &&
        [self.bTextField.text isEqualToString:bAnswer] &&
        [self.cTextField.text isEqualToString:cAnswer] &&
        [self.dTextField.text isEqualToString:dAnswer] &&
        [self.eTextField.text isEqualToString:eAnswer] ) {
        [self.task success];
    } else {
        [self.task failure];
    }
}

- (void)clean:(MathAnswerSheetTextField *)firstResponder {
    firstResponder.text = nil;
}

- (void)input:(NSString *)number firstResponder:(MathAnswerSheetTextField *)firstResponder {
    firstResponder.text = number;
}

#pragma mark - Private

- (void)setupSubViews {
    [self addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LearnMathScale(15.0));
        make.trailing.equalTo(self).offset(-LearnMathScale(1.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LearnMathScale(15.0));
        make.height.mas_equalTo(LearnMathScale(48.0));
        make.leading.equalTo(self).offset(LearnMathScale(1.0));
        make.trailing.equalTo(self.aTextField.mas_leading);
    }];
    
    [self.stackView addArrangedSubview:self.aNumberLabel];
    [self.stackView addArrangedSubview:self.plusLabel];
    [self.stackView addArrangedSubview:self.bNumberLabel];
    [self.stackView addArrangedSubview:self.plus2Label];
    [self.stackView addArrangedSubview:self.cNumberLabel];
    [self.stackView addArrangedSubview:self.equalLabel];
    
    [self addSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bNumberLabel.mas_bottom).offset(LearnMathScale(46.0));
        make.trailing.equalTo(self.bNumberLabel.mas_centerX).offset(-LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.bTextField];
    
    [self addSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bNumberLabel.mas_bottom).offset(LearnMathScale(46.0));
        make.leading.equalTo(self.bNumberLabel.mas_centerX).offset(LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.cTextField];
    
    [self addSubview:self.dTextField];
    [self.dTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-LearnMathScale(8.0));
        make.trailing.equalTo(self.bTextField.mas_leading).offset(LearnMathScale(5.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.dTextField];
    
    [self addSubview:self.plus3Label];
    [self.plus3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dTextField);
        make.centerX.equalTo(self.bNumberLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    
    [self addSubview:self.eTextField];
    [self.eTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dTextField);
        make.leading.equalTo(self.cTextField.mas_trailing).offset(-LearnMathScale(5.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.eTextField];
    
    if (!self.isShowAnswer) {
        [self.bTextField becomeFirstResponder];
    }
}

- (void)drawLines {
    [self layoutIfNeeded];
    
    void (^addLine)(UIBezierPath *) = ^(UIBezierPath *path) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
        layer.fillColor = UIColor.clearColor.CGColor;
        layer.lineCap = kCALineCapRound;
        layer.lineJoin = kCALineJoinRound;
        layer.lineWidth = LearnMathScale(5.5);
        [self.layer addSublayer:layer];
    };
    
    UIBezierPath *firstLinePath = [UIBezierPath bezierPath];
    [firstLinePath moveToPoint:CGPointMake(self.aNumberLabel.center.x, CGRectGetMaxY(self.aNumberLabel.frame)+LearnMathScale(9.0))];
    [firstLinePath addLineToPoint:CGPointMake(self.dTextField.center.x, self.dTextField.frame.origin.y - LearnMathScale(9.0))];
    addLine(firstLinePath);
    
    UIBezierPath *secondLinePath = [UIBezierPath bezierPath];
    [secondLinePath moveToPoint:CGPointMake(self.cNumberLabel.center.x, CGRectGetMaxY(self.cNumberLabel.frame) + 9.0)];
    [secondLinePath addLineToPoint:CGPointMake(self.eTextField.center.x, self.eTextField.frame.origin.y - LearnMathScale(9.0))];
    addLine(secondLinePath);
    
    CGFloat startX = self.bNumberLabel.center.x - LearnMathScale(9.0);
    CGFloat startY = CGRectGetMaxY(self.bNumberLabel.frame) + LearnMathScale(9.0);
    CGFloat endX = self.dTextField.center.x + LearnMathScale(9.0);
    CGFloat endY = self.dTextField.frame.origin.y - LearnMathScale(9.0);
    
    UIBezierPath *thirdLinePath = [UIBezierPath bezierPath];
    [thirdLinePath moveToPoint:CGPointMake(startX, startY)];
    [thirdLinePath addLineToPoint:CGPointMake(endX + (startX - endX) * 0.73, startY + (endY - startY) * 0.27)];
    addLine(thirdLinePath);
    
    UIBezierPath *fourthLinePath = [UIBezierPath bezierPath];
    [fourthLinePath moveToPoint:CGPointMake(endX + (startX - endX) * 0.32, startY + (endY - startY) * 0.68)];
    [fourthLinePath addLineToPoint:CGPointMake(endX, endY)];
    addLine(fourthLinePath);
    
    CGFloat start1X = self.bNumberLabel.center.x + LearnMathScale(9.0);
    CGFloat start1Y = CGRectGetMaxY(self.bNumberLabel.frame) + LearnMathScale(9.0);
    CGFloat end1X = self.eTextField.center.x - LearnMathScale(9.0);
    CGFloat end1Y = self.eTextField.frame.origin.y - LearnMathScale(9.0);
    
    UIBezierPath *fifthLinePath = [UIBezierPath bezierPath];
    [fifthLinePath moveToPoint:CGPointMake(start1X, start1Y)];
    [fifthLinePath addLineToPoint:CGPointMake(end1X + (start1X - end1X) * 0.73, start1Y + (end1Y - start1Y) * 0.27)];
    addLine(fifthLinePath);
    
    UIBezierPath *sixthLinePath = [UIBezierPath bezierPath];
    [sixthLinePath moveToPoint:CGPointMake(end1X + (start1X - end1X) * 0.32, start1Y + (end1Y - start1Y) * 0.68)];
    [sixthLinePath addLineToPoint:CGPointMake(end1X, end1Y)];
    addLine(sixthLinePath);
}

@end
