//
//  MathAnswerSheetQuestionDivMultiplicationTableView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionDivMultiplicationTableView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionDivMultiplicationTableView()

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *divLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;

@end
@implementation MathAnswerSheetQuestionDivMultiplicationTableView
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
        self.bNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
    } else {
        self.aNumberLabel.text = @"";
        self.bNumberLabel.text = @"";
    }
    
    if (self.isShowAnswer) {
        if (answers) {
            self.aTextField.text = [NSString stringWithFormat:@"%@", numbers[0]];
        } else {
            self.aTextField.text = @"";
        }
        self.aTextField.userInteractionEnabled = NO;
        self.aTextField.layer.borderColor = self.bgColor.CGColor;
        self.aTextField.textColor = self.bgColor;
    } else {
        self.aTextField.userInteractionEnabled = YES;
    }
}

- (void)check:(MathAnswerSheetTextField *)firstResponder
{
    [super check:firstResponder];
    if (self.aTextField.text.length == 0) {
        
        return;
    }
    
    NSNumber *aAnswer = nil;
    if (self.task.question.answer.answers.count > 0) {
        aAnswer = self.task.question.answer.answers[0];
    }
    
    if (aAnswer == nil) {
       
        return;
    }
    if ([self.aTextField.text isEqualToString:[NSString stringWithFormat:@"%@", aAnswer]]) {
        [self.task success];
    } else {
        [self.task failure];
    }
}

- (void)clean:(MathAnswerSheetTextField *)firstResponder
{
    firstResponder.text = nil;
    if (self.aTextField.text.length == 0) {
        
        return;
    }
    
    NSNumber *aAnswer = self.task.question.answer.answers[0];
    if ([self.aTextField.text isEqualToString:aAnswer.stringValue]) {
        [self.task success];
    } else {
        [self.task failure];
    }
}

- (void)input:(NSString *)number firstResponder:(MathAnswerSheetTextField *)firstResponder
{
    firstResponder.text = number;
}

- (void)setupSubviews
{
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2), LearnMathScale(2), LearnMathScale(2), LearnMathScale(2)) bgColor:self.bgColor];
    self.aTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-LearnMathScale(1));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(80), LearnMathScale(48)));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    // stackView
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.distribution = UIStackViewDistributionFill;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.spacing = 0.0;
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.aTextField);
        make.height.mas_equalTo(LearnMathScale(48));
        make.leading.equalTo(self).offset(LearnMathScale(1));
        make.trailing.equalTo(self.aTextField.mas_leading);
    }];
    
    // aNumberLabel
    self.aNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.aNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.aNumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.aNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.aNumberLabel];
    
    // divLabel
    self.divLabel = [[MathAnswerSheetLabel alloc] init];
    self.divLabel.text = @"÷";
    self.divLabel.textAlignment = NSTextAlignmentCenter;
    self.divLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.divLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.divLabel];
    [self.divLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(30));
    }];
    
    // bNumberLabel
    self.bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.bNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.bNumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.bNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.bNumberLabel];
    [self.bNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.aNumberLabel);
    }];
    
    // equalLabel
    self.equalLabel = [[MathAnswerSheetLabel alloc] init];
    self.equalLabel.text = @"=";
    self.equalLabel.textAlignment = NSTextAlignmentCenter;
    self.equalLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.equalLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.equalLabel];
    [self.equalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(50));
    }];
    
    if (!self.isShowAnswer) {
        [self.aTextField becomeFirstResponder];
    }
}

- (void)drawLines
{
    [self layoutIfNeeded];
    
}
@end
