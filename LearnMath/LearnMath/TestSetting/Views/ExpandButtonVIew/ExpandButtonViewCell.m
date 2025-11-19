//
//  ExpandButtonViewCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/14.
//

#import "ExpandButtonViewCell.h"

@implementation ExpandButtonViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
        self.isSelected = NO;
    }
    return self;
}

- (void)setUpSubviews
{
    _stackView = [[UIStackView alloc] init];
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.distribution = UIStackViewDistributionFill;
    _stackView.spacing = LearnMathScale(10.0);
    _stackView.alignment = UIStackViewAlignmentCenter;
    [self.contentView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.height.equalTo(self.contentView);
    }];
    
    _selectedImage = [[UIImageView alloc] init];
    _selectedImage.image = [UIImage imageNamed:@"TestSetting_box_unselect"];
    [self.stackView addArrangedSubview:self.selectedImage];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _titleLabel.font = [UIFont ap_poppins:13.0 weight:UIFontWeightMedium];
    [self.stackView addArrangedSubview:self.titleLabel];
    
    _selectedButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    [self.selectedButton addTarget:self action:@selector(didSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.stackView addSubview:self.selectedButton];
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stackView);
    }];
}

- (void)didSelectedButton:(ScaleableButton *)sender
{
    if ([self.delegeate respondsToSelector:@selector(ExpandButtonVIewCell:didClickedButton:)]) {
        [self.delegeate ExpandButtonVIewCell:self didClickedButton:sender];
    }
}
@end
