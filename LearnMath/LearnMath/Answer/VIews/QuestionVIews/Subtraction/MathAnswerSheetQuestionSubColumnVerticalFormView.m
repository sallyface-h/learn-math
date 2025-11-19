//
//  MathAnswerSheetQuestionSubColumnVerticalFormView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionSubColumnVerticalFormView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionSubColumnVerticalFormView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIStackView *aStackView;
@property (nonatomic, strong) MathAnswerSheetLabel *aOneLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *aTenLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *aHundredLabel;

@property (nonatomic, strong) MathAnswerSheetLabel *plusLabel;

@property (nonatomic, strong) UIStackView *bStackView;
@property (nonatomic, strong) MathAnswerSheetLabel *bOneLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bTenLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bHundredLabel;

@property (nonatomic, strong) MathAnswerSheetLabel *aEnterLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bEnterLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *cEnterLabel;

@property (nonatomic, strong) UIStackView *textFieldStackView;
@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;

@end

@implementation MathAnswerSheetQuestionSubColumnVerticalFormView
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
        NSString *aOne = [NSString stringWithFormat:@"%@", numbers[0]];
        NSString *aTen = [NSString stringWithFormat:@"%@", numbers[1]];
        NSString *aHundred = [NSString stringWithFormat:@"%@", numbers[2]];
        NSString *bOne = [NSString stringWithFormat:@"%@", numbers[3]];
        NSString *bTen = [NSString stringWithFormat:@"%@", numbers[4]];
        NSString *bHundred = [NSString stringWithFormat:@"%@", numbers[5]];
        
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
    
    if (task.question.answer.answers) {
        NSArray *answers = task.question.answer.answers;
        NSString *rCOnes = [NSString stringWithFormat:@"%@", answers[0]];
        NSString *eCOnes = [NSString stringWithFormat:@"%@", answers[1]];
        NSString *rCTens = [NSString stringWithFormat:@"%@", answers[2]];
        NSString *eCTens = [NSString stringWithFormat:@"%@", answers[3]];
        NSString *rCHundreds = [NSString stringWithFormat:@"%@", answers[4]];
        NSString *eCHundreds = [NSString stringWithFormat:@"%@", answers[5]];
        
        self.aEnterLabel.text = eCOnes;
        self.bEnterLabel.text = eCTens;
        self.cEnterLabel.text = eCHundreds;
        
        self.aEnterLabel.hidden = [eCOnes isEqualToString:@"0"];
        self.bEnterLabel.hidden = [eCTens isEqualToString:@"0"];
        self.cEnterLabel.hidden = [eCHundreds isEqualToString:@"0"];
        
        if (self.isShowAnswer) {
            self.aTextField.text = rCOnes;
            self.bTextField.text = rCTens;
            self.cTextField.text = rCHundreds;
            
            self.aTextField.userInteractionEnabled = NO;
            self.bTextField.userInteractionEnabled = NO;
            self.cTextField.userInteractionEnabled = NO;
            
            self.aTextField.layer.borderColor = self.bgColor.CGColor;
            self.bTextField.layer.borderColor = self.bgColor.CGColor;
            self.cTextField.layer.borderColor = self.bgColor.CGColor;
            
            self.aTextField.textColor = self.bgColor;
            self.bTextField.textColor = self.bgColor;
            self.cTextField.textColor = self.bgColor;
        } else {
            self.aTextField.text = nil;
            self.bTextField.text = nil;
            self.cTextField.text = nil;
            
            self.aTextField.userInteractionEnabled = YES;
            self.bTextField.userInteractionEnabled = YES;
            self.cTextField.userInteractionEnabled = YES;
        }
        
        if ([rCHundreds isEqualToString:@"0"]) {
            self.bTextField.hidden = [rCTens isEqualToString:@"0"];
            self.cTextField.hidden = YES;
        } else {
            self.bTextField.hidden = NO;
            self.cTextField.hidden = NO;
        }
    } else {
        self.aTextField.text = nil;
        self.aTextField.hidden = YES;
        self.bTextField.text = nil;
        self.bTextField.hidden = YES;
        self.cTextField.text = nil;
        self.cTextField.hidden = YES;
        
        self.aEnterLabel.text = @"";
        self.bEnterLabel.text = @"";
        self.cEnterLabel.text = @"";
    }
    self.aEnterLabel.hidden = YES;
    self.bEnterLabel.hidden = YES;
    self.cEnterLabel.hidden = YES;
}

