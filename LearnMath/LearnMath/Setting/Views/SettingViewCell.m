//
//  SettingViewCell.m
//  LearnMath
//
//  Created by 基 on 2025/10/14.
//

#import "SettingViewCell.h"

@implementation SettingViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
    _scaleButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    _scaleButton.layer.cornerRadius = 10.0;
    _scaleButton.layer.masksToBounds = NO;
    _scaleButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    _scaleButton.layer.shadowOpacity = 1.0;
    _scaleButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(6.0));
    _scaleButton.layer.shadowRadius = 0.0;
    _scaleButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    _scaleButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    _scaleButton.layer.borderWidth = 2.0;
    [self.contentView addSubview:self.scaleButton];
    
    [self.scaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _stackView = [[UIStackView alloc] init];
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.distribution = UIStackViewDistributionFill;
    _stackView.alignment = UIStackViewAlignmentFill;
    _stackView.spacing = 4.0;
    [self.contentView addSubview:self.stackView];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(LearnMathScale(16.0));
        make.centerY.equalTo(self.contentView);
        make.trailing.lessThanOrEqualTo(self.contentView).offset(-LearnMathScale(90.0));
    }];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont ap_poppins:16.0 weight:UIFontWeightBold];
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.stackView addArrangedSubview:self.titleLabel];

    _subTitleLabel = [[UILabel alloc] init];
    _subTitleLabel.font = [UIFont ap_poppins:14.0 weight:UIFontWeightBold];
    _subTitleLabel.textColor = [UIColor colorForSet:ColorSetHeaderSectionTitle];
    _subTitleLabel.hidden = YES;
    [self.stackView addArrangedSubview:self.subTitleLabel];
    

    _clearButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    [_clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [_clearButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    _clearButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _clearButton.hidden = YES;
    _clearButton.layer.cornerRadius = 10;
    _clearButton.layer.masksToBounds = NO;
    _clearButton.layer.shadowColor = [UIColor colorForSet:ColorSetPurple].CGColor;
    _clearButton.layer.shadowOpacity = 1.0;
    _clearButton.layer.shadowOffset = CGSizeMake(0, 4);
    _clearButton.layer.shadowRadius = 0;
    _clearButton.layer.borderColor = [UIColor colorForSet:ColorSetPurple].CGColor;
    _clearButton.layer.borderWidth = 2.0;
    _clearButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    [self.contentView addSubview:self.clearButton];
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(62.0), LearnMathScale(30.0)));
        make.trailing.equalTo(self.contentView).offset(-LearnMathScale(16.0));
        make.centerY.equalTo(self.contentView);
    }];
    
    _switchBtn = [[SevenSwitch alloc] init];
    _switchBtn.thumbImageSize = CGSizeMake(LearnMathScale(40.0), LearnMathScale(34.0));
    _switchBtn.thumbImage = [UIImage imageNamed:@"mine_off_icon"];
    _switchBtn.onTintColor = [UIColor colorForSet:ColorSetPurple];
    _switchBtn.inactiveColor = [UIColor colorForSet:ColorSetSkillShadow];
    _switchBtn.onThumbTintColor = UIColor.clearColor;
    _switchBtn.thumbTintColor = UIColor.clearColor;
    _switchBtn.isRounded = YES;
    _switchBtn.spacing = 0.0;
    _switchBtn.on = NO;
    [self.switchBtn addTarget:self action:@selector(switchBtnValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switchBtn];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(64.0), LearnMathScale(24.0)));
        make.trailing.equalTo(self.contentView).offset(-LearnMathScale(16.0));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)configureWithItem:(SettingItem *)item
{
    self.titleLabel.text = item.title;
    if (item.subTitle.length > 0) {
        self.subTitleLabel.hidden = NO;
        self.subTitleLabel.text = item.subTitle;
    } else {
        self.subTitleLabel.hidden = YES;
    }

    self.switchBtn.on = item.isOn;
    [self switchBtnValueChanged:self.switchBtn];

    if (item.type == SettingItemTypeClearCache) {
        self.clearButton.hidden = NO;
        self.switchBtn.hidden = YES;
    } else {
        self.clearButton.hidden = YES;
        self.switchBtn.hidden = NO;
    }
}

- (void)switchBtnValueChanged:(SevenSwitch *)switchBtn
{
    switchBtn.thumbImage = switchBtn.on ? [UIImage imageNamed:@"setting_on_icon"] : [UIImage imageNamed:@"setting_off_icon"];
    if ([self.delegate respondsToSelector:@selector(settingsCell:switchBtnValueChanged:)]) {
        [self.delegate settingsCell:self switchBtnValueChanged:switchBtn];
    }
}

- (void)clearButtonTapped:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(settingsCell:didClickedClearBtn:)]) {
        [self.delegate settingsCell:self didClickedClearBtn:sender];
    }
}



@end
