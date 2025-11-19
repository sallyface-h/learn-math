//
//  MathAnswerSheetQuestionMulColumnVerticalFormTableView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionMulColumnVerticalFormTableView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionMulColumnVerticalFormTableView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIStackView *aStackView;
@property (nonatomic, strong) MathAnswerSheetLabel *aOneLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *aTenLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *aHundredLabel;

@property (nonatomic, strong) MathAnswerSheetLabel *mulLabel;

@property (nonatomic, strong) UIStackView *bStackView;
@property (nonatomic, strong) MathAnswerSheetLabel *bOneLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bTenLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bHundredLabel;

@property (nonatomic, strong) UIStackView *textFieldStackView;
@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;

@property (nonatomic, strong) UIStackView *textField1StackView;
@property (nonatomic, strong) MathAnswerSheetTextField *dTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *eTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *fTextField;

@property (nonatomic, strong) MathAnswerSheetLabel *plusLabel;

@property (nonatomic, strong) UIStackView *textField2StackView;
@property (nonatomic, strong) MathAnswerSheetTextField *gTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *hTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *iTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *jTextField;

@end

@implementation MathAnswerSheetQuestionMulColumnVerticalFormTableView
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
        NSString *aOne = [NSString stringWithFormat:@"%@", numbers[0]];
        NSString *aTen = [NSString stringWithFormat:@"%@", numbers[1]];
        NSString *aHundred = @"0";
        
        NSString *bOne = [NSString stringWithFormat:@"%@", numbers[2]];
        NSString *bTen = [NSString stringWithFormat:@"%@", numbers[3]];
        NSString *bHundred = @"0";
        
        self.aOneLabel.text = aOne;
        self.aTenLabel.text = aTen;
        self.aHundredLabel.text = aHundred;
        if ([aHundred isEqualToString:@"0"]) {
            self.aTenLabel.hidden = [aTen isEqualToString:@"0"];
            self.aHundredLabel.hidden = YES;
        } else {
            self.aTenLabel.hidden = NO;
            self.aHundredLabel.hidden = NO;
        }
        
        self.bOneLabel.text = bOne;
        self.bTenLabel.text = bTen;
        self.bHundredLabel.text = bHundred;
        if ([bHundred isEqualToString:@"0"]) {
            self.bTenLabel.hidden = [bTen isEqualToString:@"0"];
            self.bHundredLabel.hidden = YES;
        } else {
            self.bTenLabel.hidden = NO;
            self.bHundredLabel.hidden = NO;
        }
    } else {
        self.aOneLabel.text = @"";
        self.aTenLabel.text = @"";
        self.aHundredLabel.text = @"";
        self.bOneLabel.text = @"";
        self.bTenLabel.text = @"";
        self.bHundredLabel.text = @"";
    }
    
    if (answers) {
        NSString *r1 = [NSString stringWithFormat:@"%@", answers[0]];
        NSString *r2 = [NSString stringWithFormat:@"%@", answers[1]];
        NSString *r3 = [NSString stringWithFormat:@"%@", answers[2]];
        NSString *r4 = [NSString stringWithFormat:@"%@", answers[3]];
        NSString *r5 = [NSString stringWithFormat:@"%@", answers[4]];
        NSString *r6 = [NSString stringWithFormat:@"%@", answers[5]];
        NSString *r7 = [NSString stringWithFormat:@"%@", answers[6]];
        NSString *r8 = [NSString stringWithFormat:@"%@", answers[7]];
        NSString *r9 = [NSString stringWithFormat:@"%@", answers[8]];
        NSString *r10 = [NSString stringWithFormat:@"%@", answers[9]];
        
        if (self.isShowAnswer) {
            self.aTextField.text = [NSString stringWithFormat:@"%@", r1];
            self.bTextField.text = [NSString stringWithFormat:@"%@", r2];
            self.cTextField.text = [NSString stringWithFormat:@"%@", r3];
            self.dTextField.text = [NSString stringWithFormat:@"%@", r4];
            self.eTextField.text = [NSString stringWithFormat:@"%@", r5];
            self.fTextField.text = [NSString stringWithFormat:@"%@", r6];
            self.gTextField.text = [NSString stringWithFormat:@"%@", r7];
            self.hTextField.text = [NSString stringWithFormat:@"%@", r8];
            self.iTextField.text = [NSString stringWithFormat:@"%@", r9];
            self.jTextField.text = [NSString stringWithFormat:@"%@", r10];
        
            self.aTextField.userInteractionEnabled = NO;
            self.bTextField.userInteractionEnabled = NO;
            self.cTextField.userInteractionEnabled = NO;
            self.dTextField.userInteractionEnabled = NO;
            self.eTextField.userInteractionEnabled = NO;
            self.fTextField.userInteractionEnabled = NO;
            self.gTextField.userInteractionEnabled = NO;
            self.hTextField.userInteractionEnabled = NO;
            self.iTextField.userInteractionEnabled = NO;
            self.jTextField.userInteractionEnabled = NO;
            
            self.aTextField.layer.borderColor = self.bgColor.CGColor;
            self.bTextField.layer.borderColor = self.bgColor.CGColor;
            self.cTextField.layer.borderColor = self.bgColor.CGColor;
            self.dTextField.layer.borderColor = self.bgColor.CGColor;
            self.eTextField.layer.borderColor = self.bgColor.CGColor;
            self.fTextField.layer.borderColor = self.bgColor.CGColor;
            self.gTextField.layer.borderColor = self.bgColor.CGColor;
            self.hTextField.layer.borderColor = self.bgColor.CGColor;
            self.iTextField.layer.borderColor = self.bgColor.CGColor;
            self.jTextField.layer.borderColor = self.bgColor.CGColor;
            
            self.aTextField.textColor = self.bgColor;
            self.bTextField.textColor = self.bgColor;
            self.cTextField.textColor = self.bgColor;
            self.dTextField.textColor = self.bgColor;
            self.eTextField.textColor = self.bgColor;
            self.fTextField.textColor = self.bgColor;
            self.gTextField.textColor = self.bgColor;
            self.hTextField.textColor = self.bgColor;
            self.iTextField.textColor = self.bgColor;
            self.jTextField.textColor = self.bgColor;
        } else {
            self.aTextField.text = @"";
            self.bTextField.text = @"";
            self.cTextField.text = @"";
            self.dTextField.text = @"";
            self.eTextField.text = @"";
            self.fTextField.text = @"";
            self.gTextField.text = @"";
            self.hTextField.text = @"";
            self.iTextField.text = @"";
            self.jTextField.text = @"";
            
            self.aTextField.userInteractionEnabled = YES;
            self.bTextField.userInteractionEnabled = YES;
            self.cTextField.userInteractionEnabled = YES;
            self.dTextField.userInteractionEnabled = YES;
            self.eTextField.userInteractionEnabled = YES;
            self.fTextField.userInteractionEnabled = YES;
            self.gTextField.userInteractionEnabled = YES;
            self.hTextField.userInteractionEnabled = YES;
            self.iTextField.userInteractionEnabled = YES;
            self.jTextField.userInteractionEnabled = YES;
        }
        if ([r3 isEqualToString:@"0"]) {
            self.bTextField.hidden = [r2 isEqualToString:@"0"];
            self.cTextField.hidden = YES;
        } else {
            self.bTextField.hidden = NO;
            self.cTextField.hidden = NO;
        }
        
        if ([r6 isEqualToString:@"0"]) {
            self.eTextField.hidden = [r5 isEqualToString:@"0"];
            self.fTextField.hidden = YES;
        } else {
            self.eTextField.hidden = NO;
            self.fTextField.hidden = NO;
        }
        
        if ([r10 isEqualToString:@"0"]) {
            self.hTextField.hidden = [r9 isEqualToString:@"0"];
            if (self.hTextField.hidden) {
                self.iTextField.hidden = [r8 isEqualToString:@"0"];
                self.jTextField.hidden = YES;
            } else {
                self.iTextField.hidden = NO;
                self.jTextField.hidden = YES;
            }
        } else {
            self.hTextField.hidden = NO;
            self.iTextField.hidden = NO;
            self.jTextField.hidden = NO;
        }
    } else {
        self.aTextField.text = nil;
        self.aTextField.hidden = YES;
        self.bTextField.text = nil;
        self.bTextField.hidden = YES;
        self.cTextField.text = nil;
        self.cTextField.hidden = YES;
        self.dTextField.text = nil;
        self.dTextField.hidden = YES;
        self.eTextField.text = nil;
        self.eTextField.hidden = YES;
        self.fTextField.text = nil;
        self.fTextField.hidden = YES;
        self.gTextField.text = nil;
        self.gTextField.hidden = YES;
        self.hTextField.text = nil;
        self.hTextField.hidden = YES;
        self.iTextField.text = nil;
        self.iTextField.hidden = YES;
        self.jTextField.text = nil;
        self.jTextField.hidden = YES;
    }
}

