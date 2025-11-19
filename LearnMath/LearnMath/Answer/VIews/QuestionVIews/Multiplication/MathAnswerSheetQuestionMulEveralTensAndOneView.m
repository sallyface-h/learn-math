//
//  MathAnswerSheetQuestionMulEveralTensAndOneView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionMulEveralTensAndOneView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionMulEveralTensAndOneView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIStackView *aStackView;
@property (nonatomic, strong) UILabel *aOneLabel;
@property (nonatomic, strong) UILabel *aTenLabel;
@property (nonatomic, strong) UILabel *aHundredLabel;

@property (nonatomic, strong) UILabel *mulLabel;

@property (nonatomic, strong) UIStackView *bStackView;
@property (nonatomic, strong) UILabel *bOneLabel;
@property (nonatomic, strong) UILabel *bTenLabel;
@property (nonatomic, strong) UILabel *bHundredLabel;

@property (nonatomic, strong) UILabel *aEnterLabel;

@property (nonatomic, strong) UIStackView *textFieldStackView;
@property (nonatomic, strong) MathAnswerSheetLabel *aResultLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;

@property (nonatomic, strong) UIButton *aTipButton;
@property (nonatomic, strong) UIButton *bTipButton;

@end
@implementation MathAnswerSheetQuestionMulEveralTensAndOneView
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
        NSString *aTen = [NSString stringWithFormat:@"%@", numbers[0]];
        NSString *aHundred = @"0";
        
        NSString *bTen = [NSString stringWithFormat:@"%@", numbers[1]];
        NSString *bHundred = @"0";
        
        self.aTenLabel.text = aTen;
        self.aHundredLabel.text = aHundred;
        if ([aHundred isEqualToString:@"0"]) {
            self.aTenLabel.hidden = [aTen isEqualToString:@"0"];
            self.aHundredLabel.hidden = YES;
        } else {
            self.aTenLabel.hidden = NO;
            self.aHundredLabel.hidden = NO;
        }
        
        self.bTenLabel.text = bTen;
        self.bHundredLabel.text = bHundred;
        if ([bHundred isEqualToString:@"0"]) {
            self.bTenLabel.hidden = [bTen isEqualToString:@"0"];
            self.bHundredLabel.hidden = YES;
        } else {
            self.bTenLabel.hidden = NO;
            self.bHundredLabel.hidden = NO;
        }
        [self.aTipButton setTitle:[NSString stringWithFormat:@"%@ x %@", aTen, bTen] forState:UIControlStateNormal];
        [self.bTipButton setTitle:[NSString stringWithFormat:@"%@ + %@", aTen, bTen] forState:UIControlStateNormal];
    } else {
        self.aTenLabel.text = @"";
        self.aHundredLabel.text = @"";
        self.bTenLabel.text = @"";
        self.bHundredLabel.text = @"";
        [self.aTipButton setTitle:nil forState:UIControlStateNormal];
        [self.bTipButton setTitle:nil forState:UIControlStateNormal];
    }
    
    if (answers) {
        NSString *r1 = [NSString stringWithFormat:@"%@", answers[0]];
        NSString *r2 = [NSString stringWithFormat:@"%@", answers[1]];
        NSString *r3 = [NSString stringWithFormat:@"%@", answers[2]];
        NSString *r4 = [NSString stringWithFormat:@"%@", answers[3]];
        self.aEnterLabel.text = r4;
        self.aEnterLabel.hidden = [r4 isEqualToString:@"0"];
        
        if (self.isShowAnswer) {
            self.aTextField.text = r1;
            self.bTextField.text = r2;
            self.cTextField.text = r3;
            
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
        if ([r3 isEqualToString:@"0"]) {
            self.bTextField.hidden = [r2 isEqualToString:@"0"];
            self.cTextField.hidden = YES;
        } else {
            self.bTextField.hidden = NO;
            self.cTextField.hidden = NO;
        }
        
        if ([r3 isEqualToString:@"0"]) {
            self.bTextField.hidden = [r2 isEqualToString:@"0"];
            self.cTextField.hidden = YES;
        } else {
            self.bTextField.hidden = NO;
            self.cTextField.hidden = NO;
        }
    } else {
        self.aEnterLabel.text = nil;
        self.aEnterLabel.hidden = YES;
        self.aTextField.text = nil;
        self.aTextField.hidden = YES;
        self.bTextField.text = nil;
        self.bTextField.hidden = YES;
        self.cTextField.text = nil;
        self.cTextField.hidden = YES;
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

    NSNumber *r1 = self.task.question.answer.answers[0];
    NSNumber *r2 = self.task.question.answer.answers[1];
    NSNumber *r3 = self.task.question.answer.answers[2];
    if (!r1 || !r2 || !r3) {
        
        return;
    }

    BOOL success = YES;
    if (!isAHidden && ![[NSString stringWithFormat:@"%@", r1] isEqualToString:aText]) {
        success = NO;
    }
    if (!isBHidden && ![[NSString stringWithFormat:@"%@", r2] isEqualToString:bText]) {
        success = NO;
    }
    if (!isCHidden && ![[NSString stringWithFormat:@"%@", r3] isEqualToString:cText]) {
        success = NO;
    }

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
        make.top.mas_equalTo(10.0);
        make.bottom.mas_equalTo(-10.0);
        make.leading.mas_equalTo(20.0);
        make.trailing.mas_equalTo(-20.0);
    }];
    
    // aStackView
    self.aStackView = [[UIStackView alloc] init];
    self.aStackView.axis = UILayoutConstraintAxisHorizontal;
    self.aStackView.distribution = UIStackViewDistributionFill;
    self.aStackView.alignment = UIStackViewAlignmentFill;
    self.aStackView.spacing = 5.0;
    [self.contentView addSubview:self.aStackView];
    [self.aStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.trailing.equalTo(self.contentView.mas_trailing);
    }];
    
    self.aOneLabel = [[MathAnswerSheetLabel alloc] init];
    self.aOneLabel.textAlignment = NSTextAlignmentCenter;
    self.aOneLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aOneLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    self.aOneLabel.text = @"1";
    
    self.aTenLabel = [[MathAnswerSheetLabel alloc] init];
    self.aTenLabel.textAlignment = NSTextAlignmentCenter;
    self.aTenLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aTenLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    
    self.aHundredLabel = [[MathAnswerSheetLabel alloc] init];
    self.aHundredLabel.textAlignment = NSTextAlignmentCenter;
    self.aHundredLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aHundredLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    
    [self.aStackView addArrangedSubview:self.aHundredLabel];
    [self.aHundredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(48.0);
    }];
    [self.aStackView addArrangedSubview:self.aTenLabel];
    [self.aTenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(48.0);
    }];
    [self.aStackView addArrangedSubview:self.aOneLabel];
    [self.aOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(48.0);
    }];
    
    // bStackView
    self.bStackView = [[UIStackView alloc] init];
    self.bStackView.axis = UILayoutConstraintAxisHorizontal;
    self.bStackView.distribution = UIStackViewDistributionFill;
    self.bStackView.alignment = UIStackViewAlignmentFill;
    self.bStackView.spacing = 5.0;
    [self.contentView addSubview:self.bStackView];
    [self.bStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aStackView.mas_bottom).offset(15.0);
        make.trailing.equalTo(self.aStackView);
    }];
    
    self.bOneLabel = [[MathAnswerSheetLabel alloc] init];
    self.bOneLabel.textAlignment = NSTextAlignmentCenter;
    self.bOneLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.bOneLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    self.bOneLabel.text = @"1";
    
    self.bTenLabel = [[MathAnswerSheetLabel alloc] init];
    self.bTenLabel.textAlignment = NSTextAlignmentCenter;
    self.bTenLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.bTenLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    
    self.bHundredLabel = [[MathAnswerSheetLabel alloc] init];
    self.bHundredLabel.textAlignment = NSTextAlignmentCenter;
    self.bHundredLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.bHundredLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    
    [self.bStackView addArrangedSubview:self.bHundredLabel];
    [self.bHundredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(48.0);
    }];
    [self.bStackView addArrangedSubview:self.bTenLabel];
    [self.bTenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(48.0);
    }];
    [self.bStackView addArrangedSubview:self.bOneLabel];
    [self.bOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(48.0);
    }];
    
    // mulLabel
    self.mulLabel = [[MathAnswerSheetLabel alloc] init];
    self.mulLabel.text = @"x";
    self.mulLabel.textAlignment = NSTextAlignmentCenter;
    self.mulLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.mulLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.contentView addSubview:self.mulLabel];
    [self.mulLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading);
        make.centerY.equalTo(self.bStackView);
        make.size.mas_equalTo(48.0);
    }];
    
    // aEnterLabel
    self.aEnterLabel = [[MathAnswerSheetLabel alloc] init];
    self.aEnterLabel.textAlignment = NSTextAlignmentCenter;
    self.aEnterLabel.font = [UIFont ap_baloo:LearnMathScale(20.0) weight:UIFontWeightRegular];
    self.aEnterLabel.textColor = self.bgColor;
    [self.contentView addSubview:self.aEnterLabel];
    [self.aEnterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bTenLabel.mas_leading).offset(5.0);
        make.bottom.equalTo(self.bTenLabel);
        make.size.mas_equalTo(CGSizeMake(15.0, 30.0));
    }];
    
    // textFieldStackView
    self.textFieldStackView = [[UIStackView alloc] init];
    self.textFieldStackView.axis = UILayoutConstraintAxisHorizontal;
    self.textFieldStackView.distribution = UIStackViewDistributionFill;
    self.textFieldStackView.alignment = UIStackViewAlignmentFill;
    self.textFieldStackView.spacing = 5.0;
    [self.contentView addSubview:self.textFieldStackView];
    [self.textFieldStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bStackView.mas_bottom).offset(15.0);
        make.trailing.equalTo(self.aStackView);
    }];
    
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(2, 2, 2, 2) bgColor:self.bgColor];
    self.aTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    
    self.bTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(2, 2, 2, 2) bgColor:self.bgColor];
    self.bTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    
    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(2, 2, 2, 2) bgColor:self.bgColor];
    self.cTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    
    self.aResultLabel = [[MathAnswerSheetLabel alloc] init];
    self.aResultLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    self.aResultLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    self.aResultLabel.textAlignment = NSTextAlignmentCenter;
    self.aResultLabel.text = @"1";
    
    [self.textFieldStackView addArrangedSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) { make.size.mas_equalTo(48.0); }];
    [self.textFieldStackView addArrangedSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) { make.size.mas_equalTo(48.0); }];
    [self.textFieldStackView addArrangedSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) { make.size.mas_equalTo(48.0); }];
    [self.textFieldStackView addArrangedSubview:self.aResultLabel];
    [self.aResultLabel mas_makeConstraints:^(MASConstraintMaker *make) { make.size.mas_equalTo(48.0); }];
    
    // aTipButton
    self.aTipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.aTipButton.userInteractionEnabled = NO;
    self.aTipButton.titleLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    [self.aTipButton setTitleColor:[UIColor colorForSet:ColorSetSkillTitle] forState:UIControlStateNormal];
    self.aTipButton.layer.cornerRadius = 5.0;
    self.aTipButton.layer.borderWidth = 5.5;
    self.aTipButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
    [self.contentView addSubview:self.aTipButton];
    [self.aTipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading);
        make.bottom.mas_equalTo(-8.0);
        make.size.mas_equalTo(CGSizeMake(140.0, 65.0));
    }];
    
    // bTipButton
    self.bTipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bTipButton.userInteractionEnabled = NO;
    self.bTipButton.titleLabel.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    [self.bTipButton setTitleColor:[UIColor colorForSet:ColorSetSkillTitle] forState:UIControlStateNormal];
    self.bTipButton.layer.cornerRadius = 5.0;
    self.bTipButton.layer.borderWidth = 5.5;
    self.bTipButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
    [self.contentView addSubview:self.bTipButton];
    [self.bTipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.aTipButton.mas_trailing).offset(15.0);
        make.bottom.mas_equalTo(-8.0);
        make.size.mas_equalTo(CGSizeMake(140.0, 65.0));
    }];
}

