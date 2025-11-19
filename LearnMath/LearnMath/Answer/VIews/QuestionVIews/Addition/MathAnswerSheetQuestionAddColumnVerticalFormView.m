//
//  MathAnswerSheetQuestionAddColumnVerticalFormView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionAddColumnVerticalFormView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "MathQuestionAnswer.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"


@interface MathAnswerSheetQuestionAddColumnVerticalFormView ()

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
@property (nonatomic, assign) BOOL didDrawLines;
@end

@implementation MathAnswerSheetQuestionAddColumnVerticalFormView

- (instancetype)initWithTask:(MathQuestionsTask *)task
                   category:(ArithmeticAlgorithmCategory )category
               isShowAnswer:(BOOL)isShowAnswer
                    bgColor:(UIColor *)bgColor
                      frame:(CGRect)frame
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

    if (numbers.count >= 6) {
        NSString *aOne = [NSString stringWithFormat:@"%@", numbers[0]];
        NSString *aTen = [NSString stringWithFormat:@"%@", numbers[1]];
        NSString *aHundred = [NSString stringWithFormat:@"%@", numbers[2]];
        NSString *bOne = [NSString stringWithFormat:@"%@", numbers[3]];
        NSString *bTen = [NSString stringWithFormat:@"%@", numbers[4]];
        NSString *bHundred = [NSString stringWithFormat:@"%@", numbers[5]];
        

        self.aOneLabel.text = aOne;
        self.aTenLabel.text = aTen;
        self.aHundredLabel.text = aHundred;
        self.bOneLabel.text = bOne;
        self.bTenLabel.text = bTen;
        self.bHundredLabel.text = bHundred;

        if ([aHundred isEqualToString:@"0"]) {
            self.aTenLabel.hidden = [aTen isEqualToString:@"0"];
            self.aHundredLabel.hidden = YES;
        } else {
            self.aTenLabel.hidden = NO;
            self.aHundredLabel.hidden = NO;
        }

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

    if (answers.count >= 6) {
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

            self.aTextField.textColor = self.bgColor;
            self.bTextField.textColor = self.bgColor;
            self.cTextField.textColor = self.bgColor;
            self.aTextField.layer.borderColor = self.bgColor.CGColor;
            self.bTextField.layer.borderColor = self.bgColor.CGColor;
            self.cTextField.layer.borderColor = self.bgColor.CGColor;
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

        self.aTextField.hidden = YES;
        self.bTextField.hidden = YES;
        self.cTextField.hidden = YES;
        self.aEnterLabel.text = self.bEnterLabel.text = self.cEnterLabel.text = @"";
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
    
    NSArray *answers = self.task.question.answer.answers;
    if (answers.count < 2) {
       
        return;
    }
    
    NSNumber *rCOnes = answers[0];
    NSNumber *rCTens = answers[2];
    NSNumber *rCHundreds = answers[4];
    
    BOOL success = YES;
    
    if (!isAHidden && ![aText isEqualToString:rCOnes.stringValue]) {
        success = NO;
    }
    if (!isBHidden && ![bText isEqualToString:rCTens.stringValue]) {
        success = NO;
    }
    if (!isCHidden && ![cText isEqualToString:rCHundreds.stringValue]) {
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
    if (number.length >= 2) return;
    firstResponder.text = number;
}

#pragma mark - Private

- (void)setupSubViews
{
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
        make.top.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView);
    }];
    
    self.aHundredLabel = [self createLabel];
    [self.aStackView addArrangedSubview:self.aHundredLabel];
    [self.aHundredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    self.aTenLabel = [self createLabel];
    [self.aStackView addArrangedSubview:self.aTenLabel];
    [self.aTenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    self.aOneLabel = [self createLabel];
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
        make.top.equalTo(self.aStackView.mas_bottom).offset(LearnMathScale(22.0));
        make.trailing.equalTo(self.aStackView);
    }];
    
    self.bHundredLabel = [self createLabel];
    [self.bStackView addArrangedSubview:self.bHundredLabel];
    [self.bHundredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    self.bTenLabel = [self createLabel];
    [self.bStackView addArrangedSubview:self.bTenLabel];
    [self.bTenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    self.bOneLabel = [self createLabel];
    [self.bStackView addArrangedSubview:self.bOneLabel];
    [self.bOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    
    // plusLabel
    self.plusLabel = [self createLabel];
    self.plusLabel.text = @"+";
    [self.contentView addSubview:self.plusLabel];
    [self.plusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.centerY.equalTo(self.bStackView);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.8), LearnMathScale(48.0)));
    }];
    
    // textFieldStackView
    self.textFieldStackView = [[UIStackView alloc] init];
    self.textFieldStackView.distribution = UIStackViewDistributionFill;
    self.textFieldStackView.axis = UILayoutConstraintAxisHorizontal;
    self.textFieldStackView.alignment = UIStackViewAlignmentFill;
    self.textFieldStackView.spacing = LearnMathScale(5.0);
    [self.contentView addSubview:self.textFieldStackView];
    [self.textFieldStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.aStackView);
        make.bottom.equalTo(self.contentView);
    }];
    
    self.cTextField = [self createTextField];
    [self.textFieldStackView addArrangedSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.cTextField];
    
    self.bTextField = [self createTextField];
    [self.textFieldStackView addArrangedSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.bTextField];
    
    self.aTextField = [self createTextField];
    [self.textFieldStackView addArrangedSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(LearnMathScale(48.0));
    }];
    [self.inputTextFields addObject:self.aTextField];
}

- (void)drawLines
{
    [self layoutIfNeeded];
    
    CGFloat y = CGRectGetMaxY(self.bStackView.frame) + (CGRectGetMinY(self.textFieldStackView.frame) - CGRectGetMaxY(self.bStackView.frame)) * 0.5;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0, y)];
    [path addLineToPoint:CGPointMake(self.contentView.frame.size.width, y)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineWidth = LearnMathScale(5.5);
    [self.contentView.layer addSublayer:layer];
}

#pragma mark - Factory

- (MathAnswerSheetLabel *)createLabel
{
    MathAnswerSheetLabel *label = [[MathAnswerSheetLabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont ap_baloo:LearnMathScale(59.0) weight:UIFontWeightRegular];
    label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    return label;
}

- (MathAnswerSheetTextField *)createTextField
{
    UIEdgeInsets padding = UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0));
    MathAnswerSheetTextField *textField = [[MathAnswerSheetTextField alloc] initWithPadding:padding bgColor:self.bgColor];
    return textField;
}

@end