- (void)check:(MathAnswerSheetTextField *)firstResponder
{
    [super check:firstResponder];
    NSString *aText = self.aTextField.text ?: @"";
       BOOL isAHidden = self.aTextField.hidden;
       if (!isAHidden && aText.length == 0) {
           
           return;
       }
    
    NSString *bText = self.bTextField.text ?: @"";
    BOOL isBHidden = self.bTextField.hidden;
    if (!isBHidden && bText.length == 0) {
        
        return;
    }
    
    NSString *cText = self.cTextField.text ?: @"";
    BOOL isCHidden = self.cTextField.hidden;
    if (!isCHidden && cText.length == 0) {
        
        return;
    }
    
    NSString *dText = self.dTextField.text ?: @"";
       BOOL isDHidden = self.dTextField.hidden;
       if (!isDHidden && dText.length == 0) {
           
           return;
       }
    
    NSString *eText = self.eTextField.text ?: @"";
    BOOL isEHidden = self.eTextField.hidden;
    if (!isEHidden && eText.length == 0) {
        
        return;
    }
    
    NSString *fText = self.fTextField.text ?: @"";
    BOOL isFHidden = self.fTextField.hidden;
    if (!isFHidden && fText.length == 0) {
       
        return;
    }
    
    NSString *gText = self.gTextField.text ?: @"";
       BOOL isGHidden = self.gTextField.hidden;
       if (!isGHidden && gText.length == 0) {
           
           return;
       }
    
    NSString *hText = self.hTextField.text ?: @"";
    BOOL isHHidden = self.hTextField.hidden;
    if (!isHHidden && hText.length == 0) {
       
        return;
    }
    
    NSString *iText = self.iTextField.text ?: @"";
    BOOL isIHidden = self.iTextField.hidden;
    if (!isIHidden && iText.length == 0) {
        
        return;
    }
    
    NSString *jText = self.jTextField.text ?: @"";
    BOOL isJHidden = self.jTextField.hidden;
    if (!isJHidden && jText.length == 0) {
       
        return;
    }
    
    NSArray *answers = self.task.question.answer.answers;
    if (answers.count < 10) {
        
        return;
    }

    NSString *r1 = [NSString stringWithFormat:@"%@", answers[0]];
    NSString *r2 = [NSString stringWithFormat:@"%@", answers[1]];
    NSString *r3 = [NSString stringWithFormat:@"%@", answers[2]];
    NSString *r4 = [NSString stringWithFormat:@"%@", answers[3]];
    NSString *r5 = [NSString stringWithFormat:@"%@", answers[4]];
    NSString *r6 = [NSString stringWithFormat:@"%@", answers[5]];
    NSString *r7 = [NSString stringWithFormat:@"%@", answers[6]];
    NSString *r8 = [NSString stringWithFormat:@"%@", answers[7]];
    NSString *r9 = [NSString stringWithFormat:@"%@", answers[8]];
    NSString *r10 = [NSString stringWithFormat:@"%@", answers[9]];

    BOOL success = YES;

    if (!isAHidden && ![r1 isEqualToString:aText]) success = NO;
    if (!isBHidden && ![r2 isEqualToString:bText]) success = NO;
    if (!isCHidden && ![r3 isEqualToString:cText]) success = NO;
    if (!isDHidden && ![r4 isEqualToString:dText]) success = NO;
    if (!isEHidden && ![r5 isEqualToString:eText]) success = NO;
    if (!isFHidden && ![r6 isEqualToString:fText]) success = NO;
    if (!isGHidden && ![r7 isEqualToString:gText]) success = NO;
    if (!isHHidden && ![r8 isEqualToString:hText]) success = NO;
    if (!isIHidden && ![r9 isEqualToString:iText]) success = NO;
    if (!isJHidden && ![r10 isEqualToString:jText]) success = NO;

    if (success) {
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
    if (number.length >= 2) {
            return;
        }
    firstResponder.text = number;
}

- (void)setupSubviews {
    // contentView
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LearnMathScale(10.0));
        make.bottom.equalTo(self).offset(-LearnMathScale(10.0));
        make.leading.equalTo(self).offset(LearnMathScale(20.0));
        make.trailing.equalTo(self).offset(-LearnMathScale(20.0));
    }];
    
    // aStackView
    self.aStackView = [[UIStackView alloc] init];
    self.aStackView.distribution = UIStackViewDistributionFill;
    self.aStackView.axis = UILayoutConstraintAxisHorizontal;
    self.aStackView.alignment = UIStackViewAlignmentFill;
    self.aStackView.spacing = LearnMathScale(5.0);
    [self.contentView addSubview:self.aStackView];
    [self.aStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView);
    }];
    
    // aHundredLabel
    self.aHundredLabel = [[MathAnswerSheetLabel alloc] init];
    self.aHundredLabel.textAlignment = NSTextAlignmentCenter;
    self.aHundredLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aHundredLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.aStackView addArrangedSubview:self.aHundredLabel];
    [self.aHundredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    // aTenLabel
    self.aTenLabel = [[MathAnswerSheetLabel alloc] init];
    self.aTenLabel.textAlignment = NSTextAlignmentCenter;
    self.aTenLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aTenLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.aStackView addArrangedSubview:self.aTenLabel];
    [self.aTenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    // aOneLabel
    self.aOneLabel = [[MathAnswerSheetLabel alloc] init];
    self.aOneLabel.textAlignment = NSTextAlignmentCenter;
    self.aOneLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aOneLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.aStackView addArrangedSubview:self.aOneLabel];
    [self.aOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    // bStackView
    self.bStackView = [[UIStackView alloc] init];
    self.bStackView.distribution = UIStackViewDistributionFill;
    self.bStackView.axis = UILayoutConstraintAxisHorizontal;
    self.bStackView.alignment = UIStackViewAlignmentFill;
    self.bStackView.spacing = LearnMathScale(5.0);
    [self.contentView addSubview:self.bStackView];
    [self.bStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aStackView.mas_bottom).offset(LearnMathScale(15.0));
        make.trailing.equalTo(self.aStackView);
    }];
    
    // bHundredLabel
    self.bHundredLabel = [[MathAnswerSheetLabel alloc] init];
    self.bHundredLabel.textAlignment = NSTextAlignmentCenter;
    self.bHundredLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.bHundredLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.bStackView addArrangedSubview:self.bHundredLabel];
    [self.bHundredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    // bTenLabel
    self.bTenLabel = [[MathAnswerSheetLabel alloc] init];
    self.bTenLabel.textAlignment = NSTextAlignmentCenter;
    self.bTenLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.bTenLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.bStackView addArrangedSubview:self.bTenLabel];
    [self.bTenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    // bOneLabel
    self.bOneLabel = [[MathAnswerSheetLabel alloc] init];
    self.bOneLabel.textAlignment = NSTextAlignmentCenter;
    self.bOneLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.bOneLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.bStackView addArrangedSubview:self.bOneLabel];
    [self.bOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    // mulLabel
    self.mulLabel = [[MathAnswerSheetLabel alloc] init];
    self.mulLabel.text = @"x";
    self.mulLabel.textAlignment = NSTextAlignmentCenter;
    self.mulLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.mulLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.mulLabel];
    [self.mulLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.centerY.equalTo(self.bStackView);
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    // textFieldStackView
    self.textFieldStackView = [[UIStackView alloc] init];
    self.textFieldStackView.distribution = UIStackViewDistributionFill;
    self.textFieldStackView.axis = UILayoutConstraintAxisHorizontal;
    self.textFieldStackView.alignment = UIStackViewAlignmentFill;
    self.textFieldStackView.spacing = LearnMathScale(5.0);
    [self.contentView addSubview:self.textFieldStackView];
    [self.textFieldStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bStackView.mas_bottom).offset(LearnMathScale(15.0));
        make.trailing.equalTo(self.aStackView);
    }];
    
    // cTextField
    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textFieldStackView addArrangedSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.cTextField];
    
    // bTextField
    self.bTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textFieldStackView addArrangedSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.bTextField];
    
    // aTextField
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textFieldStackView addArrangedSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    // textField1StackView
    self.textField1StackView = [[UIStackView alloc] init];
    self.textField1StackView.distribution = UIStackViewDistributionFill;
    self.textField1StackView.axis = UILayoutConstraintAxisHorizontal;
    self.textField1StackView.alignment = UIStackViewAlignmentFill;
    self.textField1StackView.spacing = LearnMathScale(5.0);
    [self.contentView addSubview:self.textField1StackView];
    [self.textField1StackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bTextField);
        make.top.equalTo(self.textFieldStackView.mas_bottom).offset(LearnMathScale(15.0));
    }];
    
    // fTextField
    self.fTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textField1StackView addArrangedSubview:self.fTextField];
    [self.fTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.fTextField];
    
    // eTextField
    self.eTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textField1StackView addArrangedSubview:self.eTextField];
    [self.eTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.eTextField];
    
    // dTextField
    self.dTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textField1StackView addArrangedSubview:self.dTextField];
    [self.dTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.dTextField];
    
    // plusLabel
    self.plusLabel = [[MathAnswerSheetLabel alloc] init];
    self.plusLabel.text = @"+";
    self.plusLabel.textAlignment = NSTextAlignmentCenter;
    self.plusLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.plusLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.plusLabel];
    [self.plusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.centerY.equalTo(self.textField1StackView);
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    // textField2StackView
    self.textField2StackView = [[UIStackView alloc] init];
    self.textField2StackView.distribution = UIStackViewDistributionFill;
    self.textField2StackView.axis = UILayoutConstraintAxisHorizontal;
    self.textField2StackView.alignment = UIStackViewAlignmentFill;
    self.textField2StackView.spacing = LearnMathScale(5.0);
    [self.contentView addSubview:self.textField2StackView];
    [self.textField2StackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.aStackView);
        make.top.equalTo(self.textField1StackView.mas_bottom).offset(LearnMathScale(15.0));
    }];
    
    // jTextField
    self.jTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textField2StackView addArrangedSubview:self.jTextField];
    [self.jTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.jTextField];
    
    // iTextField
    self.iTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textField2StackView addArrangedSubview:self.iTextField];
    [self.iTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.iTextField];
    
    // hTextField
    self.hTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textField2StackView addArrangedSubview:self.hTextField];
    [self.hTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.hTextField];
    
    // gTextField
    self.gTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    [self.textField2StackView addArrangedSubview:self.gTextField];
    [self.gTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.gTextField];
    

    if (!self.isShowAnswer) {
        [self.aTextField becomeFirstResponder];
    }
}

