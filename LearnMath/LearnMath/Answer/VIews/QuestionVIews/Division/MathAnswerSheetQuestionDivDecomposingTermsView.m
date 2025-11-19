//
//  MathAnswerSheetQuestionDivDecomposingTermsView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionDivDecomposingTermsView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionDivDecomposingTermsView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *divLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetLabel *bTensLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;
@property (nonatomic, strong) MathAnswerSheetLabel *div2Label;
@property (nonatomic, strong) MathAnswerSheetLabel *div3Label;
@property (nonatomic, strong) MathAnswerSheetLabel *b2NumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *b3NumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *dTensLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plusLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *eTextField;

@end

@implementation MathAnswerSheetQuestionDivDecomposingTermsView
- (instancetype)initWithTask:(MathQuestionsTask *)task category:(ArithmeticAlgorithmCategory )category isShowAnswer:(BOOL)isShowAnswer bgColor:(UIColor *)bgColor frame:(CGRect)frame
{
    self = [super initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];
    if (self) {
        [self setupSubviews];
        [self drawLines];
    }
    return self;
}

- (void)updateTask:(MathQuestionsTask *)task
{
    [super updateTask:task];
    if (task.question.answer.numbers) {
        NSArray *numbers = task.question.answer.numbers;
        self.aNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.bNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.b2NumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.b3NumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        
        NSArray *answers = task.question.answer.answers;
        self.bTensLabel.text = [NSString stringWithFormat:@"%@", answers[1]];
        self.dTensLabel.text = [NSString stringWithFormat:@"%@", answers[3]];
    } else {
        self.aNumberLabel.text = @"";
        self.bNumberLabel.text = @"";
        self.b2NumberLabel.text = @"";
        self.b3NumberLabel.text = @"";
        self.bTensLabel.text = @"";
        self.dTensLabel.text = @"";
    }
        
    if (self.isShowAnswer) {
        NSArray *answers = task.question.answer.answers;
        self.aTextField.text = answers ? [NSString stringWithFormat:@"%@", answers[0]] : @"";
        self.cTextField.text = answers ? [NSString stringWithFormat:@"%@", answers[2]] : @"";
        self.eTextField.text = answers ? [NSString stringWithFormat:@"%@", answers[4]] : @"";
        
        self.aTextField.userInteractionEnabled = NO;
        self.cTextField.userInteractionEnabled = NO;
        self.eTextField.userInteractionEnabled = NO;
        
        self.aTextField.layer.borderColor = self.bgColor.CGColor;
        self.cTextField.layer.borderColor = self.bgColor.CGColor;
        self.eTextField.layer.borderColor = self.bgColor.CGColor;
        
        self.aTextField.textColor = self.bgColor;
        self.cTextField.textColor = self.bgColor;
        self.eTextField.textColor = self.bgColor;
    } else {
        self.aTextField.userInteractionEnabled = YES;
        self.cTextField.userInteractionEnabled = YES;
        self.eTextField.userInteractionEnabled = YES;
    }
}

- (void)check:(MathAnswerSheetTextField *)firstResponder
{
    [super check:firstResponder];
    NSArray *fields = @[self.aTextField, self.cTextField, self.eTextField];
    for (MathAnswerSheetTextField *f in fields) {
        if (f.text.length == 0) {
            
            return;
        }
    }
    
    NSArray *answers = self.task.question.answer.answers;
    if (!answers || answers.count < 5) {
        
        return;
    }
    
    if ([self.aTextField.text isEqualToString:[NSString stringWithFormat:@"%@", answers[0]]] &&
        [self.cTextField.text isEqualToString:[NSString stringWithFormat:@"%@", answers[2]]] &&
        [self.eTextField.text isEqualToString:[NSString stringWithFormat:@"%@", answers[4]]])
    {
        [self.task success];
    } else {
        [self.task failure];
    }
}

- (void)clean:(MathAnswerSheetTextField *)firstResponder
{
    firstResponder.text = nil;
}

- (void)input:(NSString *)number firstResponder:(MathAnswerSheetTextField *)firstResponder
{
    if (number.length >= 4) return;
    firstResponder.text = number;
}

