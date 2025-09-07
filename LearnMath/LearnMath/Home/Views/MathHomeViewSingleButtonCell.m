//
//  MathHomeViewSingleButtonCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/3.
//

#import "MathHomeViewSingleButtonCell.h"

@implementation MathHomeViewSingleButtonCell
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
    _categoryButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _categoryButton.layer.cornerRadius = LearnMathScale(16);
    _categoryButton.layer.masksToBounds = NO;
    _categoryButton.layer.shadowRadius = 0.0;
    _categoryButton.layer.shadowOpacity = 1.0;
    _categoryButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    _categoryButton.layer.shadowOffset = CGSizeMake(0.0, LearnMathScale(8.0));
    [self.contentView addSubview:self.categoryButton];
    [_categoryButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        }];
    
    _categoryTitle = [[UILabel alloc] init];
    _categoryTitle.font = [UIFont balooFontOfSize:24.0 weight:UIFontWeightBold];
    _categoryTitle.textColor = [UIColor colorForSet:ColorSetWhite];
    [self.categoryButton addSubview:self.categoryTitle];
    [self.categoryTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.categoryButton);
        make.leading.equalTo(self.categoryButton).offset(LearnMathScale(24.0));
           }];
    
    _categoryImage = [[UIImageView alloc] init];
    [self.categoryButton addSubview:self.categoryImage];
    [self.categoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.categoryButton);
        make.trailing.equalTo(self.categoryButton).offset(-LearnMathScale(22.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(24.0), LearnMathScale(24.0)));
            }];
}

-(void)configureWithColor:(UIColor *)color andTitle:(NSString *)title andImage:(NSString *)imageName
{
    self.categoryButton.backgroundColor = color;
    self.categoryTitle.text = title;
    self.categoryImage.image = [UIImage imageNamed:imageName];
}

-(void)buttonTapped:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(mathHomeViewSingleButtonCellDidTapButton:)]) {
        [self.delegate mathHomeViewSingleButtonCellDidTapButton:self];
    }
}

@end