- (void)drawLines
{
    [self layoutIfNeeded];
    UIBezierPath *firstLinePath = [UIBezierPath bezierPath];
    CGFloat y = CGRectGetMaxY(self.bStackView.frame) + (CGRectGetMinY(self.textFieldStackView.frame) - CGRectGetMaxY(self.bStackView.frame)) * 0.5;
    [firstLinePath moveToPoint:CGPointMake(0, y)];
    [firstLinePath addLineToPoint:CGPointMake(self.contentView.frame.size.width, y)];
    
    CAShapeLayer *firstLayer = [CAShapeLayer layer];
    firstLayer.path = firstLinePath.CGPath;
    firstLayer.strokeColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
    firstLayer.fillColor = [UIColor clearColor].CGColor;
    firstLayer.lineCap = kCALineCapRound;
    firstLayer.lineWidth = LearnMathScale(5.5);
    [self.contentView.layer addSublayer:firstLayer];
    
    UIBezierPath *secondLinePath = [UIBezierPath bezierPath];
    CGFloat y1 = CGRectGetMaxY(self.textField1StackView.frame) + (CGRectGetMinY(self.textField2StackView.frame) - CGRectGetMaxY(self.textField1StackView.frame)) * 0.5;
    [secondLinePath moveToPoint:CGPointMake(0, y1)];
    [secondLinePath addLineToPoint:CGPointMake(self.contentView.frame.size.width, y1)];
    
    CAShapeLayer *secondLayer = [CAShapeLayer layer];
    secondLayer.path = secondLinePath.CGPath;
    secondLayer.strokeColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
    secondLayer.fillColor = [UIColor clearColor].CGColor;
    secondLayer.lineCap = kCALineCapRound;
    secondLayer.lineWidth = LearnMathScale(5.5);
    [self.contentView.layer addSublayer:secondLayer];
}
@end