- (void)drawLines {
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
    
    CGFloat y = CGRectGetMaxY(self.bStackView.frame) + (CGRectGetMinY(self.textFieldStackView.frame) - CGRectGetMaxY(self.bStackView.frame)) * 0.5;
    UIBezierPath *firstLinePath = [UIBezierPath bezierPath];
    [firstLinePath moveToPoint:CGPointMake(0, y)];
    [firstLinePath addLineToPoint:CGPointMake(self.contentView.frame.size.width, y)];
    addLine(firstLinePath);
    
    CGRect aTextFieldFrame = [self.textFieldStackView convertRect:self.aTextField.frame toView:self.contentView];
    UIBezierPath *secondLinePath = [UIBezierPath bezierPath];
    [secondLinePath moveToPoint:CGPointMake(CGRectGetMidX(aTextFieldFrame), CGRectGetMaxY(aTextFieldFrame))];
    [secondLinePath addLineToPoint:CGPointMake(CGRectGetMidX(self.bTipButton.frame), CGRectGetMinY(self.bTipButton.frame))];
    addLine(secondLinePath);
    
    if (self.cTextField.isHidden) {

        CGRect bTextFieldFrame = [self.textFieldStackView convertRect:self.bTextField.frame toView:self.contentView];
        UIBezierPath *thirdLinePath = [UIBezierPath bezierPath];
        [thirdLinePath moveToPoint:CGPointMake(CGRectGetMidX(bTextFieldFrame), CGRectGetMaxY(bTextFieldFrame))];
        [thirdLinePath addLineToPoint:CGPointMake(CGRectGetMidX(self.aTipButton.frame), CGRectGetMinY(self.aTipButton.frame))];
        addLine(thirdLinePath);
    } else {

        CGRect bTextFieldFrame = [self.textFieldStackView convertRect:self.bTextField.frame toView:self.contentView];
        CGRect cTextFieldFrame = [self.textFieldStackView convertRect:self.cTextField.frame toView:self.contentView];
        UIBezierPath *thirdLinePath = [UIBezierPath bezierPath];
        [thirdLinePath moveToPoint:CGPointMake(CGRectGetMidX(bTextFieldFrame), CGRectGetMaxY(bTextFieldFrame))];
        [thirdLinePath addLineToPoint:CGPointMake(CGRectGetMidX(bTextFieldFrame), CGRectGetMaxY(bTextFieldFrame) + LearnMathScale(9.0))];
        [thirdLinePath addLineToPoint:CGPointMake(CGRectGetMidX(cTextFieldFrame), CGRectGetMaxY(cTextFieldFrame) + LearnMathScale(9.0))];
        [thirdLinePath addLineToPoint:CGPointMake(CGRectGetMidX(cTextFieldFrame), CGRectGetMaxY(cTextFieldFrame))];
        CAShapeLayer *thirdLayer = [CAShapeLayer layer];
        thirdLayer.path = thirdLinePath.CGPath;
        thirdLayer.strokeColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
        thirdLayer.fillColor = UIColor.clearColor.CGColor;
        thirdLayer.lineCap = kCALineCapRound;
        thirdLayer.lineJoin = kCALineJoinRound;
        thirdLayer.lineWidth = LearnMathScale(5.5);
        [self.contentView.layer addSublayer:thirdLayer];
        
        UIBezierPath *fourthLinePath = [UIBezierPath bezierPath];
        [fourthLinePath moveToPoint:CGPointMake(CGRectGetMaxX(cTextFieldFrame) + LearnMathScale(2.5), CGRectGetMaxY(cTextFieldFrame) + LearnMathScale(9.0))];
        [fourthLinePath addLineToPoint:CGPointMake(CGRectGetMidX(self.aTipButton.frame), CGRectGetMinY(self.aTipButton.frame))];
        addLine(fourthLinePath);
    }
}
@end
