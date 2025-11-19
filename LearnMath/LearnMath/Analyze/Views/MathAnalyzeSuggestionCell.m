//
//  MathAnalyzeSuggestionCell.m
//  LearnMath
//
//  Created by 基 on 2025/11/19.
//

#import "MathAnalyzeSuggestionCell.h"
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@interface MathAnalyzeSuggestionCell ()
@property (nonatomic, strong) ScaleableButton *scaleButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *downImageView;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *contentTitleLabel;
@property (nonatomic, strong) UILabel *contentTipsLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *keepFightingImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@end
@implementation MathAnalyzeSuggestionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.scaleButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    self.scaleButton.layer.cornerRadius = LearnMathScale(10.0);
    self.scaleButton.layer.masksToBounds = NO;
    self.scaleButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    self.scaleButton.layer.shadowOpacity = 1.0;
    self.scaleButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(6.0) );
    self.scaleButton.layer.shadowRadius = 0;
    self.scaleButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    self.scaleButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    self.scaleButton.layer.borderWidth = LearnMathScale(2.0);
    [self.scaleButton addTarget:self action:@selector(bgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.scaleButton];
    [self.scaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont ap_poppins:LearnMathScale(14.0) weight:UIFontWeightBold];
    self.titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.scaleButton addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.trailing.mas_equalTo(-LearnMathScale(16.0));
        make.top.mas_equalTo(LearnMathScale(12.0));
        make.height.mas_equalTo(LearnMathScale(20.0));
    }];

    self.downImageView = [[UIImageView alloc] init];
    self.downImageView.image = [UIImage imageNamed:@"Analyze_down_arrow"];
    [self.scaleButton addSubview:self.downImageView];
    [self.downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.mas_equalTo(-LearnMathScale(16.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(20.0), LearnMathScale(20.0)));
    }];

    self.lineView = [[UIView alloc] init];
    self.lineView.hidden = YES;
    self.lineView.backgroundColor = [UIColor colorForSet:ColorSetSkillBorder];
    [self.scaleButton addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LearnMathScale(44.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.trailing.mas_equalTo(-LearnMathScale(16.0));
        make.height.mas_equalTo(LearnMathScale(1.0));
    }];

    self.contentTitleLabel = [[UILabel alloc] init];
    self.contentTitleLabel.numberOfLines = 0;
    self.contentTitleLabel.hidden = YES;
    [self.scaleButton addSubview:self.contentTitleLabel];
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(LearnMathScale(12.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.trailing.mas_equalTo(-LearnMathScale(16.0));
    }];

    self.contentTipsLabel = [[UILabel alloc] init];
    self.contentTipsLabel.numberOfLines = 0;
    self.contentTipsLabel.hidden = YES;
    [self.scaleButton addSubview:self.contentTipsLabel];
    [self.contentTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTitleLabel.mas_bottom).offset(LearnMathScale(18.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.trailing.mas_equalTo(-LearnMathScale(16.0));
    }];

    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.hidden = YES;
    [self.scaleButton addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTipsLabel.mas_bottom).offset(LearnMathScale(4.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.trailing.mas_equalTo(-LearnMathScale(16.0));
    }];

    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.image = [UIImage imageNamed:@"Analyze_icon"];
    self.iconImageView.hidden = YES;
    [self.scaleButton addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-LearnMathScale(20.0));
        make.trailing.mas_equalTo(-LearnMathScale(16.0));
        make.width.mas_equalTo(LearnMathScale(80.0));
        make.height.mas_equalTo(LearnMathScale(62.0));
    }];

    self.keepFightingImageView = [[UIImageView alloc] init];
    self.keepFightingImageView.image = [UIImage imageNamed:@"Analyze_keepflightingicon"];
    self.keepFightingImageView.hidden = YES;
    [self.scaleButton addSubview:self.keepFightingImageView];
    [self.keepFightingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-LearnMathScale(46.0));
        make.trailing.mas_equalTo(-LearnMathScale(100.0));
        make.width.mas_equalTo(LearnMathScale(140.0));
        make.height.mas_equalTo(LearnMathScale(46.0));
    }];
}

- (void)bgButtonAction:(ScaleableButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mathAnalyzeSuggestionCell:didClickedBgButton:)]) {
        [self.delegate mathAnalyzeSuggestionCell:self didClickedBgButton:sender];
    }
}
@end
