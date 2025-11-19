//
//  MathAnswerSheetQuestionSubMakingUpInteralView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionSubMakingUpInteralView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionSubMakingUpInteralView ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plusLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plus2Label;
@property (nonatomic, strong) MathAnswerSheetLabel *cNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;

@property (nonatomic, strong) UIStackView *stackView2;
@property (nonatomic, strong) MathAnswerSheetLabel *a1NumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plus3Label;
@property (nonatomic, strong) MathAnswerSheetLabel *leftBrackets;
@property (nonatomic, strong) MathAnswerSheetLabel *b1NumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plus4Label;
@property (nonatomic, strong) MathAnswerSheetLabel *c1NumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *rightBrackets;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;

@end

@implementation MathAnswerSheetQuestionSubMakingUpInteralView
- (instancetype)initWithTask:(MathQuestionsTask *)task category:(ArithmeticAlgorithmCategory )category isShowAnswer:(BOOL)isShowAnswer bgColor:(UIColor *)bgColor frame:(CGRect)frame
{
    self = [super initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];
    if (self) {
        [self setupSubviews];
        [self drawLines];
    }
    return self;
}

- (void)updateTask:(MathQuestionsTask *)task {
    [super updateTask:task];
    
    NSArray *numbers = task.question.answer.numbers;
    if (numbers) {
        self.aNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.a1NumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.bNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.b1NumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.cNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[2]];
        self.c1NumberLabel.text = [NSString stringWithFormat:@"%@", numbers[2]];
    } else {
        self.aNumberLabel.text = @"";
        self.a1NumberLabel.text = @"";
        self.bNumberLabel.text = @"";
        self.b1NumberLabel.text = @"";
        self.cNumberLabel.text = @"";
        self.c1NumberLabel.text = @"";
    }
    
    if (self.isShowAnswer) {
        NSArray *answers = task.question.answer.answers;
        if (answers) {
            self.aTextField.text = [NSString stringWithFormat:@"%@", answers[0]];
            self.bTextField.text = [NSString stringWithFormat:@"%@", answers[1]];
        } else {
            self.aTextField.text = @"";
            self.bTextField.text = @"";
        }
        
        self.aTextField.userInteractionEnabled = NO;
        self.bTextField.userInteractionEnabled = NO;
        
        self.aTextField.layer.borderColor = self.bgColor.CGColor;
        self.bTextField.layer.borderColor = self.bgColor.CGColor;
        
        self.aTextField.textColor = self.bgColor;
        self.bTextField.textColor = self.bgColor;
    } else {
        self.aTextField.userInteractionEnabled = YES;
        self.bTextField.userInteractionEnabled = YES;
    }
}