- (void)check:(MathAnswerSheetTextField *)firstResponder
{
    [super check:firstResponder];
    NSString *aText = self.aTextField.text ?: @"";
    if (!self.aTextField.hidden && aText.length == 0) {
       
        return;
    }
    NSString *bText = self.bTextField.text ?: @"";
    if (!self.bTextField.hidden && bText.length == 0) {
        
        return;
    }
    NSString *cText = self.cTextField.text ?: @"";
    if (!self.cTextField.hidden && cText.length == 0) {
        
        return;
    }
    
    NSNumber *rCOnes = self.task.question.answer.answers[0];
    NSNumber *rCTens = self.task.question.answer.answers[2];
    NSNumber *rCHundreds = self.task.question.answer.answers[4];
    if (!rCOnes || !rCTens || !rCHundreds) {
       
        return;
    }
    
    BOOL success = YES;
    if (!self.aTextField.hidden && ![[NSString stringWithFormat:@"%@", rCOnes] isEqualToString:aText]) success = NO;
    if (!self.bTextField.hidden && ![[NSString stringWithFormat:@"%@", rCTens] isEqualToString:bText]) success = NO;
    if (!self.cTextField.hidden && ![[NSString stringWithFormat:@"%@", rCHundreds] isEqualToString:cText]) success = NO;
    
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
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(LearnMathScale(25.0), LearnMathScale(25.0), LearnMathScale(25.0), LearnMathScale(25.0)));
    }];
    
    // aStackView
    self.aStackView = [[UIStackView alloc] init];
    self.aStackView.distribution = UIStackViewDistributionFill;
    self.aStackView.axis = UILayoutConstraintAxisHorizontal;
    self.aStackView.alignment = UIStackViewAlignmentFill;
    self.aStackView.spacing = LearnMathScale(5.0);
    [self.contentView addSubview:self.aStackView];
    [self.aStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.trailing.equalTo(self.contentView.mas_trailing);
    }];
    
    // aHundredLabel
    self.aHundredLabel = [[MathAnswerSheetLabel alloc] init];
    self.aHundredLabel.textAlignment = NSTextAlignmentCenter;
    self.aHundredLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aHundredLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.aStackView addArrangedSubview:self.aHundredLabel];
    [self.aHundredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    
    // aTenLabel
    self.aTenLabel = [[MathAnswerSheetLabel alloc] init];
    self.aTenLabel.textAlignment = NSTextAlignmentCenter;
    self.aTenLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aTenLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.aStackView addArrangedSubview:self.aTenLabel];
    [self.aTenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    
    // aOneLabel
    self.aOneLabel = [[MathAnswerSheetLabel alloc] init];
    self.aOneLabel.textAlignment = NSTextAlignmentCenter;
    self.aOneLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aOneLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.aStackView addArrangedSubview:self.aOneLabel];
    [self.aOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    
    // bStackView
    self.bStackView = [[UIStackView alloc] init];
    self.bStackView.distribution = UIStackViewDistributionFill;
    self.bStackView.axis = UILayoutConstraintAxisHorizontal;
    self.bStackView.alignment = UIStackViewAlignmentFill;
    self.bStackView.spacing = LearnMathScale(5.0);
    [self.contentView addSubview:self.bStackView];
    [self.bStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aStackView.mas_bottom).offset(LearnMathScale(22.0));
        make.trailing.equalTo(self.aStackView);
    }];
    
    // bHundredLabel
    self.bHundredLabel = [[MathAnswerSheetLabel alloc] init];
    self.bHundredLabel.textAlignment = NSTextAlignmentCenter;
    self.bHundredLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.bHundredLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.bStackView addArrangedSubview:self.bHundredLabel];
    [self.bHundredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    
    // bTenLabel
    self.bTenLabel = [[MathAnswerSheetLabel alloc] init];
    self.bTenLabel.textAlignment = NSTextAlignmentCenter;
    self.bTenLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.bTenLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.bStackView addArrangedSubview:self.bTenLabel];
    [self.bTenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    
    // bOneLabel
    self.bOneLabel = [[MathAnswerSheetLabel alloc] init];
    self.bOneLabel.textAlignment = NSTextAlignmentCenter;
    self.bOneLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.bOneLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.bStackView addArrangedSubview:self.bOneLabel];
    [self.bOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    
    // plusLabel
    self.plusLabel = [[MathAnswerSheetLabel alloc] init];
    self.plusLabel.text = @"-";
    self.plusLabel.textAlignment = NSTextAlignmentCenter;
    self.plusLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.plusLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.plusLabel];
    [self.plusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading);
        make.centerY.equalTo(self.bStackView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    
    // textFieldStackView
    self.textFieldStackView = [[UIStackView alloc] init];
    self.textFieldStackView.distribution = UIStackViewDistributionFill;
    self.textFieldStackView.axis = UILayoutConstraintAxisHorizontal;
    self.textFieldStackView.alignment = UIStackViewAlignmentFill;
    self.textFieldStackView.spacing = LearnMathScale(5.0);
    [self.contentView addSubview:self.textFieldStackView];
    [self.textFieldStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.aStackView.mas_trailing);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    // cTextField
    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self.textFieldStackView addArrangedSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.cTextField];
    
    // bTextField
    self.bTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self.textFieldStackView addArrangedSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.bTextField];
    
    // aTextField
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self.textFieldStackView addArrangedSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    // aEnterLabel
    self.aEnterLabel = [[MathAnswerSheetLabel alloc] init];
    self.aEnterLabel.textAlignment = NSTextAlignmentCenter;
    self.aEnterLabel.font = [UIFont ap_baloo:LearnMathScale(20.0) weight:UIFontWeightRegular];
    self.aEnterLabel.textColor = self.bgColor;
    [self.contentView addSubview:self.aEnterLabel];
    [self.aEnterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bOneLabel.mas_leading).offset(LearnMathScale(5.0));
        make.bottom.equalTo(self.bOneLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(15.0), LearnMathScale(30.0)));
    }];
    
    // bEnterLabel
    self.bEnterLabel = [[MathAnswerSheetLabel alloc] init];
    self.bEnterLabel.textAlignment = NSTextAlignmentCenter;
    self.bEnterLabel.font = [UIFont ap_baloo:LearnMathScale(20.0) weight:UIFontWeightRegular];
    self.bEnterLabel.textColor = self.bgColor;
    [self.contentView addSubview:self.bEnterLabel];
    [self.bEnterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bTenLabel.mas_leading).offset(LearnMathScale(5.0));
        make.bottom.equalTo(self.bTenLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(15.0), LearnMathScale(30.0)));
    }];
    
    // cEnterLabel
    self.cEnterLabel = [[MathAnswerSheetLabel alloc] init];
    self.cEnterLabel.textAlignment = NSTextAlignmentCenter;
    self.cEnterLabel.font = [UIFont ap_baloo:LearnMathScale(20.0) weight:UIFontWeightRegular];
    self.cEnterLabel.textColor = self.bgColor;
    [self.contentView addSubview:self.cEnterLabel];
    [self.cEnterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bHundredLabel.mas_leading).offset(LearnMathScale(5.0));
        make.bottom.equalTo(self.bHundredLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(15.0), LearnMathScale(30.0)));
    }];
    
    if (!self.isShowAnswer) {
        [self.aTextField becomeFirstResponder];
    }
}

- (void)drawLines
{
    [self layoutIfNeeded];
    CGFloat y = CGRectGetMaxY(self.bStackView.frame) + (CGRectGetMinY(self.textFieldStackView.frame) - CGRectGetMaxY(self.bStackView.frame)) * 0.5;
        
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0.0, y)];
    [linePath addLineToPoint:CGPointMake(self.contentView.frame.size.width, y)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = linePath.CGPath;
    layer.strokeColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineWidth = LearnMathScale(5.5);
    [self.contentView.layer addSublayer:layer];
}
@end
