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
    _scaleButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
            [self.scaleButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.scaleButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
            [self.scaleButton.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.scaleButton.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor]
    ]];
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [UIImage imageNamed:@"arrowImageView"];
    [self.scaleButton addSubview:_arrowImageView];
    _arrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.arrowImageView.trailingAnchor constraintEqualToAnchor:self.scaleButton.trailingAnchor constant:LearnMathScale(-20.0)],
        [self.arrowImageView.topAnchor constraintEqualToAnchor:self.scaleButton.topAnchor constant:LearnMathScale(12.0)],
        [self.arrowImageView.widthAnchor constraintEqualToConstant:LearnMathScale(20.0)],
        [self.arrowImageView.heightAnchor constraintEqualToConstant:LearnMathScale(20.0)]
        ]];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [self.scaleButton addSubview:_titleLabel];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.arrowImageView.leadingAnchor constant:LearnMathScale(-5.0)],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.scaleButton.topAnchor constant:LearnMathScale(12.0)],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.scaleButton.leadingAnchor constant:LearnMathScale(20.0)],
        [self.titleLabel.heightAnchor constraintEqualToConstant:LearnMathScale(20.0)]
    ]];
    
    _tutorStackView = [[UIStackView alloc] init];
    _tutorStackView.distribution = UIStackViewDistributionFill;
    _tutorStackView.axis = UILayoutConstraintAxisHorizontal;
    _tutorStackView.alignment = UIStackViewAlignmentCenter;
    _tutorStackView.spacing = LearnMathScale(3.0);
    [self.scaleButton addSubview:_tutorStackView];
    _tutorStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
            [self.tutorStackView.trailingAnchor constraintEqualToAnchor:self.scaleButton.trailingAnchor constant:LearnMathScale(-20.0)],
            [self.tutorStackView.bottomAnchor constraintEqualToAnchor:self.scaleButton.bottomAnchor constant:LearnMathScale(-12.0)],
            [self.tutorStackView.heightAnchor constraintEqualToConstant:LearnMathScale(26.0)]
    ]];
    
    _videoImageView = [[UIImageView alloc] init];
    _videoImageView.image = [UIImage imageNamed:@"videoImage"];
    _videoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tutorStackView addArrangedSubview:_videoImageView];
    
    _tutorialLabel = [[UILabel alloc] init];
    _tutorialLabel.textAlignment = NSTextAlignmentCenter;
    _tutorialLabel.text = @"Tutorial";
    _tutorialLabel.font = [UIFont systemFontOfSize:14];
    _tutorialLabel.textColor = [UIColor colorForSet:ColorSetPurple];
    _tutorialLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tutorStackView addArrangedSubview:_tutorialLabel];
    
    _tutorialButton = [[UIButton alloc] init];
    _tutorialButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scaleButton addSubview:_tutorialButton];
    [NSLayoutConstraint activateConstraints:@[
            [self.tutorialButton.bottomAnchor constraintEqualToAnchor:self.tutorStackView.bottomAnchor],
            [self.tutorialButton.trailingAnchor constraintEqualToAnchor:self.tutorStackView.trailingAnchor],
            [self.tutorialButton.heightAnchor constraintEqualToAnchor:self.tutorStackView.heightAnchor],
            [self.tutorialButton.widthAnchor constraintEqualToAnchor:self.tutorStackView.widthAnchor]
    ]];
    
    _progressStackView = [[UIStackView alloc] init];
    _progressStackView.distribution = UIStackViewDistributionFill;
    _progressStackView.axis = UILayoutConstraintAxisHorizontal;
    _progressStackView.alignment = UIStackViewAlignmentCenter;
    _progressStackView.spacing = LearnMathScale(8.0);
    _progressStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scaleButton addSubview:_progressStackView];
    [NSLayoutConstraint activateConstraints:@[
        [self.progressStackView.leadingAnchor constraintEqualToAnchor:self.scaleButton.leadingAnchor constant:LearnMathScale(20.0)],
        [self.progressStackView.bottomAnchor constraintEqualToAnchor:self.scaleButton.bottomAnchor constant:LearnMathScale(-12.0)],
        [self.progressStackView.heightAnchor constraintEqualToConstant:LearnMathScale(12.0)]
        ]];
    
    _progressView = [[UIProgressView alloc] init];
    _progressView.tintColor = [UIColor colorForSet:ColorSetOrange];
    _progressView.trackTintColor = [UIColor colorForSet:ColorSetSkillShadow];
    _progressView.progress = 0.0;
    _progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.progressStackView addArrangedSubview:_progressView];
    [NSLayoutConstraint activateConstraints:@[
        [self.progressView.heightAnchor constraintEqualToConstant:LearnMathScale(12.0)],
        [self.progressView.widthAnchor constraintEqualToConstant:LearnMathScale(100.0)]
    ]];
    _progressLabel = [[UILabel alloc] init];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    _progressLabel.font = [UIFont systemFontOfSize:14.0];
    _progressLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _progressLabel.text = @"0%";
    _progressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.progressStackView addArrangedSubview:_progressLabel];
    
    
    
    self.contentView.layer.cornerRadius = LearnMathScale(12.0);

}
@end
