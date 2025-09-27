//
//  MathHomeHeaderView.m
//  LearnMath
//
//  Created by 基 on 2025/9/3.
//

#import "MathHomeHeaderView.h"

@implementation MathHomeHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configureMathHomeHeaderView];
    }
    return self;
}

-(void)configureMathHomeHeaderView
{
    UIImageView *home_background = [[UIImageView alloc] init];
    [self addSubview:home_background];
    home_background.image = [UIImage imageNamed:@"home_background"];
    [home_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.height.mas_equalTo(LearnMathScale(180.0));
    }];
    
    UIImageView *home_smile = [[UIImageView alloc] init];
    home_smile.image = [UIImage imageNamed:@"home_smile"];
    [self addSubview:home_smile];
    [home_smile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(170.0), LearnMathScale(130.0)));
        make.top.equalTo(self).offset(LearnMathScale(110.0));
        make.centerX.equalTo(self);
    }];
    
    UIImageView *home_logo = [[UIImageView alloc] init];
    home_logo.image = [UIImage imageNamed:@"home_logo"];
    [self addSubview:home_logo];
    [home_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(280.0), LearnMathScale(60.0)));
        make.top.equalTo(self).offset(LearnMathScale(48.8));
        make.centerX.equalTo(self);
    }];
}

@end
