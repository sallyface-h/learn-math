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
    _StackView.distribution = UIStackViewDistributionFill;
    _StackView.axis = UILayoutConstraintAxisHorizontal;
    _StackView.alignment = UIStackViewAlignmentCenter;
    _StackView.spacing = LearnMathScale(13.0);
    [self.contentView addSubview:self.StackView];
    [self.StackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
    }];
    
    
        
}
- (void)configureWithColor:(UIColor *)color andButtons:(NSArray<NSString *> *)imgName;
{
    for (UIView *sub in self.StackView.arrangedSubviews) {
            [self.StackView removeArrangedSubview:sub];
            [sub removeFromSuperview];
        }

        for (NSString *name in imgName) {
            UIButton *btn = [[UIButton alloc] init];
            btn.backgroundColor = color;
            btn.layer.cornerRadius = LearnMathScale(16.0);
            btn.layer.shadowRadius =  0.0;
            btn.layer.shadowOpacity = 1.0;
            btn.layer.masksToBounds = NO;
            btn.layer.shadowOffset = CGSizeMake(0.0, LearnMathScale(8.0));
            btn.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
            [self.StackView addArrangedSubview:btn];
            
            UILabel *testLabel = [[UILabel alloc] init];
            testLabel.font = [UIFont systemFontOfSize:24];
            testLabel.textColor = [UIColor colorForSet:ColorSetWhite];
            testLabel.text = @"Do a Test!";
            if ([name isEqualToString: @"nil"]) {
                [self.StackView addArrangedSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(LearnMathScale(242.0));
                    make.height.mas_equalTo(LearnMathScale(68.0));
                }];
                [btn addSubview:testLabel];
                [testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                                    make.centerY.equalTo(btn);
                                    make.left.equalTo(btn).offset(LearnMathScale(24.0));
                }];
                
            } else {
                [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
                
                [self.StackView addArrangedSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(LearnMathScale(72.0));
                    make.height.mas_equalTo(LearnMathScale(68.0));
                }];
            }

            
        }
}
@end
