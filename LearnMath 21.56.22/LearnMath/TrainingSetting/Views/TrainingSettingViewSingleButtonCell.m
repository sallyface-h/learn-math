//
//  TrainingSettingViewSingleButtonCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import "TrainingSettingViewSingleButtonCell.h"

@implementation TrainingSettingViewSingleButtonCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
    _settingTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingTimeButton.layer.cornerRadius = LearnMathScale(10.0);
    _settingTimeButton.layer.masksToBounds = NO;
    _settingTimeButton.layer.shadowOpacity = 1.0;
    _settingTimeButton.layer.shadowRadius = 0.0;
    _settingTimeButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(8.0));
    _settingTimeButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    _settingTimeButton.layer.borderWidth = LearnMathScale(2.0);
    _settingTimeButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    _settingTimeButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    [self.contentView addSubview:self.settingTimeButton];
    [self.settingTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _titleLabel.font = [UIFont poppinsFontOfSize:14.0 weight:UIFontWeightBold];
    [self.settingTimeButton addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LearnMathScale(14.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(243.0), LearnMathScale(18.0)));
    }];
}
@end
