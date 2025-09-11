//
//  MathHomeViewMultiButtonCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/3.
//

#import "MathHomeViewMultiButtonCell.h"

@implementation MathHomeViewMultiButtonCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews
{
    _StackView = [[UIStackView alloc] init];
    _StackView.distribution = UIStackViewDistributionFillEqually;
    _StackView.axis = UILayoutConstraintAxisHorizontal;
    _StackView.alignment = UIStackViewAlignmentCenter;
    _StackView.spacing = LearnMathScale(13.0);
    [self.contentView addSubview:self.StackView];
    [self.StackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
    }];
    
}
-(void)configureWithModel:(HomeMultiButtonModel *)model
{
    self.model = model;
    for (UIView *sub in self.StackView.arrangedSubviews) {
            [self.StackView removeArrangedSubview:sub];
            [sub removeFromSuperview];
        }
    
    UIImageView *home_pro = [[UIImageView alloc] init];
    home_pro.image = [UIImage imageNamed:@"home_pro"];
    home_pro.layer.masksToBounds = YES;
    
    for (NSInteger i = 0;i <model.imgName.count;i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.backgroundColor = model.color;
        btn.layer.cornerRadius = LearnMathScale(16.0);
        btn.layer.shadowRadius =  0.0;
        btn.layer.shadowOpacity = 1.0;
        btn.layer.masksToBounds = NO;
        btn.layer.shadowOffset = CGSizeMake(0.0, LearnMathScale(8.0));
        btn.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
        [self.StackView addArrangedSubview:btn];
        [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont balooFontOfSize:24.0 weight:UIFontWeightBold];
        textLabel.textColor = [UIColor colorForSet:ColorSetWhite];
        textLabel.text = model.title[i];
        if ([model.imgName[i] isEqualToString: @"nil"]) {
            [self.StackView addArrangedSubview:btn];
            self.StackView.distribution = UIStackViewDistributionFill;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(LearnMathScale(68.0));
            }];
            [btn addSubview:textLabel];
            [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btn);
                make.leading.equalTo(btn).offset(LearnMathScale(24.0));
            }];
        } else {
            [btn setImage:[UIImage imageNamed:model.imgName[i]] forState:UIControlStateNormal];
            [self.StackView addArrangedSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(LearnMathScale(72.0));
                make.height.mas_equalTo(LearnMathScale(68.0));
            }];
        }
        if (i == model.imgName.count-1 && model.imgName.count == 4) {
            [btn addSubview:home_pro];
            [home_pro mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(LearnMathScale(42.0), LearnMathScale(26.0)));
                make.top.mas_equalTo(-LearnMathScale(10.0));
                make.trailing.mas_equalTo(LearnMathScale(10.0));
            }];
        }
    }
}

-(void)buttonTapped:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(mathHomeViewMultiButtonCell:andDidTapButtonAtIndex:)]) {
        [self.delegate mathHomeViewMultiButtonCell:self andDidTapButtonAtIndex:self.tag];
    }
}
@end
