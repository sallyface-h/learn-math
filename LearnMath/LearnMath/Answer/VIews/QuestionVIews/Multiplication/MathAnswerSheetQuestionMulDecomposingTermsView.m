//
//  MathAnswerSheetQuestionMulDecomposingTermsView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionMulDecomposingTermsView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionMulDecomposingTermsView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *b2NumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *b3NumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bTensLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *dTensLabel;

@property (nonatomic, strong) MathAnswerSheetLabel *mulLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *mul2Label;
@property (nonatomic, strong) MathAnswerSheetLabel *mul3Label;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plusLabel;

@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *eTextField;

@end
@implementation MathAnswerSheetQuestionMulDecomposingTermsView
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
    NSArray *numbers = task.question.answer.numbers;
    NSArray *answers = task.question.answer.answers;
    if (numbers) {
        self.aNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.bNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.b2NumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.b3NumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        
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
        if (answers) {
            self.aTextField.text = [NSString stringWithFormat:@"%@", numbers[0]];
            self.cTextField.text = [NSString stringWithFormat:@"%@", numbers[2]];
            self.eTextField.text = [NSString stringWithFormat:@"%@", numbers[4]];
        } else {
            self.aTextField.text = @"";
            self.cTextField.text = @"";
            self.eTextField.text = @"";
        }
        
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
    if (!answers || answers.count < 2) {
       
        return;
    }
    
    NSString *aAnswer = [NSString stringWithFormat:@"%@", answers[0]];
    NSString *cAnswer = [NSString stringWithFormat:@"%@", answers[2]];
    NSString *eAnswer = [NSString stringWithFormat:@"%@", answers[4]];
    
    if ([self.aTextField.text isEqualToString:aAnswer] &&
        [self.cTextField.text isEqualToString:cAnswer] &&
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
    if (firstResponder == self.cTextField) {
        if (number.length >= 2) {
                return;
            }
    }
    firstResponder.text = number;
}

- (void)setupSubviews {
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(LearnMathScale(20.0)));
        make.bottom.equalTo(@(-LearnMathScale(20.0)));
        make.leading.equalTo(@(LearnMathScale(10.0)));
        make.trailing.equalTo(@(-LearnMathScale(10.0)));
    }];

    // aTextField
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    self.aTextField.font = [UIFont ap_baloo:LearnMathScale(20.0) weight:UIFontWeightRegular];
    [self.contentView addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.aTextField];

    // equalLabel
    self.equalLabel = [[MathAnswerSheetLabel alloc] init];
    self.equalLabel.text = @"=";
    self.equalLabel.textAlignment = NSTextAlignmentCenter;
    self.equalLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.equalLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.equalLabel];
    [self.equalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.aTextField.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(29.0), LearnMathScale(54.0)));
    }];

    // bNumberLabel
    self.bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.bNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.bNumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.bNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.bNumberLabel];
    [self.bNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.equalLabel.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(50.0), LearnMathScale(54.0)));
    }];

    // mulLabel
    self.mulLabel = [[MathAnswerSheetLabel alloc] init];
    self.mulLabel.text = @"x";
    self.mulLabel.textAlignment = NSTextAlignmentCenter;
    self.mulLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.mulLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.mulLabel];
    [self.mulLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bNumberLabel.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(54.0)));
    }];

    // aNumberLabel
    self.aNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.aNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.aNumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.aNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.aNumberLabel];
    [self.aNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mulLabel.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.height.mas_equalTo(LearnMathScale(54.0));
        make.leading.equalTo(self.contentView);
    }];

    // bTensLabel
    self.bTensLabel = [[MathAnswerSheetLabel alloc] init];
    self.bTensLabel.textAlignment = NSTextAlignmentCenter;
    self.bTensLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.bTensLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.bTensLabel];
    [self.bTensLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aNumberLabel.mas_bottom).offset(LearnMathScale(30.0));
        make.trailing.equalTo(self.aNumberLabel.mas_centerX).offset(-LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];

    // cTextField
    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    self.cTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self.contentView addSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aNumberLabel.mas_bottom).offset(LearnMathScale(30.0));
        make.leading.equalTo(self.aNumberLabel.mas_centerX).offset(LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.cTextField];

    // mul2Label
    self.mul2Label = [[MathAnswerSheetLabel alloc] init];
    self.mul2Label.text = @"x";
    self.mul2Label.textAlignment = NSTextAlignmentCenter;
    self.mul2Label.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.mul2Label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.mul2Label];
    [self.mul2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bTensLabel.mas_bottom);
        make.centerX.equalTo(self.bTensLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(30.0)));
    }];

    // mul3Label
    self.mul3Label = [[MathAnswerSheetLabel alloc] init];
    self.mul3Label.text = @"x";
    self.mul3Label.textAlignment = NSTextAlignmentCenter;
    self.mul3Label.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.mul3Label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.mul3Label];
    [self.mul3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cTextField.mas_bottom);
        make.centerX.equalTo(self.cTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(30.0)));
    }];

    // b2NumberLabel
    self.b2NumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.b2NumberLabel.textAlignment = NSTextAlignmentCenter;
    self.b2NumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.b2NumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.b2NumberLabel];
    [self.b2NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mul2Label.mas_bottom);
        make.centerX.equalTo(self.mul2Label);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(44.0)));
    }];

    // b3NumberLabel
    self.b3NumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.b3NumberLabel.textAlignment = NSTextAlignmentCenter;
    self.b3NumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.b3NumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.b3NumberLabel];
    [self.b3NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mul3Label.mas_bottom);
        make.centerX.equalTo(self.mul3Label);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(44.0)));
    }];

    // plusLabel
    self.plusLabel = [[MathAnswerSheetLabel alloc] init];
    self.plusLabel.text = @"+";
    self.plusLabel.textAlignment = NSTextAlignmentCenter;
    self.plusLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.plusLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.plusLabel];
    [self.plusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-8.0));
        make.centerX.equalTo(self.aNumberLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(30.0)));
    }];

    // dTensLabel
    self.dTensLabel = [[MathAnswerSheetLabel alloc] init];
    self.dTensLabel.textAlignment = NSTextAlignmentCenter;
    self.dTensLabel.font = [UIFont ap_baloo:LearnMathScale(30.0) weight:UIFontWeightRegular];
    self.dTensLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.dTensLabel];
    [self.dTensLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.plusLabel);
        make.trailing.equalTo(self.plusLabel.mas_leading).offset(-LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];

    // eTextField
    self.eTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    self.eTextField.font = [UIFont ap_baloo:LearnMathScale(30.0) weight:UIFontWeightRegular];
    [self.contentView addSubview:self.eTextField];
    [self.eTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.plusLabel);
        make.leading.equalTo(self.plusLabel.mas_trailing).offset(LearnMathScale(4.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.eTextField];

    if (!self.isShowAnswer) {
        [self.cTextField becomeFirstResponder];
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
        [self.contentView.layer addSublayer:layer];
    };
    
    UIBezierPath *firstPath = [UIBezierPath bezierPath];
    [firstPath moveToPoint:CGPointMake(CGRectGetMidX(self.aNumberLabel.frame) - LearnMathScale(9.0),CGRectGetMaxY(self.aNumberLabel.frame))];
    [firstPath addLineToPoint:CGPointMake(CGRectGetMidX(self.bTensLabel.frame), CGRectGetMinY(self.bTensLabel.frame) - LearnMathScale(9.0))];
    addLine(firstPath);
    

    UIBezierPath *secondPath = [UIBezierPath bezierPath];
    [secondPath moveToPoint:CGPointMake(CGRectGetMidX(self.aNumberLabel.frame) + LearnMathScale(9.0),CGRectGetMaxY(self.aNumberLabel.frame))];
    [secondPath addLineToPoint:CGPointMake(CGRectGetMidX(self.cTextField.frame), CGRectGetMinY(self.cTextField.frame) - LearnMathScale(9.0))];
    addLine(secondPath);
    
    UIBezierPath *thirdPath = [UIBezierPath bezierPath];
    [thirdPath moveToPoint:CGPointMake(CGRectGetMidX(self.b2NumberLabel.frame), CGRectGetMaxY(self.b2NumberLabel.frame))];
    [thirdPath addLineToPoint:CGPointMake(CGRectGetMidX(self.dTensLabel.frame), CGRectGetMinY(self.dTensLabel.frame) - LearnMathScale(9.0))];
    addLine(thirdPath);
    
    UIBezierPath *fourthPath = [UIBezierPath bezierPath];
    [fourthPath moveToPoint:CGPointMake(CGRectGetMidX(self.b3NumberLabel.frame), CGRectGetMaxY(self.b3NumberLabel.frame))];
    [fourthPath addLineToPoint:CGPointMake(CGRectGetMidX(self.eTextField.frame), CGRectGetMinY(self.eTextField.frame) - LearnMathScale(9.0))];
    addLine(fourthPath);
    
    UIBezierPath *fifthPath = [UIBezierPath bezierPath];
    [fifthPath moveToPoint:CGPointMake(CGRectGetMaxX(self.eTextField.frame) + LearnMathScale(9.0), CGRectGetMidY(self.eTextField.frame))];
    [fifthPath addLineToPoint:CGPointMake(self.aTextField.center.x, CGRectGetMidY(self.eTextField.frame))];
    [fifthPath addLineToPoint:CGPointMake(self.aTextField.center.x, CGRectGetMaxY(self.aTextField.frame) + LearnMathScale(9.0))];
    addLine(fifthPath);
}

@end
