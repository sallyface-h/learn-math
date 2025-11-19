//
//  MathAnswerSheetQuestionAddFindingTheBaseNumberView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionAddFindingTheBaseNumberView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionAddFindingTheBaseNumberView ()
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plusLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plus2Label;
@property (nonatomic, strong) MathAnswerSheetLabel *cNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plus3Label;
@property (nonatomic, strong) MathAnswerSheetLabel *dNumberLabel;

@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetLabel *aBaseLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;
@property (nonatomic, strong) MathAnswerSheetLabel *bBaseLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;
@property (nonatomic, strong) MathAnswerSheetLabel *cBaseLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *dTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *eTextField;

@end
@implementation MathAnswerSheetQuestionAddFindingTheBaseNumberView
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
    
    NSArray<NSNumber *> *numbers = task.question.answer.numbers;
    NSArray<NSNumber *> *answers = task.question.answer.answers;
    
    if (task.question.answer.numbers) {
        self.aNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.bNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.cNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[2]];
        self.dNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[3]];
        self.aBaseLabel.text = [NSString stringWithFormat:@"%@", numbers[4]];
        self.bBaseLabel.text = [NSString stringWithFormat:@"%@", numbers[4]];
        self.cBaseLabel.text = [NSString stringWithFormat:@"%@", numbers[4]];
    } else {
        self.aNumberLabel.text = @"";
        self.bNumberLabel.text = @"";
        self.cNumberLabel.text = @"";
        self.dNumberLabel.text = @"";
        self.aBaseLabel.text = @"";
        self. bBaseLabel.text = @"";
        self. cBaseLabel.text = @"";
    }
    
    if (self.isShowAnswer) {
        if (answers) {
            self.aTextField.text = [NSString stringWithFormat:@"%@", numbers[0]];
            self.bTextField.text = [NSString stringWithFormat:@"%@", numbers[1]];
            self.cTextField.text = [NSString stringWithFormat:@"%@", numbers[2]];
            self.dTextField.text = [NSString stringWithFormat:@"%@", numbers[3]];
            self.eTextField.text = [NSString stringWithFormat:@"%@", numbers[4]];
        } else {
            self.aTextField.text = @"";
            self.bTextField.text = @"";
            self.cTextField.text = @"";
            self.dTextField.text = @"";
            self.eTextField.text = @"";
        }
        self.aTextField.userInteractionEnabled = NO;
        self.bTextField.userInteractionEnabled = NO;
        self.cTextField.userInteractionEnabled = NO;
        self.dTextField.userInteractionEnabled = NO;
        self.eTextField.userInteractionEnabled = NO;

        self.aTextField.textColor = self.bgColor;
        self.bTextField.textColor = self.bgColor;
        self.cTextField.textColor = self.bgColor;
        self.eTextField.textColor = self.bgColor;
        self.dTextField.textColor = self.bgColor;
        
        self.aTextField.layer.borderColor = self.bgColor.CGColor;
        self.bTextField.layer.borderColor = self.bgColor.CGColor;
        self.cTextField.layer.borderColor = self.bgColor.CGColor;
        self.dTextField.layer.borderColor = self.bgColor.CGColor;
        self.eTextField.layer.borderColor = self.bgColor.CGColor;
    } else {
        self.aTextField.userInteractionEnabled = YES;
        self.bTextField.userInteractionEnabled = YES;
        self.cTextField.userInteractionEnabled = YES;
        self.dTextField.userInteractionEnabled = YES;
        self.eTextField.userInteractionEnabled = YES;
    }
}

