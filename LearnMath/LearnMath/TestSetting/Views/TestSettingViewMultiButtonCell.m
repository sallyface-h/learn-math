//
//  TestSettingViewMultiButtonCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingViewMultiButtonCell.h"

@implementation TestSettingViewMultiButtonCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        _settingNumButtonArr = [NSMutableArray array];
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    _settingStackView = [[UIStackView alloc] init];
    _settingStackView.axis = UILayoutConstraintAxisHorizontal;
    _settingStackView.alignment = UIStackViewAlignmentCenter;
    _settingStackView.spacing = LearnMathScale(10.0);
    _settingStackView.distribution = UIStackViewDistributionFillEqually;
    [self.contentView addSubview:self.settingStackView];
    [self.settingStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)configureWithCalculateNums:(NSArray<NSString *> *)calculateNums andSelectedIndex:(NSInteger)selectedIndex
{
    [self.settingNumButtonArr removeAllObjects];
    for (UIView *subview in self.settingStackView.arrangedSubviews) {
        [self.settingStackView removeArrangedSubview:subview];
        [subview removeFromSuperview];
    }
    
    for (NSInteger i = 0; i < calculateNums.count; i++) {
        UIButton *settingNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        settingNumButton.tag = i;
        settingNumButton.layer.cornerRadius = LearnMathScale(10.0);
        settingNumButton.layer.masksToBounds = NO;
        settingNumButton.layer.shadowOpacity = 1.0;
        settingNumButton.layer.shadowRadius = 0.0;
        settingNumButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(8.0));
        settingNumButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
        settingNumButton.layer.borderWidth = LearnMathScale(2.0);
        if (settingNumButton.tag == selectedIndex) {
            settingNumButton.layer.borderColor = [UIColor colorForSet:ColorSetPurple].CGColor;
        } else {
            settingNumButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
        }
        settingNumButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
        [self.settingStackView addArrangedSubview:settingNumButton];
        [self.settingNumButtonArr addObject:settingNumButton];
        [settingNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(LearnMathScale(46.0));
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = calculateNums[i];
        label.textColor = [UIColor colorForSet:ColorSetSkillTitle];
        label.font = [UIFont poppinsFontOfSize:14.0 weight:UIFontWeightBold];
        [settingNumButton addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(settingNumButton);
            make.centerY.equalTo(settingNumButton);
            make.size.mas_equalTo(CGSizeMake(LearnMathScale(41.0), LearnMathScale(18.0)));
        }];
    }
}

@end
