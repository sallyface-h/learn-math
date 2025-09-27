//
//  MathCateGoryViewCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@import Masonry;

NS_ASSUME_NONNULL_BEGIN

@interface MathCateGoryViewCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *scaleButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIStackView *progressStackView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UIStackView *tutorStackView;
@property (nonatomic ,strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *tutorialLabel;
@property (nonatomic, strong) UIButton *tutorialButton;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

NS_ASSUME_NONNULL_END