- (void)check:(MathAnswerSheetTextField *)firstResponder
{
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

- (void)clean:(MathAnswerSheetTextField *)firstResponder
{
    firstResponder.text = nil;
}

- (void)input:(NSString *)number firstResponder:(MathAnswerSheetTextField *)firstResponder
{
    firstResponder.text = number;
}

- (void)setupSubviews
{
    CGFloat s = 1.0;
    UIColor *skillColor = [UIColor colorForSet:ColorSetSkillTitle];
    UIFont *labelFont = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    
    // 1. aTextField
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.aTextField.font = labelFont;
    [self addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LearnMathScale(35.0));
        make.trailing.equalTo(self).offset(-LearnMathScale(10.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    // 2. stackView
    self.stackView = [[UIStackView alloc] init];
    self.stackView.distribution = UIStackViewDistributionFill;
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.spacing = 0.0;
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.aTextField.mas_centerY);
        make.height.mas_equalTo(LearnMathScale(48.0));
        make.leading.equalTo(self).offset(LearnMathScale(20.0));
        make.trailing.equalTo(self.aTextField.mas_leading);
    }];
    
    // 3. aNumberLabel
    self.aNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.aNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.aNumberLabel.font = labelFont;
    self.aNumberLabel.textColor = skillColor;
    [self.stackView addArrangedSubview:self.aNumberLabel];
    
    // 4. plusLabel
    self.plusLabel = [[MathAnswerSheetLabel alloc] init];
    self.plusLabel.text = @"+";
    self.plusLabel.textAlignment = NSTextAlignmentCenter;
    self.plusLabel.font = labelFont;
    self.plusLabel.textColor = skillColor;
    [self.stackView addArrangedSubview:self.plusLabel];
    [self.plusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(65.0));
    }];
    
    // 5. bNumberLabel
    self.bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.bNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.bNumberLabel.font = labelFont;
    self.bNumberLabel.textColor = skillColor;
    [self.stackView addArrangedSubview:self.bNumberLabel];
    [self.bNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.aNumberLabel);
    }];
    
    // 6. plus2Label
    self.plus2Label = [[MathAnswerSheetLabel alloc] init];
    self.plus2Label.text = @"+";
    self.plus2Label.textAlignment = NSTextAlignmentCenter;
    self.plus2Label.font = labelFont;
    self.plus2Label.textColor = skillColor;
    [self.stackView addArrangedSubview:self.plus2Label];
    [self.plus2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(65.0));
    }];
    
    // 7. cNumberLabel
    self.cNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.cNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.cNumberLabel.font = labelFont;
    self.cNumberLabel.textColor = skillColor;
    [self.stackView addArrangedSubview:self.cNumberLabel];
    [self.cNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.bNumberLabel);
    }];
    
    // 8. equalLabel
    self.equalLabel = [[MathAnswerSheetLabel alloc] init];
    self.equalLabel.text = @"=";
    self.equalLabel.textAlignment = NSTextAlignmentCenter;
    self.equalLabel.font = labelFont;
    self.equalLabel.textColor = skillColor;
    [self.stackView addArrangedSubview:self.equalLabel];
    [self.equalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(20.0));
    }];
    
    // 9. aBaseLabel
    self.aBaseLabel = [[MathAnswerSheetLabel alloc] init];
    self.aBaseLabel.textAlignment = NSTextAlignmentCenter;
    self.aBaseLabel.font = labelFont;
    self.aBaseLabel.textColor = skillColor;
    [self addSubview:self.aBaseLabel];
    [self.aBaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aNumberLabel.mas_bottom).offset(LearnMathScale(46.0));
        make.trailing.equalTo(self.aNumberLabel.mas_centerX).offset(LearnMathScale(10.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(42.0), LearnMathScale(48.0)));
    }];
    
    // 10. bTextField
    self.bTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.bTextField.font = labelFont;
    [self addSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.aBaseLabel.mas_centerY);
        make.leading.equalTo(self.aNumberLabel.mas_centerX).offset(LearnMathScale(10.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.bTextField];
    
    // 11. bBaseLabel
    self.bBaseLabel = [[MathAnswerSheetLabel alloc] init];
    self.bBaseLabel.textAlignment = NSTextAlignmentCenter;
    self.bBaseLabel.font = labelFont;
    self.bBaseLabel.textColor = skillColor;
    [self addSubview:self.bBaseLabel];
    [self.bBaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.aBaseLabel.mas_centerY);
        make.trailing.equalTo(self.bNumberLabel.mas_centerX).offset(LearnMathScale(15.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    
    // 12. cTextField
    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.cTextField.font = labelFont;
    [self addSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.aBaseLabel.mas_centerY);
        make.leading.equalTo(self.bNumberLabel.mas_centerX).offset(LearnMathScale(15.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.cTextField];
    
    // 13. cBaseLabel
    self.cBaseLabel = [[MathAnswerSheetLabel alloc] init];
    self.cBaseLabel.textAlignment = NSTextAlignmentCenter;
    self.cBaseLabel.font = labelFont;
    self.cBaseLabel.textColor = skillColor;
    [self addSubview:self.cBaseLabel];
    [self.cBaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.aBaseLabel.mas_centerY);
        make.trailing.equalTo(self.cNumberLabel.mas_centerX).offset(LearnMathScale(20.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    
    // 14. dTextField
    self.dTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.dTextField.font = labelFont;
    [self addSubview:self.dTextField];
    [self.dTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.aBaseLabel.mas_centerY);
        make.leading.equalTo(self.cNumberLabel.mas_centerX).offset(LearnMathScale(20.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.dTextField];
    
    // 15. eTextField
    self.eTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.eTextField.font = labelFont;
    [self addSubview:self.eTextField];
    [self.eTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-LearnMathScale(18.0));
        make.centerX.equalTo(self.cTextField.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.eTextField];
    
    // 16. plus3Label
    self.plus3Label = [[MathAnswerSheetLabel alloc] init];
    self.plus3Label.text = @"+";
    self.plus3Label.textAlignment = NSTextAlignmentCenter;
    self.plus3Label.font = labelFont;
    self.plus3Label.textColor = skillColor;
    [self addSubview:self.plus3Label];
    [self.plus3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.eTextField.mas_centerY);
        make.leading.equalTo(self.eTextField.mas_trailing);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(48.0)));
    }];
    
    // 17. dNumberLabel
    self.dNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.dNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.dNumberLabel.font = labelFont;
    self.dNumberLabel.textColor = skillColor;
    [self addSubview:self.dNumberLabel];
    [self.dNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.eTextField.mas_centerY);
        make.leading.equalTo(self.plus3Label.mas_trailing);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    
    // 自动聚焦
    if (!self.isShowAnswer) {
        [self.bTextField becomeFirstResponder];
    }
}

- (void)drawLines
{
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
    
    CGRect aFrame = [self.stackView convertRect:self.aNumberLabel.frame toView:self];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(CGRectGetMidX(aFrame) - LearnMathScale(9), CGRectGetMaxY(aFrame) + LearnMathScale(3))];
    [path1 addLineToPoint:CGPointMake(self.aBaseLabel.center.x, CGRectGetMinY(self.aBaseLabel.frame) - LearnMathScale(9))];
    addLine(path1);
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(CGRectGetMidX(aFrame) + LearnMathScale(9), CGRectGetMaxY(aFrame) + LearnMathScale(3))];
    [path2 addLineToPoint:CGPointMake(self.bTextField.center.x, CGRectGetMinY(self.bTextField.frame) - LearnMathScale(9))];
    addLine(path2);
    
    CGRect bFrame = [self.stackView convertRect:self.bNumberLabel.frame toView:self];
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(CGRectGetMidX(bFrame) - LearnMathScale(9), CGRectGetMaxY(bFrame) + LearnMathScale(3))];
    [path3 addLineToPoint:CGPointMake(self.bBaseLabel.center.x, CGRectGetMinY(self.bBaseLabel.frame) - LearnMathScale(9))];
    addLine(path3);
    
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(CGRectGetMidX(bFrame) + LearnMathScale(9), CGRectGetMaxY(bFrame) + LearnMathScale(3))];
    [path4 addLineToPoint:CGPointMake(self.cTextField.center.x, CGRectGetMinY(self.cTextField.frame) - LearnMathScale(9))];
    addLine(path4);
    
    CGRect cFrame = [self.stackView convertRect:self.cNumberLabel.frame toView:self];
    UIBezierPath *path5 = [UIBezierPath bezierPath];
    [path5 moveToPoint:CGPointMake(CGRectGetMidX(cFrame) - LearnMathScale(9), CGRectGetMaxY(cFrame) + LearnMathScale(3))];
    [path5 addLineToPoint:CGPointMake(self.cBaseLabel.center.x, CGRectGetMinY(self.cBaseLabel.frame) - LearnMathScale(9))];
    addLine(path5);
    
    UIBezierPath *path6 = [UIBezierPath bezierPath];
    [path6 moveToPoint:CGPointMake(CGRectGetMidX(cFrame) + LearnMathScale(9), CGRectGetMaxY(cFrame) + LearnMathScale(3))];
    [path6 addLineToPoint:CGPointMake(self.dTextField.center.x, CGRectGetMinY(self.dTextField.frame) - LearnMathScale(9))];
    addLine(path6);
    
    UIBezierPath *path7 = [UIBezierPath bezierPath];
    [path7 moveToPoint:CGPointMake(self.bTextField.center.x + LearnMathScale(9), CGRectGetMaxY(self.bTextField.frame) + LearnMathScale(9))];
    [path7 addLineToPoint:CGPointMake(self.eTextField.center.x - LearnMathScale(11), CGRectGetMinY(self.eTextField.frame) - LearnMathScale(9))];
    addLine(path7);
    
    UIBezierPath *path8 = [UIBezierPath bezierPath];
    [path8 moveToPoint:CGPointMake(self.cTextField.center.x, CGRectGetMaxY(self.cTextField.frame) + LearnMathScale(9))];
    [path8 addLineToPoint:CGPointMake(self.eTextField.center.x, CGRectGetMinY(self.eTextField.frame) - LearnMathScale(9))];
    addLine(path8);
    
    UIBezierPath *path9 = [UIBezierPath bezierPath];
    [path9 moveToPoint:CGPointMake(self.dTextField.center.x - LearnMathScale(9), CGRectGetMaxY(self.dTextField.frame) + LearnMathScale(9))];
    [path9 addLineToPoint:CGPointMake(self.eTextField.center.x + LearnMathScale(11), CGRectGetMinY(self.eTextField.frame) - LearnMathScale(9))];
    addLine(path9);
}

- (MathAnswerSheetLabel *)createLabel {
    MathAnswerSheetLabel *label = [[MathAnswerSheetLabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    return label;
}

- (MathAnswerSheetLabel *)createSymbolLabelWithText:(NSString *)text {
    MathAnswerSheetLabel *label = [self createLabel];
    label.text = text;
    return label;
}
@end
