//
//  HelpViewCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import "HelpViewCell.h"

@implementation HelpViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
    _numImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.numImgView];
    [self.numImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(60.0), LearnMathScale(70.0)));
        make.top.leading.equalTo(self.contentView);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont balooFontOfSize:20 weight:UIFontWeightRegular];
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LearnMathScale(12.0));
        make.leading.equalTo(self.numImgView.mas_trailing).offset(LearnMathScale(10.0));
        make.trailing.equalTo(self.contentView);
        make.height.mas_equalTo(LearnMathScale(24.0));
    }];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.font = [UIFont poppinsFontOfSize:13 weight:UIFontWeightMedium];
    _detailLabel.textColor = [UIColor colorForSet:ColorSetHeaderSectionTitle];
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    _detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(LearnMathScale(2.0));
        make.leading.equalTo(self.numImgView.mas_trailing).offset(LearnMathScale(10.0));
        make.trailing.equalTo(self.contentView).offset(-LearnMathScale(10.0));
    }];
    
}
@end
