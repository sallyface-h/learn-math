//
//  MathCateGoryViewCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import "MathCateGoryViewCell.h"

@implementation MathCateGoryViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}

-(void)setUpSubViews
{
    _scaleButton = [[UIButton alloc] init];
    _scaleButton.layer.cornerRadius = LearnMathScale(16.0);
    _scaleButton.layer.masksToBounds = NO;
    _scaleButton.layer.shadowOpacity = 1.0;
    _scaleButton.layer.shadowRadius = 0.0;
    _scaleButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(8.0));
    _scaleButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    _scaleButton.layer.borderWidth = LearnMathScale(2.0);
    _scaleButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    _scaleButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    [self.contentView addSubview:_scaleButton];
    [self.scaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [UIImage imageNamed:@"arrowImageView"];
    [self.scaleButton addSubview:_arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(20.0), LearnMathScale(20.0)));
        make.top.mas_equalTo(LearnMathScale(12.0));
        make.trailing.mas_equalTo(-LearnMathScale(20.0));
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont poppinsFontOfSize:16.0 weight:UIFontWeightBold];
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.scaleButton addSubview:_titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(LearnMathScale(12.0));
        make.trailing.equalTo(self.arrowImageView.mas_leading).offset(-LearnMathScale(5.0));
        make.height.mas_equalTo(LearnMathScale(20.0));
    }];
    
    _tutorStackView = [[UIStackView alloc] init];
    _tutorStackView.distribution = UIStackViewDistributionFill;
    _tutorStackView.axis = UILayoutConstraintAxisHorizontal;
    _tutorStackView.alignment = UIStackViewAlignmentCenter;
    _tutorStackView.spacing = LearnMathScale(4.0);
    [self.scaleButton addSubview:_tutorStackView];
    [self.tutorStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-LearnMathScale(20.0));
        make.bottom.mas_equalTo(-LearnMathScale(12.0));
        make.height.mas_equalTo(LearnMathScale(26.0));
    }];
    
    _videoImageView = [[UIImageView alloc] init];
    _videoImageView.image = [UIImage imageNamed:@"videoImage"];
    [self.tutorStackView addArrangedSubview:_videoImageView];
    
    _tutorialLabel = [[UILabel alloc] init];
    _tutorialLabel.textAlignment = NSTextAlignmentCenter;
    _tutorialLabel.text = @"Tutorial";
    _tutorialLabel.font = [UIFont poppinsFontOfSize:14.0 weight:UIFontWeightBold];
    _tutorialLabel.textColor = [UIColor colorForSet:ColorSetPurple];
    [self.tutorStackView addArrangedSubview:_tutorialLabel];
    
    _tutorialButton = [[UIButton alloc] init];
    [self.scaleButton addSubview:_tutorialButton];
    [self.tutorialButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tutorStackView);
    }];
    
    _progressStackView = [[UIStackView alloc] init];
    _progressStackView.distribution = UIStackViewDistributionFill;
    _progressStackView.axis = UILayoutConstraintAxisHorizontal;
    _progressStackView.alignment = UIStackViewAlignmentCenter;
    _progressStackView.spacing = LearnMathScale(8.0);
    [self.scaleButton addSubview:_progressStackView];
    [self.progressStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(LearnMathScale(20.0));
        make.bottom.mas_equalTo(-LearnMathScale(12.0));
        make.centerY.equalTo(self.tutorStackView);
    }];
    
    _progressView = [[UIProgressView alloc] init];
    _progressView.tintColor = [UIColor colorForSet:ColorSetOrange];
    _progressView.trackTintColor = [UIColor colorForSet:ColorSetSkillShadow];
    _progressView.progress = 0.0;
    [self.progressStackView addArrangedSubview:_progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(100.0), LearnMathScale(12.0)));
    }];
    _progressLabel = [[UILabel alloc] init];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    _progressLabel.font = [UIFont poppinsFontOfSize:14.0 weight:UIFontWeightBold];
    _progressLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _progressLabel.text = @"0%";
    [self.progressStackView addArrangedSubview:_progressLabel];
    
    self.contentView.layer.cornerRadius = LearnMathScale(12.0);
}

@end
