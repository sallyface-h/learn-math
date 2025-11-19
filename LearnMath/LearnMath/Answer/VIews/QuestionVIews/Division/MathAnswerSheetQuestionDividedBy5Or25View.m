//
//  MathAnswerSheetQuestionDividedBy5Or25View.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionDividedBy5Or25View.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionDividedBy5Or25View ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *divLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetLabel *a1NumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *mulLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;
@property (nonatomic, strong) MathAnswerSheetLabel *div2Label;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;


@end
@implementation MathAnswerSheetQuestionDividedBy5Or25View
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
    
    if (numbers) {
        self.aNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.a1NumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.bNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        
        if (task.question.digits <= 10) {
            self.aNumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
            self.a1NumberLabel.font = [UIFont ap_baloo:LearnMathScale(25.0) weight:UIFontWeightRegular];
        } else {
            self.aNumberLabel.font = [UIFont ap_baloo:LearnMathScale(30.0) weight:UIFontWeightRegular];
            self.a1NumberLabel.font = [UIFont ap_baloo:LearnMathScale(20.0) weight:UIFontWeightRegular];
        }
    } else {
        self.aNumberLabel.text = @"";
        self.a1NumberLabel.text = @"";
        self.bNumberLabel.text = @"";
        self.aNumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
        self.a1NumberLabel.font = [UIFont ap_baloo:LearnMathScale(30.0) weight:UIFontWeightRegular];
    }
    
    if (self.isShowAnswer) {
        if (answers) {
            self.aTextField.text = [NSString stringWithFormat:@"%@", answers[0]];
            self.bTextField.text = [NSString stringWithFormat:@"%@", answers[1]];
            self.cTextField.text = [NSString stringWithFormat:@"%@", answers[2]];
        } else {
            self.aTextField.text = @"";
            self.bTextField.text = @"";
            self.cTextField.text = @"";
        }
        self.aTextField.userInteractionEnabled = NO;
        self.bTextField.userInteractionEnabled = NO;
        self.cTextField.userInteractionEnabled = NO;
        self.aTextField.textColor = self.bgColor;
        self.bTextField.textColor = self.bgColor;
        self.cTextField.textColor = self.bgColor;
        self.aTextField.layer.borderColor = self.bgColor.CGColor;
        self.bTextField.layer.borderColor = self.bgColor.CGColor;
        self.cTextField.layer.borderColor = self.bgColor.CGColor;
    } else {
        self.aTextField.userInteractionEnabled = YES;
        self.bTextField.userInteractionEnabled = YES;
        self.cTextField.userInteractionEnabled = YES;
    }
}

