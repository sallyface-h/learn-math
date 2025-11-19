//
//  MathAnswerSheetQuestionDivVerticalFormTableView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionDivVerticalFormTableView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionDivVerticalFormTableView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *dTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *eTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *fTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *gTextField;

@property (nonatomic, strong) MathAnswerSheetLabel *aOneLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *aTenLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *cNumberLabel;

@end
@implementation MathAnswerSheetQuestionDivVerticalFormTableView
- (instancetype)initWithTask:(MathQuestionsTask *)task category:(ArithmeticAlgorithmCategory )category isShowAnswer:(BOOL)isShowAnswer bgColor:(UIColor *)bgColor frame:(CGRect)frame
{
    self = [super initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];
    if (self) {
        [self setupSubViews];
        [self drawLines];
    }
    return self;
}

- (void)updateTask:(MathQuestionsTask *)task
{
    [super updateTask:task];
    NSArray<NSNumber *> *numbers = task.question.answer.numbers;
    NSArray<NSNumber *> *answers = task.question.answer.answers;
    
    if (numbers) {
        NSString *aOne = [NSString stringWithFormat:@"%@", numbers[0]];
        NSString *aTen = [NSString stringWithFormat:@"%@", numbers[1]];
        NSString *b = [NSString stringWithFormat:@"%@", numbers[2]];
        self.aOneLabel.text = aOne;
        self.aTenLabel.text = aTen;
        self.bNumberLabel.text = b;
    }else {
        self.aOneLabel.text = @"";
        self.aTenLabel.text = @"";
        self.bNumberLabel.text = @"";
    }
    if (self.isShowAnswer) {
        if (answers) {
            self.aTextField.text = [NSString stringWithFormat:@"%@", answers[0]];
            self.cTextField.text = [NSString stringWithFormat:@"%@", answers[1]];
            self.dTextField.text = [NSString stringWithFormat:@"%@", answers[2]];
            self.eTextField.text = [NSString stringWithFormat:@"%@", answers[3]];
            self.fTextField.text = [NSString stringWithFormat:@"%@", answers[4]];
            self.gTextField.text = [NSString stringWithFormat:@"%@", answers[5]];
            self.bTextField.text = [NSString stringWithFormat:@"%@", answers[6]];
        } else {
            self.aTextField.text = @"";
            self.cTextField.text = @"";
            self.dTextField.text = @"";
            self.eTextField.text = @"";
            self.fTextField.text = @"";
            self.gTextField.text = @"";
            self.bTextField.text = @"";
        }
        
        self.aTextField.userInteractionEnabled = NO;
        self.cTextField.userInteractionEnabled = NO;
        self.dTextField.userInteractionEnabled = NO;
        self.eTextField.userInteractionEnabled = NO;
        self.bTextField.userInteractionEnabled = NO;
        
        CGColorRef borderColor = self.bgColor.CGColor;
        
        self.aTextField.layer.borderColor = borderColor;
        self.cTextField.layer.borderColor = borderColor;
        self.dTextField.layer.borderColor = borderColor;
        self.eTextField.layer.borderColor = borderColor;
        self.fTextField.layer.borderColor = borderColor;
        self.gTextField.layer.borderColor = borderColor;
        self.bTextField.layer.borderColor = borderColor;
        
        self.aTextField.textColor = self.bgColor;
        self.cTextField.textColor = self.bgColor;
        self.dTextField.textColor = self.bgColor;
        self.eTextField.textColor = self.bgColor;
        self.fTextField.textColor = self.bgColor;
        self.gTextField.textColor = self.bgColor;
        self.bTextField.textColor = self.bgColor;
    } else {
        self.aTextField.userInteractionEnabled = YES;
        self.cTextField.userInteractionEnabled = YES;
        self.dTextField.userInteractionEnabled = YES;
        self.eTextField.userInteractionEnabled = YES;
        self.bTextField.userInteractionEnabled = YES;
    }
                
}