- (void)check:(MathAnswerSheetTextField *)firstResponder {
    [super check:firstResponder];
    
    if (self.aTextField.text.length == 0) {
        
        return;
    }
    if (self.bTextField.text.length == 0) {
       
        return;
    }
    
    NSNumber *aAnswer = self.task.question.answer.answers[0];
    NSNumber *bAnswer = self.task.question.answer.answers[1];
    
    if (!aAnswer || !bAnswer) {
       
        return;
    }
    
    if ([self.aTextField.text isEqualToString:[NSString stringWithFormat:@"%@", aAnswer]] &&
        [self.bTextField.text isEqualToString:[NSString stringWithFormat:@"%@", bAnswer]]) {
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
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.aTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(LearnMathScale(15.0)));
        make.trailing.equalTo(@(-LearnMathScale(1.0)));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.distribution = UIStackViewDistributionFill;
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.spacing = 0.0;
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(LearnMathScale(15.0)));
        make.height.equalTo(@(LearnMathScale(48.0)));
        make.leading.equalTo(@(LearnMathScale(1.0)));
        make.trailing.equalTo(self.aTextField.mas_leading);
    }];
    
    self.aNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.aNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.aNumberLabel.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.aNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.aNumberLabel];
    
    self.plusLabel = [[MathAnswerSheetLabel alloc] init];
    self.plusLabel.text = @"-";
    self.plusLabel.textAlignment = NSTextAlignmentCenter;
    self.plusLabel.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.plusLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.plusLabel];
    [self.plusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(LearnMathScale(20.0)));
    }];
    
    self.bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.bNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.bNumberLabel.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.bNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.bNumberLabel];
    [self.bNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.aNumberLabel);
    }];
    
    self.plus2Label = [[MathAnswerSheetLabel alloc] init];
    self.plus2Label.text = @"-";
    self.plus2Label.textAlignment = NSTextAlignmentCenter;
    self.plus2Label.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.plus2Label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.plus2Label];
    [self.plus2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(LearnMathScale(20.0)));
    }];
    
    self.cNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.cNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.cNumberLabel.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.cNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.cNumberLabel];
    [self.cNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.aNumberLabel);
    }];
    
    self.equalLabel = [[MathAnswerSheetLabel alloc] init];
    self.equalLabel.text = @"=";
    self.equalLabel.textAlignment = NSTextAlignmentCenter;
    self.equalLabel.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.equalLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.equalLabel];
    [self.equalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(LearnMathScale(30.0)));
    }];
    
    self.stackView2 = [[UIStackView alloc] init];
    self.stackView2.distribution = UIStackViewDistributionFill;
    self.stackView2.axis = UILayoutConstraintAxisHorizontal;
    self.stackView2.alignment = UIStackViewAlignmentFill;
    self.stackView2.spacing = 0.0;
    [self addSubview:self.stackView2];
    [self.stackView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aNumberLabel.mas_bottom).offset(LearnMathScale(46.0));
        make.height.equalTo(@(LearnMathScale(48.0)));
        make.leading.equalTo(@(LearnMathScale(1.0)));
        make.trailing.equalTo(@(-LearnMathScale(1.0)));
    }];
    
    self.a1NumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.a1NumberLabel.textAlignment = NSTextAlignmentCenter;
    self.a1NumberLabel.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.a1NumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView2 addArrangedSubview:self.a1NumberLabel];
    
    self.plus3Label = [[MathAnswerSheetLabel alloc] init];
    self.plus3Label.text = @"-";
    self.plus3Label.textAlignment = NSTextAlignmentCenter;
    self.plus3Label.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.plus3Label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView2 addArrangedSubview:self.plus3Label];
    [self.plus3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(LearnMathScale(20.0)));
    }];
    
    self.leftBrackets = [[MathAnswerSheetLabel alloc] init];
    self.leftBrackets.text = @"(";
    self.leftBrackets.textAlignment = NSTextAlignmentCenter;
    self.leftBrackets.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.leftBrackets.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView2 addArrangedSubview:self.leftBrackets];
    [self.leftBrackets mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(LearnMathScale(20.0)));
    }];
    
    self.b1NumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.b1NumberLabel.textAlignment = NSTextAlignmentCenter;
    self.b1NumberLabel.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.b1NumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView2 addArrangedSubview:self.b1NumberLabel];
    [self.b1NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.a1NumberLabel);
    }];
    
    self.plus4Label = [[MathAnswerSheetLabel alloc] init];
    self.plus4Label.text = @"+";
    self.plus4Label.textAlignment = NSTextAlignmentCenter;
    self.plus4Label.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.plus4Label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView2 addArrangedSubview:self.plus4Label];
    [self.plus4Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(LearnMathScale(20.0)));
    }];
    
    self.c1NumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.c1NumberLabel.textAlignment = NSTextAlignmentCenter;
    self.c1NumberLabel.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.c1NumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView2 addArrangedSubview:self.c1NumberLabel];
    [self.c1NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.a1NumberLabel);
    }];
    
    self.rightBrackets = [[MathAnswerSheetLabel alloc] init];
    self.rightBrackets.text = @")";
    self.rightBrackets.textAlignment = NSTextAlignmentCenter;
    self.rightBrackets.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.rightBrackets.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView2 addArrangedSubview:self.rightBrackets];
    [self.rightBrackets mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(LearnMathScale(20.0)));
    }];
    
    self.bTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0))
                                                                 bgColor:self.bgColor];
    self.bTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self addSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.plus4Label);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
        make.bottom.equalTo(@(-LearnMathScale(8.0)));
    }];
    [self.inputTextFields addObject:self.bTextField];
    
    if (!self.isShowAnswer) {
        [self.bTextField becomeFirstResponder];
    }
}

- (void)drawLines
{
    [self layoutIfNeeded];
    CGRect b1Frame = [self.stackView2 convertRect:self.b1NumberLabel.frame toView:self];
    UIBezierPath *firstPath = [UIBezierPath bezierPath];
    [firstPath moveToPoint:CGPointMake(CGRectGetMidX(b1Frame), CGRectGetMaxY(b1Frame) + LearnMathScale(9.0))];
    [firstPath addLineToPoint:CGPointMake(self.bTextField.frame.origin.x + self.bTextField.frame.size.width/2.0 - LearnMathScale(9.0), self.bTextField.frame.origin.y - LearnMathScale(9.0))];
    
    CAShapeLayer *firstLayer = [CAShapeLayer layer];
    firstLayer.path = firstPath.CGPath;
    firstLayer.strokeColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
    firstLayer.fillColor = UIColor.clearColor.CGColor;
    firstLayer.lineCap = kCALineCapRound;
    firstLayer.lineWidth = LearnMathScale(5.5);
    [self.layer addSublayer:firstLayer];
    
    CGRect c1Frame = [self.stackView2 convertRect:self.c1NumberLabel.frame toView:self];
    UIBezierPath *secondPath = [UIBezierPath bezierPath];
    [secondPath moveToPoint:CGPointMake(CGRectGetMidX(c1Frame), CGRectGetMaxY(c1Frame) + LearnMathScale(9.0))];
    [secondPath addLineToPoint:CGPointMake(self.bTextField.frame.origin.x + self.bTextField.frame.size.width/2.0 + LearnMathScale(9.0), self.bTextField.frame.origin.y - LearnMathScale(9.0))];
    
    CAShapeLayer *secondLayer = [CAShapeLayer layer];
    secondLayer.path = secondPath.CGPath;
    secondLayer.strokeColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
    secondLayer.fillColor = UIColor.clearColor.CGColor;
    secondLayer.lineCap = kCALineCapRound;
    secondLayer.lineWidth = LearnMathScale(5.5);
    [self.layer addSublayer:secondLayer];
}
@end
