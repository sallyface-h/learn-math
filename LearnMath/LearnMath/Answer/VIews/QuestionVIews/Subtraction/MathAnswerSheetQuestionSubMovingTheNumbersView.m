//
//  MathAnswerSheetQuestionSubMovingTheNumbersView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionSubMovingTheNumbersView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionSubMovingTheNumbersView ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plusLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plus2Label;
@property (nonatomic, strong) MathAnswerSheetLabel *cNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetLabel *a1NumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plus3Label;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;
@property (nonatomic, strong) MathAnswerSheetLabel *plus4Label;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *dTextField;

@end


@implementation MathAnswerSheetQuestionSubMovingTheNumbersView
- (instancetype)initWithTask:(MathQuestionsTask *)task category:(ArithmeticAlgorithmCategory )category isShowAnswer:(BOOL)isShowAnswer bgColor:(UIColor *)bgColor frame:(CGRect)frame
{
    self = [super initWithTask:task category:category isShowAnswer:isShowAnswer bgColor:bgColor frame:frame];
    if (self) {
        [self setupSubviews];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self drawLines];
        });
    }
    return self;
}

- (void)updateTask:(MathQuestionsTask *)task {
    [super updateTask:task];
    
    CGFloat fontSize = task.question.digits >= 100 ? LearnMathScale(30.0) : LearnMathScale(35.0);
    
    self.aNumberLabel.font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    self.bNumberLabel.font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    self.plusLabel.font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    self.cNumberLabel.font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    self.plus2Label.font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    self.equalLabel.font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    self.a1NumberLabel.font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    self.plus3Label.font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    self.plus4Label.font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    
    NSArray *numbers = task.question.answer.numbers;
    if (numbers) {
        self.aNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.a1NumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.bNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.cNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[2]];
    } else {
        self.aNumberLabel.text = @"";
        self.a1NumberLabel.text = @"";
        self.bNumberLabel.text = @"";
        self.cNumberLabel.text = @"";
    }
    
    if (self.isShowAnswer) {
        NSArray *answers = task.question.answer.answers;
        if (answers) {
            self.aTextField.text = [NSString stringWithFormat:@"%@", answers[0]];
            self.bTextField.text = [NSString stringWithFormat:@"%@", answers[1]];
            self.cTextField.text = [NSString stringWithFormat:@"%@", answers[2]];
            self.dTextField.text = [NSString stringWithFormat:@"%@", answers[3]];
        } else {
            self.aTextField.text = @"";
            self.bTextField.text = @"";
            self.cTextField.text = @"";
            self.dTextField.text = @"";
        }
        
        self.aTextField.userInteractionEnabled = NO;
        self.bTextField.userInteractionEnabled = NO;
        self.cTextField.userInteractionEnabled = NO;
        self.dTextField.userInteractionEnabled = NO;
        
        self.aTextField.layer.borderColor = self.bgColor.CGColor;
        self.bTextField.layer.borderColor = self.bgColor.CGColor;
        self.cTextField.layer.borderColor = self.bgColor.CGColor;
        self.dTextField.layer.borderColor = self.bgColor.CGColor;
        
        self.aTextField.textColor = self.bgColor;
        self.bTextField.textColor = self.bgColor;
        self.cTextField.textColor = self.bgColor;
        self.dTextField.textColor = self.bgColor;
    } else {
        self.aTextField.userInteractionEnabled = YES;
        self.bTextField.userInteractionEnabled = YES;
        self.cTextField.userInteractionEnabled = YES;
        self.dTextField.userInteractionEnabled = YES;
    }
}

