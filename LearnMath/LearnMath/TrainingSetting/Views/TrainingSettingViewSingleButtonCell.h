//
//  TrainingSettingViewSingleButtonCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "TrainingSettingModels.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@import Masonry;
@import AppearanceKit;
NS_ASSUME_NONNULL_BEGIN

@interface TrainingSettingViewSingleButtonCell : UICollectionViewCell
@property (nonatomic, strong)ScaleableButton *settingTimeButton;
@property (nonatomic ,strong)UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
