//
//  SubscribeBottomView.m
//  LearnMath
//
//  Created by 基 on 2025/9/28.
//

#import "SubscribeBottomView.h"

@implementation SubscribeBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
    _stackView1 = [[UIStackView alloc] init];
    _stackView1.axis = UILayoutConstraintAxisVertical;
    _stackView1.alignment = UIStackViewAlignmentFill;
    _stackView1.distribution = UIStackViewDistributionFill;
    _stackView1.spacing = LearnMathScale(14.0);
    [self addSubview:self.stackView1];
    [self.stackView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
    }];
    
    _subscribeButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    [_subscribeButton setTitle:@"Subscribe" forState:UIControlStateNormal];
    _subscribeButton.titleLabel.font = [UIFont ap_baloo:20.0 weight:UIFontWeightRegular];
    [_subscribeButton setTitleColor:[UIColor colorForSet:ColorSetWhite] forState:UIControlStateNormal];
    _subscribeButton.layer.cornerRadius = LearnMathScale(10.0);
    _subscribeButton.layer.masksToBounds = NO;
    _subscribeButton.layer.shadowOpacity = 1.0;
    _subscribeButton.layer.shadowRadius = 0.0;
    _subscribeButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(8.0));
    _subscribeButton.backgroundColor = [UIColor whiteColor];
    _subscribeButton.layer.borderWidth = LearnMathScale(2.0);
    _subscribeButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    _subscribeButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    
    UIColor *color1 = [UIColor colorForSet:ColorSetGradient1];
    UIColor *color2 = [UIColor colorForSet:ColorSetGradient2];
    UIColor *color3 = [UIColor colorForSet:ColorSetGradient3];
    [self.subscribeButton applyGradientWithColors:@[color1, color2, color3] direction:GradientDirectionTopLeftToBottomRight locations:@[@(0.0),@(0.65),@(1.0)] rect:CGRectMake(0.0, 0.0, SCREEN_WIDTH - LearnMathScale(24.0) * 2, LearnMathScale(54.0)) cornerRadius:LearnMathScale(10.0)];

    [self.subscribeButton addTarget:self action:@selector(subscribeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.stackView1 addArrangedSubview:self.subscribeButton];
    [self.subscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LearnMathScale(54.0));
        make.width.equalTo(self.stackView1);
    }];
    
    _expireLabel = [[UILabel alloc] init];
    _expireLabel.textAlignment = NSTextAlignmentCenter;
    _expireLabel.font = [UIFont ap_poppins:LearnMathScale(13.0) weight:UIFontWeightMedium];
    _expireLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _expireLabel.text = @"Expired: 2024/01/01";
    _expireLabel.hidden = YES;
    [self.stackView1 addArrangedSubview:self.expireLabel];
    
    _restoreButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString *restoreStr = [[NSMutableAttributedString alloc] initWithString:@"Restore Purchases"
        attributes:@{
        NSFontAttributeName : [UIFont ap_poppins:LearnMathScale(14.0) weight:UIFontWeightBold],
        NSForegroundColorAttributeName : [UIColor colorForSet:ColorSetSkillTitle],
        NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)
    }];
    [_restoreButton setAttributedTitle:restoreStr forState:UIControlStateNormal];
    [self.restoreButton addTarget:self action:@selector(restoreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.restoreButton];
    [self.restoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stackView1.mas_bottom).offset(LearnMathScale(4.0));
        make.leading.trailing.equalTo(self.stackView1);
        make.height.mas_equalTo(LearnMathScale(38.0));
    }];
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.numberOfLines = 0;
    _descLabel.textAlignment = NSTextAlignmentLeft;
    _descLabel.font = [UIFont ap_poppins:LearnMathScale(10.0) weight:UIFontWeightMedium];
    _descLabel.textColor = [UIColor colorForSet:ColorSetHeaderSectionTitle];
    _descLabel.text = @"Please Note: Subscriptions will automatically renew unless canceled within 24-hours before the end of the current period. You can cancel anytime with your iTunes account settings. Features that require payment will not be available after the subscription expires.";
    _descLabel.hidden = YES;
    [self addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.restoreButton.mas_bottom);
        make.leading.trailing.equalTo(self.stackView1);
    }];
    
    _stackView2 = [[UIStackView alloc] init];
    _stackView2.axis = UILayoutConstraintAxisHorizontal;
    _stackView2.alignment = UIStackViewAlignmentFill;
    _stackView2.distribution = UIStackViewDistributionFillEqually;
    _stackView2.spacing = 0.0;
    [self addSubview:self.stackView2];
    [self.stackView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.restoreButton.mas_bottom);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(LearnMathScale(192.0));
        make.height.mas_equalTo(LearnMathScale(34.0));
        make.bottom.equalTo(self);
    }];
    
    _privacyButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString *privacyStr = [[NSMutableAttributedString alloc] initWithString:@"Privacy Policy" attributes:@{
        NSFontAttributeName : [UIFont ap_poppins:11.0 weight:UIFontWeightMedium],
        NSForegroundColorAttributeName : [UIColor colorForSet:ColorSetSkillTitle],
        NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)
    }];
    [_privacyButton setAttributedTitle:privacyStr forState:UIControlStateNormal];
    [self.privacyButton addTarget:self action:@selector(privacyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.stackView2 addArrangedSubview:self.privacyButton];
    
    _serviceButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString *serviceStr = [[NSMutableAttributedString alloc] initWithString:@"Term Of Service" attributes:@{
        NSFontAttributeName : [UIFont ap_poppins:11.0 weight:UIFontWeightMedium],
        NSForegroundColorAttributeName : [UIColor colorForSet:ColorSetSkillTitle],
        NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)
    }];
    [_serviceButton setAttributedTitle:serviceStr forState:UIControlStateNormal];
    [self.serviceButton addTarget:self action:@selector(serviceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.stackView2 addArrangedSubview:self.serviceButton];
}

- (void)updateExpiredDate:(NSDate *)date {
    if (date) {
        self.expireLabel.hidden = NO;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy/MM/dd";
        NSString *dateStr = [formatter stringFromDate:date];
        self.expireLabel.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"Expired: ", nil), dateStr];
    } else {
        self.expireLabel.hidden = YES;
        self.expireLabel.text = [NSString stringWithFormat:@"%@2024/01/01", NSLocalizedString(@"Expired: ", nil)];
    }
}

#pragma mark - Actions

- (void)subscribeButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(subscriptionBottomView:subscribeButtonAction:)]) {
        [self.delegate subscriptionBottomView:self subscribeButtonAction:sender];
    }
}

- (void)restoreButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(subscriptionBottomView:restoreButtonAction:)]) {
        [self.delegate subscriptionBottomView:self restoreButtonAction:sender];
    }
}

- (void)privacyButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(subscriptionBottomView:privacyButtonAction:)]) {
        [self.delegate subscriptionBottomView:self privacyButtonAction:sender];
    }
}

- (void)serviceButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(subscriptionBottomView:serviceButtonAction:)]) {
        [self.delegate subscriptionBottomView:self serviceButtonAction:sender];
    }
}
@end