- (void)check:(MathAnswerSheetTextField *)firstResponder
{
    [super check:firstResponder];
    NSArray *fields = @[self.aTextField, self.bTextField, self.cTextField, self.dTextField, self.eTextField, self.fTextField, self.gTextField];
    for (MathAnswerSheetTextField *f in fields) {
        if (f.text.length == 0) {
           
            return;
        }
    }
    
    NSArray *answers = self.task.question.answer.answers;
       if (!answers || answers.count < 6) {
           
           return;
       }
       
    NSString *r1 = [NSString stringWithFormat:@"%@", answers[0]];
    NSString *r2 = [NSString stringWithFormat:@"%@", answers[1]];
    NSString *r3 = [NSString stringWithFormat:@"%@", answers[2]];
    NSString *r4 = [NSString stringWithFormat:@"%@", answers[3]];
    NSString *r5 = [NSString stringWithFormat:@"%@", answers[4]];
    NSString *r6 = [NSString stringWithFormat:@"%@", answers[5]];
    NSString *r7 = [NSString stringWithFormat:@"%@", answers[6]];
    
    if ([self.aTextField.text isEqualToString:r1] &&
        [self.bTextField.text isEqualToString:r7] &&
        [self.cTextField.text isEqualToString:r2] &&
        [self.dTextField.text isEqualToString:r3] &&
        [self.eTextField.text isEqualToString:r4] &&
        [self.fTextField.text isEqualToString:r5] &&
        [self.gTextField.text isEqualToString:r6]) {
            [self.task success];
        } else {
            [self.task failure];
        }
}

- (void)clean:(MathAnswerSheetTextField *)firstResponder
{
    firstResponder.text = nil;
    if (firstResponder == self.dTextField) {
        self.fTextField.text = nil;
    } else if (firstResponder == self.eTextField) {
        self.gTextField.text = nil;
    }
}

- (void)input:(NSString *)number firstResponder:(MathAnswerSheetTextField *)firstResponder
{
    if (number.length >= 2) {
        return;
    }
    firstResponder.text = number;
    if (firstResponder == self.dTextField) {
        self.fTextField.text = number;
    } else if (firstResponder == self.eTextField) {
        self.gTextField.text = number;
    }
}

