//
//  MathAnswerSheetQuestionAddMakeTenView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetQuestionAddMakeTenView.h"
#import "MathAnswerSheetLabel.h"
#import "MathAnswerSheetTextField.h"
#import "MathQuestionsTask.h"
#import "MathQuestions.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathQuestionAnswer.h"
@interface MathAnswerSheetQuestionAddMakeTenView ()

@property (nonatomic, strong) MathAnswerSheetLabel *aNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *plusLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *bNumberLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *equalLabel;
@property (nonatomic, strong) MathAnswerSheetLabel *cNumberLabel;

@property (nonatomic, strong) MathAnswerSheetTextField *aTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *bTextField;
@property (nonatomic, strong) MathAnswerSheetTextField *cTextField;

@end
@implementation MathAnswerSheetQuestionAddMakeTenView
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
    
    CGFloat fontSize = (task.question.digits >= 100) ? LearnMathScale(35.0) : LearnMathScale(59.0);
    UIFont *font = [UIFont ap_baloo:fontSize weight:UIFontWeightRegular];
    UIColor *color = [UIColor colorForSet:ColorSetSkillTitle];
    
    self.aNumberLabel.font = font;
    self.plusLabel.font = font;
    self.bNumberLabel.font = font;
    self.equalLabel.font = font;
    self.cNumberLabel.font = font;
    
    if (task.question.answer.numbers) {
        NSArray *numbers = task.question.answer.numbers;
        self.aNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[0]];
        self.bNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[1]];
        self.cNumberLabel.text = [NSString stringWithFormat:@"%@", numbers[2]];
    } else {
        self.aNumberLabel.text = @"";
        self.bNumberLabel.text = @"";
        self.cNumberLabel.text = @"";
    }
    
    if (self.isShowAnswer) {
        NSArray *answers = task.question.answer.answers;
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
        
        self.aTextField.layer.borderColor = self.bgColor.CGColor;
        self.bTextField.layer.borderColor = self.bgColor.CGColor;
        self.cTextField.layer.borderColor = self.bgColor.CGColor;
        
        self.aTextField.textColor = self.bgColor;
        self.bTextField.textColor = self.bgColor;
        self.cTextField.textColor = self.bgColor;
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
        [self.cTextField.text isEqualToString:cAnswer]) {
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
    UIColor *titleColor = [UIColor colorForSet:ColorSetSkillTitle];
    UIFont *font = [UIFont ap_baloo:LearnMathScale(59.9) weight:UIFontWeightRegular];
    
    self.aNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.aNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.aNumberLabel.font = font;
    self.aNumberLabel.textColor = titleColor;
    [self addSubview:self.aNumberLabel];
    [self.aNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(LearnMathScale(1.0));
        make.top.equalTo(self).offset(LearnMathScale(15.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(54.0)));
    }];
    
    self.plusLabel = [[MathAnswerSheetLabel alloc] init];
    self.plusLabel.text = @"+";
    self.plusLabel.textAlignment = NSTextAlignmentCenter;
    self.plusLabel.font = font;
    self.plusLabel.textColor = titleColor;
    [self addSubview:self.plusLabel];
    [self.plusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.aNumberLabel.mas_trailing);
        make.centerY.equalTo(self.aNumberLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(33.0), LearnMathScale(54.0)));
    }];
    
    self.bNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.bNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.bNumberLabel.font = font;
    self.bNumberLabel.textColor = titleColor;
    [self addSubview:self.bNumberLabel];
    [self.bNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.plusLabel.mas_trailing).offset(LearnMathScale(12.0));
        make.centerY.equalTo(self.aNumberLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(37.0), LearnMathScale(54.0)));
    }];
    
    self.equalLabel = [[MathAnswerSheetLabel alloc] init];
    self.equalLabel.text = @"=";
    self.equalLabel.textAlignment = NSTextAlignmentCenter;
    self.equalLabel.font = font;
    self.equalLabel.textColor = titleColor;
    [self addSubview:self.equalLabel];
    [self.equalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bNumberLabel.mas_trailing).offset(LearnMathScale(12.0));
        make.centerY.equalTo(self.aNumberLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(29.0), LearnMathScale(54.0)));
    }];
    
    self.cTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self addSubview:self.cTextField];
    [self.cTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.equalLabel.mas_trailing).offset(LearnMathScale(13.5));
        make.centerY.equalTo(self.aNumberLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(74.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.cTextField];
    
    self.cNumberLabel = [[MathAnswerSheetLabel alloc] init];
    self.cNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.cNumberLabel.font = font;
    self.cNumberLabel.textColor = titleColor;
    [self addSubview:self.cNumberLabel];
    [self.cNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-LearnMathScale(6.8));
        make.centerX.equalTo(self.aNumberLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(54.0)));
    }];
    
    self.aTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self addSubview:self.aTextField];
    [self.aTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bNumberLabel.mas_bottom).offset(LearnMathScale(46.0));
        make.trailing.equalTo(self.bNumberLabel.mas_centerX).offset(-LearnMathScale(8.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(74.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.aTextField];
    
    self.bTextField = [[MathAnswerSheetTextField alloc] initWithPadding:UIEdgeInsetsMake(LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0), LearnMathScale(2.0)) bgColor:self.bgColor];
    [self addSubview:self.bTextField];
    [self.bTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bNumberLabel.mas_bottom).offset(LearnMathScale(46.0));
        make.leading.equalTo(self.bNumberLabel.mas_centerX).offset(LearnMathScale(8.5));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(74.0), LearnMathScale(48.0)));
    }];
    [self.inputTextFields addObject:self.bTextField];
    
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
        layer.lineJoin = kCALineJoinRound;
        layer.lineWidth = LearnMathScale(5.5);
        [self.layer addSublayer:layer];
    };
    
    UIBezierPath *firstPath = [UIBezierPath bezierPath];
    [firstPath moveToPoint:CGPointMake(self.aNumberLabel.center.x, CGRectGetMaxY(self.aNumberLabel.frame) + LearnMathScale(3.0))];
    [firstPath addLineToPoint:CGPointMake(self.cNumberLabel.center.x, CGRectGetMinY(self.cNumberLabel.frame) - LearnMathScale(6.0))];
    addLine(firstPath);
    
    UIBezierPath *secondPath = [UIBezierPath bezierPath];
    [secondPath moveToPoint:CGPointMake(CGRectGetMaxX(self.cNumberLabel.frame) + LearnMathScale(10.0), self.cNumberLabel.center.y)];
    [secondPath addLineToPoint:CGPointMake(self.cTextField.center.x, self.cNumberLabel.center.y)];
    [secondPath addLineToPoint:CGPointMake(self.cTextField.center.x, CGRectGetMaxY(self.aNumberLabel.frame) + LearnMathScale(3.0))];
    addLine(secondPath);
    
    CGFloat startX = CGRectGetMinX(self.bNumberLabel.frame) + LearnMathScale(3.0);
    CGFloat startY = CGRectGetMaxY(self.aNumberLabel.frame) + LearnMathScale(3.0);
    CGFloat endX = self.cNumberLabel.center.x + LearnMathScale(12.0);
    CGFloat endY = CGRectGetMinY(self.cNumberLabel.frame) - LearnMathScale(6.0);
    UIBezierPath *thirdPath = [UIBezierPath bezierPath];
    [thirdPath moveToPoint:CGPointMake(startX, startY)];
    [thirdPath addLineToPoint:CGPointMake(endX + (startX - endX) * 0.78, startY + (endY - startY) * 0.22)];
    addLine(thirdPath);
    
    UIBezierPath *fourthPath = [UIBezierPath bezierPath];
    [fourthPath moveToPoint:CGPointMake(endX + (startX - endX) * 0.35, startY + (endY - startY) * 0.65)];
    [fourthPath addLineToPoint:CGPointMake(endX, endY)];
    addLine(fourthPath);
    
    UIBezierPath *fifthPath = [UIBezierPath bezierPath];
    [fifthPath moveToPoint:CGPointMake(CGRectGetMaxX(self.bNumberLabel.frame) - LearnMathScale(3.0), startY)];
    [fifthPath addLineToPoint:CGPointMake(self.bTextField.center.x - LearnMathScale(10.0), startY + (endY - startY) * 0.22)];
    addLine(fifthPath);
    
    UIBezierPath *sixthPath = [UIBezierPath bezierPath];
    [sixthPath moveToPoint:CGPointMake(self.bTextField.center.x + LearnMathScale(10.0), startY + (endY - startY) * 0.22)];
    [sixthPath addLineToPoint:CGPointMake(CGRectGetMinX(self.cTextField.frame) - LearnMathScale(3.0), startY)];
    addLine(sixthPath);
    
}
@end