- (void)setupSubviews {
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LearnMathScale(20.0));
        make.bottom.equalTo(self).offset(-LearnMathScale(20.0));
        make.leading.equalTo(self).offset(LearnMathScale(10.0));
        make.trailing.equalTo(self).offset(-LearnMathScale(10.0));
    }];
    
    UIFont *labelFont = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    UIColor *skillColor = [UIColor colorForSet:ColorSetSkillTitle];
    
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.aTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self.contentView addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(LearnMathScale(20.0));
        make.trailing.equalTo(self.contentView.mas_trailing);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    self.equalLabel = [[MathAnswerSheetLabel alloc] init];
    self.equalLabel.text = @"=";
    self.equalLabel.textAlignment = NSTextAlignmentCenter;
    self.equalLabel.font = labelFont;
    self.equalLabel.textColor = skillColor;
    [self.contentView addSubview:self.equalLabel];
    [self.equalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.aTextField.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(29.0), LearnMathScale(54.0)));
    }];
    
    self.bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.bNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.bNumberLabel.font = labelFont;
    self.bNumberLabel.textColor = skillColor;
    [self.contentView addSubview:self.bNumberLabel];
    [self.bNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.equalLabel.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(50.0), LearnMathScale(54.0)));
    }];
    
    self.divLabel = [[MathAnswerSheetLabel alloc] init];
    self.divLabel.text = @"÷";
    self.divLabel.textAlignment = NSTextAlignmentCenter;
    self.divLabel.font = labelFont;
    self.divLabel.textColor = skillColor;
    [self.contentView addSubview:self.divLabel];
    [self.divLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bNumberLabel.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(54.0)));
    }];
    
    self.aNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.aNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.aNumberLabel.font = labelFont;
    self.aNumberLabel.textColor = skillColor;
    [self.contentView addSubview:self.aNumberLabel];
    [self.aNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.divLabel.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.height.mas_equalTo(LearnMathScale(54.0));
        make.leading.equalTo(self.contentView.mas_leading);
    }];
    
    self.bTensLabel = [[MathAnswerSheetLabel alloc] init];
    self.bTensLabel.textAlignment = NSTextAlignmentCenter;
    self.bTensLabel.font = labelFont;
    self.bTensLabel.textColor = skillColor;
    [self.contentView addSubview:self.bTensLabel];
    [self.bTensLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aNumberLabel.mas_bottom).offset(LearnMathScale(30.0));
        make.trailing.equalTo(self.aNumberLabel.mas_centerX).offset(-LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    
    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.cTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self.contentView addSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aNumberLabel.mas_bottom).offset(LearnMathScale(30.0));
        make.leading.equalTo(self.aNumberLabel.mas_centerX).offset(LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.cTextField];

    self.div2Label = [[MathAnswerSheetLabel alloc] init];
    self.div2Label.text = @"÷";
    self.div2Label.textAlignment = NSTextAlignmentCenter;
    self.div2Label.font = labelFont;
    self.div2Label.textColor = skillColor;
    [self.contentView addSubview:self.div2Label];
    [self.div2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bTensLabel.mas_bottom);
        make.centerX.equalTo(self.bTensLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(30.0)));
    }];

    self.div3Label = [[MathAnswerSheetLabel alloc] init];
    self.div3Label.text = @"÷";
    self.div3Label.textAlignment = NSTextAlignmentCenter;
    self.div3Label.font = labelFont;
    self.div3Label.textColor = skillColor;
    [self.contentView addSubview:self.div3Label];
    [self.div3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cTextField.mas_bottom);
        make.centerX.equalTo(self.cTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(30.0)));
    }];

    self.b2NumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.b2NumberLabel.textAlignment = NSTextAlignmentCenter;
    self.b2NumberLabel.font = labelFont;
    self.b2NumberLabel.textColor = skillColor;
    [self.contentView addSubview:self.b2NumberLabel];
    [self.b2NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.div2Label.mas_bottom);
        make.centerX.equalTo(self.div2Label);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(44.0)));
    }];

    self.b3NumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.b3NumberLabel.textAlignment = NSTextAlignmentCenter;
    self.b3NumberLabel.font = labelFont;
    self.b3NumberLabel.textColor = skillColor;
    [self.contentView addSubview:self.b3NumberLabel];
    [self.b3NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.div3Label.mas_bottom);
        make.centerX.equalTo(self.div3Label);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(44.0)));
    }];
    
    self.plusLabel = [[MathAnswerSheetLabel alloc] init];
    self.plusLabel.text = @"+";
    self.plusLabel.textAlignment = NSTextAlignmentCenter;
    self.plusLabel.font = labelFont;
    self.plusLabel.textColor = skillColor;
    [self.contentView addSubview:self.plusLabel];
    [self.plusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8.0);
        make.centerX.equalTo(self.aNumberLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(30.0)));
    }];
    
    self.dTensLabel = [[MathAnswerSheetLabel alloc] init];
    self.dTensLabel.textAlignment = NSTextAlignmentCenter;
    self.dTensLabel.font = labelFont;
    self.dTensLabel.textColor = skillColor;
    [self.contentView addSubview:self.dTensLabel];
    [self.dTensLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.plusLabel);
        make.trailing.equalTo(self.plusLabel.mas_leading).offset(-LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    
    self.eTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.eTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self.contentView addSubview:self.eTextField];
    [self.eTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.plusLabel);
        make.leading.equalTo(self.plusLabel.mas_trailing).offset(LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.eTextField];

}