- (void)check:(MathAnswerSheetTextField *)firstResponder
{
    [super check:firstResponder];
    NSArray *fields = @[self.aTextField, self.bTextField, self.cTextField];
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
    NSString *bAnswer = [NSString stringWithFormat:@"%@", answers[1]];
    NSString *cAnswer = [NSString stringWithFormat:@"%@", answers[2]];
    
    if ([self.aTextField.text isEqualToString:aAnswer] &&
        [self.bTextField.text isEqualToString:bAnswer] &&
        [self.cTextField.text isEqualToString:cAnswer] ) {
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
    if (firstResponder == self.aTextField || firstResponder == self.bTextField || firstResponder == self.cTextField) {
        if (number.length >= 4) {
            return;
        }
    }
    firstResponder.text = number;
}

- (void)setupSubviews {
    // contentView
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LearnMathScale(80.0));
        make.bottom.equalTo(self).offset(-LearnMathScale(20.0));
        make.leading.equalTo(self).offset(LearnMathScale(30.0));
        make.trailing.equalTo(self).offset(-LearnMathScale(10.0));
    }];
    
    UIFont *labelFont40 = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    UIFont *labelFont30 = [UIFont ap_baloo:LearnMathScale(30.0) weight:UIFontWeightRegular];
    UIFont *labelFont28 = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    UIColor *skillColor = [UIColor colorForSet:ColorSetSkillTitle];

    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.aTextField.font = [UIFont ap_baloo:LearnMathScale(30.0) weight:UIFontWeightRegular];
    [self.contentView addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.trailing.equalTo(self.contentView.mas_trailing);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    self.equalLabel = [[MathAnswerSheetLabel alloc] init];
    self.equalLabel.text = @"=";
    self.equalLabel.textAlignment = NSTextAlignmentCenter;
    self.equalLabel.font = labelFont40;
    self.equalLabel.textColor = skillColor;
    [self.contentView addSubview:self.equalLabel];
    [self.equalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.aTextField.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(29.0), LearnMathScale(54.0)));
    }];

    self.bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.bNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.bNumberLabel.font = labelFont40;
    self.bNumberLabel.textColor = skillColor;
    self.bNumberLabel.text = @"5";
    [self.contentView addSubview:self.bNumberLabel];
    [self.bNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.equalLabel.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.height.mas_equalTo(LearnMathScale(54.0));
    }];

   
    self.divLabel = [[MathAnswerSheetLabel alloc] init];
    self.divLabel.text = @"÷";
    self.divLabel.textAlignment = NSTextAlignmentCenter;
    self.divLabel.font = labelFont40;
    self.divLabel.textColor = skillColor;
    [self.contentView addSubview:self.divLabel];
    [self.divLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bNumberLabel.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(54.0)));
    }];

    self.aNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.aNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.aNumberLabel.font = labelFont40;
    self.aNumberLabel.textColor = skillColor;
    [self.contentView addSubview:self.aNumberLabel];
    [self.aNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.divLabel.mas_leading);
        make.centerY.equalTo(self.aTextField);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(80.0), LearnMathScale(54.0)));
        make.leading.equalTo(self.contentView.mas_leading);
    }];

    self.div2Label = [[MathAnswerSheetLabel alloc] init];
    self.div2Label.text = @"x";
    self.div2Label.textAlignment = NSTextAlignmentCenter;
    self.div2Label.font = labelFont40;
    self.div2Label.textColor = skillColor;
    [self.contentView addSubview:self.div2Label];
    [self.div2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bNumberLabel.mas_bottom).offset(LearnMathScale(30.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(54.0)));
        make.centerX.equalTo(self.bNumberLabel);
    }];

    self.bTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.bTextField.font = labelFont28;
    [self.contentView addSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.div2Label);
        make.trailing.equalTo(self.div2Label.mas_leading);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.bTextField];

    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.cTextField.font = labelFont28;
    [self.contentView addSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.div2Label);
        make.leading.equalTo(self.div2Label.mas_trailing);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.cTextField];
   
    self.mulLabel = [[MathAnswerSheetLabel alloc] init];
    self.mulLabel.text = @"÷";
    self.mulLabel.textAlignment = NSTextAlignmentCenter;
    self.mulLabel.font = labelFont40;
    self.mulLabel.textColor = skillColor;
    [self.contentView addSubview:self.mulLabel];
    [self.mulLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bTextField.mas_leading).offset(-LearnMathScale(10.0));
        make.centerY.equalTo(self.div2Label);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(30.0), LearnMathScale(54.0)));
    }];
    
    self.a1NumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.a1NumberLabel.textAlignment = NSTextAlignmentCenter;
    self.a1NumberLabel.font = labelFont30;
    self.a1NumberLabel.textColor = skillColor;
    [self.contentView addSubview:self.a1NumberLabel];
    [self.a1NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mulLabel.mas_leading).offset(-LearnMathScale(10.0));
        make.centerY.equalTo(self.div2Label);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(50.0), LearnMathScale(54.0)));
    }];

    if (!self.isShowAnswer) {
        [self.bTextField becomeFirstResponder];
    }
}

- (void)drawLines
{
    [self layoutIfNeeded];
    
}

@end
