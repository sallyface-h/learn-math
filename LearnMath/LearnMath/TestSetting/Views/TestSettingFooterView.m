//
//  TestSettingFooterView.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingFooterView.h"

@implementation TestSettingFooterView
{
    UIView *_contentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)configureWithButtonTitle:(NSString *)title
{
    [self.button setTitle:title forState:UIControlStateNormal];
}

-(void)setUpSubviews
{
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(LearnMathScale(30.0), LearnMathScale(24.0) , 0.0, LearnMathScale(24.0)));
    }];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor colorForSet:ColorSetPurple];
    [_button setTitle:@"Start!" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorForSet:ColorSetWhite] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont balooFontOfSize:20.0 weight:UIFontWeightBold];
    _button.layer.cornerRadius = LearnMathScale(10.0);
    _button.layer.masksToBounds = NO;
    _button.layer.shadowOpacity = 1.0;
    _button.layer.shadowRadius = 0.0;
    _button.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(8.0));
    _button.layer.borderWidth = LearnMathScale(2.0);
    _button.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    _button.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    [_contentView addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LearnMathScale(46.0));
        make.centerX.equalTo(_contentView);
        make.leading.equalTo(_contentView).offset(LearnMathScale(63.5));
        make.trailing.equalTo(_contentView).offset(-LearnMathScale(63.5));
    }];
}

@end
