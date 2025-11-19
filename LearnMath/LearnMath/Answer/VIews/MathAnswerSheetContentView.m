//
//  MathAnswerSheetContentView.m
//  LearnMath
//
//  Created by 基 on 2025/10/26.
//

#import "MathAnswerSheetContentView.h"
#import "MathQuestionViewsGenerator.h"
#import "MathAnswerSheetQuestionBaseView.h"
@interface MathAnswerSheetContentView ()

@property (nonatomic, strong, nullable) MathAnswerSheetQuestionBaseView *currentQuestionView;
@property (nonatomic, strong, nullable) UIColor *bgColor;
@property (nonatomic, assign) BOOL isShowAnswer;

@end

@implementation MathAnswerSheetContentView

#pragma mark - Init

- (instancetype)initWithBgColor:(nullable UIColor *)bgColor frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _bgColor = bgColor;
        _isShowAnswer = NO;
        [self setupSubViews];
    }
    return self;
}

#pragma mark - Public

- (void)updateTask:(MathQuestionsTask *)task
           bgColor:(nullable UIColor *)bgColor
       isShowAnswer:(BOOL)isShowAnswer
{
    self.bgColor = bgColor;
    self.isShowAnswer = isShowAnswer;
    [self updateTask:task];
}

- (void)updateTask:(MathQuestionsTask *)task {
    
    [self.currentQuestionView removeFromSuperview];
    
    CGFloat x = LearnMathScale(27.5);
    CGFloat y = LearnMathScale(23.5);
    CGFloat w = self.bounds.size.width - x * 2.0;
    CGFloat h = self.bounds.size.height - y * 2.0;
    
    CGRect frame = CGRectMake(x, y, w, h);
    
    MathAnswerSheetQuestionBaseView *questionView =
        [MathQuestionViewsGenerator generateWithTask:task bgColor:self.bgColor isShowAnswer:self.isShowAnswer  frame:frame];
    
    if (!questionView) return;
    
    [self addSubview:questionView];
    self.currentQuestionView = questionView;
}

- (void)receiveInputItem:(nullable MathAnswerSheetInputItem *)item {
    [self.currentQuestionView receiveInputItem:item];
}

#pragma mark - Private

- (void)setupSubViews {
    self.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    [self roundCorners:UIRectCornerAllCorners radius:LearnMathScale(20.0)];
    
}

@end
