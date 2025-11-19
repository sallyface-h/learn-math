//
//  MathAnswerSheetTimeView.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetTimeView.h"
#import "MathQuestionsTask.h"
@interface MathAnswerSheetTimeView ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *loveImageViews;

@end

@implementation MathAnswerSheetTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

#pragma mark - Public
- (void)updateTask:(MathQuestionsTask *)task {
    NSInteger retryCount = task.retryCount;
    for (NSInteger i = 0; i < self.loveImageViews.count; i++) {
        UIImageView *loveImageView = self.loveImageViews[i];
        loveImageView.hidden = (i < (3 - retryCount));
    }
}

#pragma mark - Private
- (void)setupSubviews {
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mathanswersheet_love"]];
        [self.stackView addArrangedSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LearnMathScale(40.0), LearnMathScale(40.0)));
        }];
        [self.loveImageViews addObject:img];
    }
}

#pragma mark - Lazy Load
- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.spacing = LearnMathScale(2.0);
    }
    return _stackView;
}

- (NSMutableArray<UIImageView *> *)loveImageViews {
    if (!_loveImageViews) {
        _loveImageViews = [NSMutableArray array];
    }
    return _loveImageViews;
}

@end
