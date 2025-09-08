//
//  TrainingSettingViewMultiButtonCell.h
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
NS_ASSUME_NONNULL_BEGIN

@interface TrainingSettingViewMultiButtonCell : UICollectionViewCell
@property (nonatomic, strong)UIButton *settingNumButton;
@property (nonatomic ,strong)UIStackView *settingStackView;
@end

NS_ASSUME_NONNULL_END
