//
//  ExpandButtonViewCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/14.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "TrainingSettingModels.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface ExpandButtonViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *selectedImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
