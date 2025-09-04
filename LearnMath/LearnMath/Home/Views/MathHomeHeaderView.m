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
    UIImageView *background_image = [[UIImageView alloc] init];
    [self addSubview:background_image];
    background_image.image = [UIImage imageNamed:@"background_image"];
    [background_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.mas_equalTo(LearnMathScale(180.0));
    }];
    
    UIImageView *smile_image = [[UIImageView alloc] init];
    smile_image.image = [UIImage imageNamed:@"smile_image"];
    [self addSubview:smile_image];
    [smile_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(170.0), LearnMathScale(130.0)));
        make.top.equalTo(self).offset(LearnMathScale(110.0));
        make.left.equalTo(self).offset(LearnMathScale(102.0));
    }];
    
    UIImageView *logo_image = [[UIImageView alloc] init];
    logo_image.image = [UIImage imageNamed:@"logo_image"];
    [self addSubview:logo_image];
    [logo_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(280.0), LearnMathScale(60.0)));
        make.top.and.left.equalTo(self).offset(LearnMathScale(48.8));
    }];
}

@end
