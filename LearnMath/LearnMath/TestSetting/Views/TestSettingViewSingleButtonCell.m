//
//  TestSettingViewSingleButtonCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingViewSingleButtonCell.h"

@implementation TestSettingViewSingleButtonCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
    _settingScopeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingScopeButton.layer.cornerRadius = LearnMathScale(10.0);
    _settingScopeButton.layer.masksToBounds = NO;
    _settingScopeButton.layer.shadowOpacity = 1.0;
    _settingScopeButton.layer.shadowRadius = 0.0;
    _settingScopeButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(8.0));
    _settingScopeButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    _settingScopeButton.layer.borderWidth = LearnMathScale(2.0);
    _settingScopeButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    _settingScopeButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    [self.contentView addSubview:self.settingScopeButton];
    [self.settingScopeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _titleLabel.font = [UIFont poppinsFontOfSize:14.0 weight:UIFontWeightBold];
    [self.settingScopeButton addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LearnMathScale(14.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(243.0), LearnMathScale(18.0)));
    }];
}

@end
