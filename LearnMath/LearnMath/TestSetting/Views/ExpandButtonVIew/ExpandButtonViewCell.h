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
@import AppearanceKit;
@class ExpandButtonViewCell;
NS_ASSUME_NONNULL_BEGIN
@protocol ExpandButtonViewCellDelegate <NSObject>

- (void)ExpandButtonVIewCell:(ExpandButtonViewCell *)cell didClickedButton:(ScaleableButton *)sender;

@end
@interface ExpandButtonViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *selectedImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) ScaleableButton *selectedButton;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, weak)id<ExpandButtonViewCellDelegate> delegeate;
@end

NS_ASSUME_NONNULL_END