- (void)check:(MathAnswerSheetTextField *)firstResponder {
    [super check:firstResponder];
    
    if (self.aTextField.text.length == 0 ||
        self.bTextField.text.length == 0 ||
        self.cTextField.text.length == 0 ||
        self.dTextField.text.length == 0) {
        
        return;
    }
    
    NSArray *answers = self.task.question.answer.answers;
    if (!answers) {
        
        return;
    }
    
    NSString *aAnswer = [NSString stringWithFormat:@"%@", answers[0]];
    NSString *bAnswer = [NSString stringWithFormat:@"%@", answers[1]];
    NSString *cAnswer = [NSString stringWithFormat:@"%@", answers[2]];
    NSString *dAnswer = [NSString stringWithFormat:@"%@", answers[3]];
    
    if ([self.aTextField.text isEqualToString: aAnswer] &&
        [self.bTextField.text isEqualToString: bAnswer] &&
        [self.cTextField.text isEqualToString: cAnswer] &&
        [self.dTextField.text isEqualToString: dAnswer]) {
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
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.aTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LearnMathScale(15.0));
        make.trailing.equalTo(self).offset(-LearnMathScale(1.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.spacing = 0.0;
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LearnMathScale(15.0));
        make.height.mas_equalTo(LearnMathScale(48.0));
        make.leading.equalTo(self).offset(LearnMathScale(1.0));
        make.trailing.equalTo(self.aTextField.mas_leading);
    }];
    
    self.aNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.aNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.aNumberLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.aNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.aNumberLabel];
   
    self.plusLabel = [[MathAnswerSheetLabel alloc] init];
    self.plusLabel.text = @"-";
    self.plusLabel.textAlignment = NSTextAlignmentCenter;
    self.plusLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.plusLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.plusLabel];
    
    self.bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.bNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.bNumberLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.bNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.bNumberLabel];
   
    self.plus2Label = [[MathAnswerSheetLabel alloc] init];
    self.plus2Label.text = @"-";
    self.plus2Label.textAlignment = NSTextAlignmentCenter;
    self.plus2Label.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.plus2Label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.plus2Label];
    
    self.cNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.cNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.cNumberLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.cNumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.cNumberLabel];
   
    self.equalLabel = [[MathAnswerSheetLabel alloc] init];
    self.equalLabel.text = @"=";
    self.equalLabel.textAlignment = NSTextAlignmentCenter;
    self.equalLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.equalLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.equalLabel];
    
    self.a1NumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.a1NumberLabel.textAlignment = NSTextAlignmentCenter;
    self.a1NumberLabel.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.a1NumberLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self addSubview:self.a1NumberLabel];
    [self.a1NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aNumberLabel.mas_bottom).offset(LearnMathScale(46.0));
        make.centerX.equalTo(self.aNumberLabel);
    }];
    
    self.plus3Label = [[MathAnswerSheetLabel alloc] init];
    self.plus3Label.text = @"-";
    self.plus3Label.textAlignment = NSTextAlignmentCenter;
    self.plus3Label.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.plus3Label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self addSubview:self.plus3Label];
    [self.plus3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.a1NumberLabel);
        make.centerX.equalTo(self.plusLabel).offset(-LearnMathScale(5.0));
    }];
    
    self.bTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.bTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self addSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.a1NumberLabel);
        make.centerX.equalTo(self.bNumberLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.bTextField];
    
    self.plus4Label = [[MathAnswerSheetLabel alloc] init];
    self.plus4Label.text = @"-";
    self.plus4Label.textAlignment = NSTextAlignmentCenter;
    self.plus4Label.font = [UIFont ap_baloo:LearnMathScale(35.0) weight:UIFontWeightRegular];
    self.plus4Label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self addSubview:self.plus4Label];
    [self.plus4Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.a1NumberLabel);
        make.centerX.equalTo(self.plus2Label).offset(LearnMathScale(5.0));
    }];
    
    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.cTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self addSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.a1NumberLabel);
        make.centerX.equalTo(self.cNumberLabel).offset(LearnMathScale(10.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.cTextField];
    
    self.dTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    self.dTextField.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    [self addSubview:self.dTextField];
    [self.dTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-LearnMathScale(8.0));
        make.centerX.equalTo(self.plusLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(54.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.dTextField];

    if (!self.isShowAnswer) {
        [self.bTextField becomeFirstResponder];
    }
}

#pragma mark - 绘制连线

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
        [self.layer addSublayer:layer];
    };
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(CGRectGetMinX(self.aTextField.frame), CGRectGetMaxY(self.aTextField.frame) + LearnMathScale(9.0))];
    [path1 addLineToPoint:CGPointMake(CGRectGetMaxX(self.cTextField.frame), CGRectGetMinY(self.cTextField.frame) - LearnMathScale(9.0))];
    addLine(path1);

    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(CGRectGetMaxX(self.dTextField.frame) + LearnMathScale(9.0), CGRectGetMidY(self.dTextField.frame))];
    [path2 addLineToPoint:CGPointMake(self.aTextField.center.x, CGRectGetMidY(self.dTextField.frame))];
    [path2 addLineToPoint:CGPointMake(self.aTextField.center.x, CGRectGetMaxY(self.aTextField.frame) + LearnMathScale(9.0))];
    addLine(path2);
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(CGRectGetMidX(self.bTextField.frame), CGRectGetMaxY(self.bTextField.frame) + LearnMathScale(9.0))];
    [path3 addLineToPoint:CGPointMake(CGRectGetMidX(self.dTextField.frame) + LearnMathScale(9.0), CGRectGetMinY(self.dTextField.frame) - LearnMathScale(9.0))];
    addLine(path3);
 
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(CGRectGetMidX(self.a1NumberLabel.frame), CGRectGetMaxY(self.bTextField.frame) + LearnMathScale(9.0))];
    [path4 addLineToPoint:CGPointMake(CGRectGetMidX(self.dTextField.frame) - LearnMathScale(9.0), CGRectGetMinY(self.dTextField.frame) - LearnMathScale(9.0))];
    addLine(path4);
}

@end
