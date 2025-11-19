//
//  SubscribeHeaderView.m
//  LearnMath
//
//  Created by 基 on 2025/9/28.
//

#import "SubscribeHeaderView.h"

@implementation SubscribeHeaderView
{
    UIView *_contentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(LearnMathScale(30.0), LearnMathScale(20.0), 0.0, LearnMathScale(20.0)));
    }];
    
    UIImageView *titleImage = [[UIImageView alloc] init];
    titleImage.image = [UIImage imageNamed:@"subscription_title"];
    [_contentView addSubview:titleImage];
    [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(287.0), LearnMathScale(34.0)));
        make.top.leading.equalTo(_contentView);
    }];
    
    UIStackView *stackView1 = [[UIStackView alloc] init];
    stackView1.axis = UILayoutConstraintAxisHorizontal;
    stackView1.distribution = UIStackViewDistributionFill;
    stackView1.alignment = UIStackViewAlignmentCenter;
    stackView1.spacing = LearnMathScale(8.0);
    [_contentView addSubview:stackView1];
    [stackView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleImage.mas_bottom).offset(LearnMathScale(12.0));
        make.leading.equalTo(_contentView);
        make.trailing.equalTo(_contentView);
    }];
    UIStackView *stackView2 = [[UIStackView alloc] init];
    stackView2.axis = UILayoutConstraintAxisHorizontal;
    stackView2.distribution = UIStackViewDistributionFill;
    stackView2.alignment = UIStackViewAlignmentCenter;
    stackView2.spacing = LearnMathScale(8.0);
    [_contentView addSubview:stackView2];
    [stackView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stackView1.mas_bottom).offset(LearnMathScale(10.0));
        make.trailing.equalTo(_contentView);
        make.leading.equalTo(_contentView);
    }];
    UIStackView *stackView3 = [[UIStackView alloc] init];
    stackView3.axis = UILayoutConstraintAxisHorizontal;
    stackView3.distribution = UIStackViewDistributionFill;
    stackView3.alignment = UIStackViewAlignmentCenter;
    stackView3.spacing = LearnMathScale(8.0);
    [_contentView addSubview:stackView3];
    [stackView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stackView2.mas_bottom).offset(LearnMathScale(10.0));
        make.trailing.equalTo(_contentView);
        make.leading.equalTo(_contentView);
    }];
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.image = [UIImage imageNamed:@"subscription_desc"];
    [stackView1 addArrangedSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.image = [UIImage imageNamed:@"subscription_desc"];
    [stackView2 addArrangedSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.image = [UIImage imageNamed:@"subscription_desc"];
    [stackView3 addArrangedSubview:imageView3];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont ap_poppins:14.0 weight:UIFontWeightBold];
    label1.text = @"All the math tricks tutorials, training and testing.";
    label1.numberOfLines = 0;
    label1.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [stackView1 addArrangedSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont ap_poppins:14.0 weight:UIFontWeightBold];
    label2.text = @"Detailed records of testing history results. ";
    label2.numberOfLines = 0;
    label2.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [stackView2 addArrangedSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.font = [UIFont ap_poppins:14.0 weight:UIFontWeightBold];
    label3.text = @"Overall personalized data and skill analysis. ";
    label3.numberOfLines = 0;
    label3.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    [stackView3 addArrangedSubview:label3];
}

@end
