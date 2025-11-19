//
//  SubscribeViewCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/28.
//

#import "SubscribeViewCell.h"

@implementation SubscribeViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUPSubviews];
    }
    return self;
}

- (void)setUPSubviews
{
    _button = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    _button.layer.cornerRadius = LearnMathScale(10.0);
    _button.layer.masksToBounds = NO;
    _button.layer.shadowOpacity = 1.0;
    _button.layer.shadowRadius = 0.0;
    _button.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(8.0));
    _button.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    _button.layer.borderWidth = LearnMathScale(2.0);
    _button.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    _button.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    [self.contentView addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.leading.mas_equalTo(LearnMathScale(20.0));
        make.trailing.mas_equalTo(-LearnMathScale(20.0));
    }];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    [self.button addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LearnMathScale(11.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.height.mas_equalTo(24.0);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _priceLabel.font = [UIFont ap_baloo:20.0 weight:UIFontWeightRegular];
    [stackView addArrangedSubview:self.priceLabel];
    
    _originalPriceLabel = [[UILabel alloc] init];
    _originalPriceLabel.textAlignment = NSTextAlignmentCenter;
    _originalPriceLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _originalPriceLabel.font = [UIFont ap_baloo:16.0 weight:UIFontWeightRegular];
    [stackView addArrangedSubview:self.originalPriceLabel];
    
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.textAlignment = NSTextAlignmentCenter;
    _lineLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _lineLabel.font = [UIFont ap_baloo:16.0 weight:UIFontWeightRegular];
    _lineLabel.text = @"/";
    [stackView addArrangedSubview:self.lineLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _timeLabel.font = [UIFont ap_baloo:16.0 weight:UIFontWeightRegular];
    [stackView addArrangedSubview:self.timeLabel];
}


@end