- (void)setupSubViews {
    // contentView
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LearnMathScale(15.0));
        make.leading.equalTo(self).offset(LearnMathScale(30.0));
        make.trailing.equalTo(self).offset(-LearnMathScale(30.0));
        make.bottom.equalTo(self);
    }];

    // bTextField
    self.bTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self.contentView addSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.trailing.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
    }];
    [self.inputTextFields addObject:self.bTextField];
    
    // aTextField
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self.contentView addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.centerY.equalTo(self.bTextField);
        make.trailing.equalTo(self.bTextField.mas_leading).offset(-LearnMathScale(5.0));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    // aOneLabel
    self.aOneLabel = [[MathAnswerSheetLabel alloc] init];
    self.aOneLabel.textAlignment = NSTextAlignmentCenter;
    self.aOneLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.aOneLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.aOneLabel];
    [self.aOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.centerX.equalTo(self.bTextField);
        make.top.equalTo(self.bTextField.mas_bottom).offset(LearnMathScale(15.0));
    }];
    
    // aTenLabel
    self.aTenLabel = [[MathAnswerSheetLabel alloc] init];
    self.aTenLabel.textAlignment = NSTextAlignmentCenter;
    self.aTenLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.aTenLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.aTenLabel];
    [self.aTenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.centerX.equalTo(self.aTextField);
        make.centerY.equalTo(self.aOneLabel);
    }];
    
    // bNumberLabel
    self.bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.bNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.bNumberLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.bNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.bNumberLabel];
    [self.bNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(60.0)));
        make.leading.equalTo(self.contentView);
        make.centerY.equalTo(self.aOneLabel);
    }];
    
    // cTextField
    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self.contentView addSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.top.equalTo(self.aTenLabel.mas_bottom).offset(LearnMathScale(10.0));
        make.centerX.equalTo(self.aTenLabel);
    }];
    [self.inputTextFields addObject:self.cTextField];
    
    // dTextField
    self.dTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self.contentView addSubview:self.dTextField];
    [self.dTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.top.equalTo(self.cTextField.mas_bottom).offset(LearnMathScale(15.0));
        make.centerX.equalTo(self.aTenLabel);
    }];
    [self.inputTextFields addObject:self.dTextField];
    
    // eTextField
    self.eTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self.contentView addSubview:self.eTextField];
    [self.eTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.centerY.equalTo(self.dTextField);
        make.centerX.equalTo(self.aOneLabel);
    }];
    [self.inputTextFields addObject:self.eTextField];
    
    // fTextField
    self.fTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.fTextField.userInteractionEnabled = NO;
    [self.contentView addSubview:self.fTextField];
    [self.fTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.top.equalTo(self.dTextField.mas_bottom).offset(LearnMathScale(10.0));
        make.centerX.equalTo(self.aTenLabel);
    }];
    [self.inputTextFields addObject:self.fTextField];
    
    // gTextField
    self.gTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.gTextField.userInteractionEnabled = NO;
    [self.contentView addSubview:self.gTextField];
    [self.gTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.centerY.equalTo(self.fTextField);
        make.centerX.equalTo(self.aOneLabel);
    }];
    [self.inputTextFields addObject:self.gTextField];
    
    // cNumberLabel
    self.cNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.cNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.cNumberLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.cNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    self.cNumberLabel.text = @"0";
    [self.contentView addSubview:self.cNumberLabel];
    [self.cNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        make.top.equalTo(self.gTextField.mas_bottom).offset(LearnMathScale(15.0));
        make.centerX.equalTo(self.aOneLabel);
    }];
    
    if (!self.isShowAnswer) {
        [self.aTextField becomeFirstResponder];
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
        layer.lineWidth = LearnMathScale(5.5);
        [self.contentView.layer addSublayer:layer];
    };
    
    CGFloat y = CGRectGetMaxY(self.aTextField.frame) + (CGRectGetMinY(self.aTenLabel.frame) - CGRectGetMaxY(self.aTextField.frame)) * 0.5;
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(CGRectGetMaxX(self.bNumberLabel.frame) + LearnMathScale(40), y)];
    [path1 addLineToPoint:CGPointMake(self.contentView.frame.size.width, y)];
    addLine(path1);
    
    CGFloat y1 = CGRectGetMaxY(self.cTextField.frame) + (CGRectGetMinY(self.dTextField.frame) - CGRectGetMaxY(self.cTextField.frame)) * 0.5;
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(CGRectGetMaxX(self.bNumberLabel.frame) + LearnMathScale(40), y1)];
    [path2 addLineToPoint:CGPointMake(self.contentView.frame.size.width, y1)];
    addLine(path2);
    
    CGFloat y2 = CGRectGetMaxY(self.fTextField.frame) + (CGRectGetMinY(self.cNumberLabel.frame) - CGRectGetMaxY(self.fTextField.frame)) * 0.5;
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(CGRectGetMaxX(self.bNumberLabel.frame) + LearnMathScale(40), y2)];
    [path3 addLineToPoint:CGPointMake(self.contentView.frame.size.width, y2)];
    addLine(path3);
    
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(CGRectGetMaxX(self.bNumberLabel.frame) + LearnMathScale(40), y)];
    [path4 addQuadCurveToPoint:CGPointMake(CGRectGetMaxX(self.bNumberLabel.frame) + LearnMathScale(20), y + LearnMathScale(40))
                  controlPoint:CGPointMake(CGRectGetMaxX(self.bNumberLabel.frame) + LearnMathScale(40), y + LearnMathScale(20))];
    addLine(path4);
}

@end
