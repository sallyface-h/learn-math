//
//  EachMathNavigationBarView.m
//  LearnMath
//
//  Created by 基 on 2025/11/12.
//

#import "EachMathNavigationBarView.h"
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "CategoryExchange.h"

@interface EachMathNavigationBarView ()

@property (nonatomic, strong) ScaleableButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation EachMathNavigationBarView

- (instancetype)initWithCategoryID:(NSString *)categoryID {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupUIWithCategoryID:categoryID];
    }
    return self;
}

- (void)setupUIWithCategoryID:(NSString *)categoryID {
    self.backgroundColor = [EachMathNavigationBarView colorForCategoryID:categoryID];

    // 返回按钮
    self.backButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
    // 标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont ap_baloo:30.0 weight:UIFontWeightBold];
    self.titleLabel.textColor = [UIColor colorForSet:ColorSetWhite];
    self.titleLabel.text = [self titleForCategoryID:categoryID];
    [self addSubview:self.titleLabel];
    
    // 布局
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(LearnMathScale(24.0));
        make.bottom.equalTo(self.mas_bottom).offset(-LearnMathScale(18.0));
        make.width.height.mas_equalTo(LearnMathScale(28.0));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.backButton);
    }];
}

- (void)backAction {
    if ([self.delegate respondsToSelector:@selector(eachMathNavigationBarViewDidClickBack:)]) {
        [self.delegate eachMathNavigationBarViewDidClickBack:self];
    }
}

#pragma mark - Helper

- (NSString *)titleForCategoryID:(NSString *)categoryID {
    MathCategory category = [CategoryExchange mathCategoryForID:categoryID];
    switch (category) {
        case MathCategoryAddition: return @"Addition";
        case MathCategorySubtraction: return @"Subtraction";
        case MathCategoryMultiplication: return @"Multiplication";
        case MathCategoryDivision: return @"Division";
        case MathCategorySetting: return @"Setting";
        case MathCategoryTest: return @"Set Up Test";
        default: return @"";
    }
}

+ (UIColor *)colorForCategoryID:(NSString *)categoryID {
    MathCategory category = [CategoryExchange mathCategoryForID:categoryID];
    switch (category) {
        case MathCategoryAddition: return [UIColor colorForSet:ColorSetDeepOrange];
        case MathCategorySubtraction: return [UIColor colorForSet:ColorSetOrange];
        case MathCategoryMultiplication: return [UIColor colorForSet:ColorSetBlue];
        case MathCategoryDivision: return [UIColor colorForSet:ColorSetGreen];
        case MathCategorySetting: return [UIColor colorForSet:ColorSetPurple];
        case MathCategoryTest: return [UIColor colorForSet:ColorSetPink];
        default: return [UIColor colorForSet:ColorSetPink];
    }
}

@end