- (void)drawLines
{
    [self layoutIfNeeded];
    void (^addLine)(UIBezierPath *) = ^(UIBezierPath *path){
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
        layer.fillColor = UIColor.clearColor.CGColor;
        layer.lineCap = kCALineCapRound;
        layer.lineWidth = LearnMathScale(5.5);
        [self.contentView.layer addSublayer:layer];
    };
    
    // line 1
    UIBezierPath *line1 = [UIBezierPath bezierPath];
    [line1 moveToPoint:CGPointMake(CGRectGetMidX(self.aNumberLabel.frame) - LearnMathScale(9.0), CGRectGetMaxY(self.aNumberLabel.frame))];
    [line1 addLineToPoint:CGPointMake(CGRectGetMidX(self.bTensLabel.frame), CGRectGetMinY(self.bTensLabel.frame) - LearnMathScale(9.0))];
    addLine(line1);
    
    // line 2
    UIBezierPath *line2 = [UIBezierPath bezierPath];
    [line2 moveToPoint:CGPointMake(CGRectGetMidX(self.aNumberLabel.frame) + LearnMathScale(9.0), CGRectGetMaxY(self.aNumberLabel.frame))];
    [line2 addLineToPoint:CGPointMake(CGRectGetMidX(self.cTextField.frame), CGRectGetMinY(self.cTextField.frame) - LearnMathScale(9.0))];
    addLine(line2);
    
    // line 3
    UIBezierPath *line3 = [UIBezierPath bezierPath];
    [line3 moveToPoint:CGPointMake(CGRectGetMidX(self.b2NumberLabel.frame), CGRectGetMaxY(self.b2NumberLabel.frame))];
    [line3 addLineToPoint:CGPointMake(CGRectGetMidX(self.dTensLabel.frame), CGRectGetMinY(self.dTensLabel.frame) - LearnMathScale(9.0))];
    addLine(line3);
    
    // line 4
    UIBezierPath *line4 = [UIBezierPath bezierPath];
    [line4 moveToPoint:CGPointMake(CGRectGetMidX(self.b3NumberLabel.frame), CGRectGetMaxY(self.b3NumberLabel.frame))];
    [line4 addLineToPoint:CGPointMake(CGRectGetMidX(self.eTextField.frame), CGRectGetMinY(self.eTextField.frame) - LearnMathScale(9.0))];
    addLine(line4);
    
    // line 5
    UIBezierPath *line5 = [UIBezierPath bezierPath];
    [line5 moveToPoint:CGPointMake(CGRectGetMaxX(self.eTextField.frame) + LearnMathScale(9.0), CGRectGetMidY(self.eTextField.frame))];
    [line5 addLineToPoint:CGPointMake(self.aTextField.center.x, CGRectGetMidY(self.eTextField.frame))];
    [line5 addLineToPoint:CGPointMake(self.aTextField.center.x, CGRectGetMaxY(self.aTextField.frame) + LearnMathScale(9.0))];
    addLine(line5);
}
@end
