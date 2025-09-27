//
//  ModesSelectedViewCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import "ModesSelectedViewCell.h"

@implementation ModesSelectedViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
    _modeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _modeButton.layer.cornerRadius = LearnMathScale(10.0);
    _modeButton.layer.masksToBounds = NO;
    _modeButton.layer.shadowOpacity = 1.0;
    _modeButton.layer.shadowRadius = 0.0;
    _modeButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(8.0));
    _modeButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    _modeButton.layer.borderWidth = LearnMathScale(2.0);
    _modeButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    _modeButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    [self.contentView addSubview:self.modeButton];
    [self.modeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _modeImg = [[UIImageView alloc] init];
    [self.modeButton addSubview:self.modeImg];
    [self.modeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LearnMathScale(15.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(16.0), LearnMathScale(16.0)));
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _titleLabel.font = [UIFont poppinsFontOfSize:14 weight:UIFontWeightBold];
    [self.modeButton addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.modeImg.mas_trailing).offset(LearnMathScale(8.0));
        make.top.mas_equalTo(LearnMathScale(14.0));
        make.height.mas_equalTo(LearnMathScale(18.0));
    }];
}

@end
