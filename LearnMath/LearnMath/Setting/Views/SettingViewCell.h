//
//  SettingViewCell.h
//  LearnMath
//
//  Created by 基 on 2025/10/14.
//

#import <UIKit/UIKit.h>
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "SettingItem.h"
#import "ArithmeticConstant.h"
NS_ASSUME_NONNULL_BEGIN
@import Masonry;
@import SevenSwitch;
@import AppearanceKit;
@class SettingViewCell;

@protocol SettingsCellDelegate <NSObject>
- (void)settingsCell:(SettingViewCell *)cell switchBtnValueChanged:(SevenSwitch *)switchBtn;
- (void)settingsCell:(SettingViewCell *)cell didClickedClearBtn:(UIButton *)button;
@end

@interface SettingViewCell : UICollectionViewCell
@property (nonatomic, strong) ScaleableButton *scaleButton;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) ScaleableButton *clearButton;
@property (nonatomic, strong) SevenSwitch *switchBtn;
@property (nonatomic, weak) id<SettingsCellDelegate> delegate;
- (void)configureWithItem:(SettingItem *)item;
@end

NS_ASSUME_NONNULL_END
