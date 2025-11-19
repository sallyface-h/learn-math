//
//  MathAnswerSheetQuestionMultiplicationTableView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionMultiplicationTableView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionMultiplicationTableView ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *mulLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;

@end
@implementation MathAnswerSheetQuestionMultiplicationTableView
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
}

- (void)input:(NSString *)number firstResponder:(MathAnswerSheetTextField *)firstResponder
{
    firstResponder.text = number;
}

- (void)setupSubviews {
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 0.0;
    [self addSubview:stackView];
    self.stackView = stackView;
    
    MathAnswerSheetLabel *aNumberLabel = [[MathAnswerSheetLabel alloc] init];
    aNumberLabel.textAlignment = NSTextAlignmentCenter;
    aNumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    aNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [stackView addArrangedSubview:aNumberLabel];
    self.aNumberLabel = aNumberLabel;
    
    MathAnswerSheetLabel *mulLabel = [[MathAnswerSheetLabel alloc] init];
    mulLabel.text = @"x";
    mulLabel.textAlignment = NSTextAlignmentCenter;
    mulLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    mulLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [stackView addArrangedSubview:mulLabel];
    [mulLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(30.0));
    }];
    self.mulLabel = mulLabel;
    
    MathAnswerSheetLabel *bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    bNumberLabel.textAlignment = NSTextAlignmentCenter;
    bNumberLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    bNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [stackView addArrangedSubview:bNumberLabel];
    [bNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(aNumberLabel);
    }];
    self.bNumberLabel = bNumberLabel;
    
    MathAnswerSheetLabel *equalLabel = [[MathAnswerSheetLabel alloc] init];
    equalLabel.text = @"=";
    equalLabel.textAlignment = NSTextAlignmentCenter;
    equalLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    equalLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [stackView addArrangedSubview:equalLabel];
    [equalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(50.0));
    }];
    self.equalLabel = equalLabel;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0));
    MathAnswerSheetTextField *aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:insets bgColor:self.bgColor];
    aTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self addSubview:aTextField];
    self.aTextField = aTextField;
    
    [aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-LearnMathScale(1.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(80.0), LearnMathScale(48.0)));
    }];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(aTextField);
        make.height.mas_equalTo(LearnMathScale(48.0));
        make.leading.equalTo(self).offset(LearnMathScale(1.0));
        make.trailing.equalTo(aTextField.mas_leading);
    }];
    
    [self.inputTextFields addObject:aTextField];
    
    if (!self.isShowAnswer) {
        [aTextField becomeFirstResponder];
    }
}

- (void)drawLines
{
    [self layoutIfNeeded];
    
}
@end
