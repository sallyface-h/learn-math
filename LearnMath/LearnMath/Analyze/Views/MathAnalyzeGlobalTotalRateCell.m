//
//  MathAnalyzeGlobalTotalRateCell.m
//  LearnMath
//
//  Created by 基 on 2025/11/19.
//

#import "MathAnalyzeGlobalTotalRateCell.h"
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@interface MathAnalyzeGlobalTotalRateCell ()
@property (nonatomic, strong) UILabel *totalCountLabel;
@property (nonatomic, strong) UILabel *totalCountTextLabel;
@property (nonatomic, strong) UIStackView *totalCountStackView;
@property (nonatomic, strong) UILabel *accuracyRateLabel;
@property (nonatomic, strong) UILabel *accuracyRateTextLabel;
@property (nonatomic, strong) UIStackView *accuracyRateStackView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIView *innerView;
@end

@implementation MathAnalyzeGlobalTotalRateCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.innerView = [[UIView alloc] init];
    self.innerView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.1];
    self.innerView.layer.cornerRadius = 16;
    [self.contentView addSubview:self.innerView];
    [self.innerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.spacing = LearnMathScale(4.0);
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.alignment = UIStackViewAlignmentFill;
    [self.innerView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(LearnMathScale(20.0));
        make.trailing.mas_equalTo(-LearnMathScale(20.0));
        make.top.mas_equalTo(LearnMathScale(12.0));
        make.bottom.mas_equalTo(-LearnMathScale(12.0));
    }];
    
    self.totalCountStackView = [[UIStackView alloc] init];
    self.totalCountStackView.spacing = LearnMathScale(8.0);
    self.totalCountStackView.distribution = UIStackViewDistributionFill;
    self.totalCountStackView.axis = UILayoutConstraintAxisVertical;
    self.totalCountStackView.alignment = UIStackViewAlignmentCenter;
    [self.stackView addArrangedSubview:self.self.totalCountStackView];
    
    self.totalCountLabel = [[UILabel alloc] init];
    self.totalCountLabel.textAlignment = NSTextAlignmentCenter;
    self.totalCountLabel.font = [UIFont ap_poppins:LearnMathScale(14.0) weight:UIFontWeightBold];
    self.totalCountLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    self.totalCountLabel.text = @"Total Count";
    [self.totalCountStackView addArrangedSubview:self.totalCountLabel];
    [self.totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LearnMathScale(18.0));
    }];
    
    self.totalCountTextLabel = [[UILabel alloc] init];
    self.totalCountTextLabel.textAlignment = NSTextAlignmentCenter;
    self.totalCountTextLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.totalCountTextLabel.textColor = [UIColor colorForSet:ColorSetBlue];
    [self.totalCountStackView addArrangedSubview:self.totalCountTextLabel];
    
    self.accuracyRateStackView = [[UIStackView alloc] init];
    self.accuracyRateStackView.spacing = LearnMathScale(8.0);
    self.accuracyRateStackView.distribution = UIStackViewDistributionFill;
    self.accuracyRateStackView.axis = UILayoutConstraintAxisVertical;
    self.accuracyRateStackView.alignment = UIStackViewAlignmentCenter;
    [self.stackView addArrangedSubview:self.accuracyRateStackView];
    
    self.accuracyRateLabel = [[UILabel alloc] init];
    self.accuracyRateLabel.textAlignment = NSTextAlignmentCenter;
    self.accuracyRateLabel.font = [UIFont ap_poppins:LearnMathScale(14.0) weight:UIFontWeightBold];
    self.accuracyRateLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    self.accuracyRateLabel.text = @"Accuracy Rate";
    [self.accuracyRateStackView addArrangedSubview:self.accuracyRateLabel];
    [self.accuracyRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LearnMathScale(18.0));
    }];
    
    self.accuracyRateTextLabel = [[UILabel alloc] init];
    self.accuracyRateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.accuracyRateTextLabel.font = [UIFont ap_baloo:LearnMathScale(40.0) weight:UIFontWeightRegular];
    self.accuracyRateTextLabel.textColor = [UIColor colorForSet:ColorSetBlue];
    [self.accuracyRateStackView addArrangedSubview:self.accuracyRateTextLabel];
}
@end
