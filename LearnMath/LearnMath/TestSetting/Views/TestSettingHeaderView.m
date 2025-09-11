//
//  TestSettingHeaderView.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingHeaderView.h"

@implementation TestSettingHeaderView
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

- (void)configureWithTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)setUpSubviews
{
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(LearnMathScale(24.0), LearnMathScale(24.0) , 0.0, LearnMathScale(24.0)));
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont poppinsFontOfSize:16.0 weight:UIFontWeightBold];
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [_contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LearnMathScale(20.0));
        make.top.leading.equalTo(_contentView);
    }];
}
@end
