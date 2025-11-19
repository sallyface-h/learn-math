//
//  TestSettingViewMultiButtonCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "TrainingSettingModels.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@import Masonry;
@import AppearanceKit;
NS_ASSUME_NONNULL_BEGIN

@interface TestSettingViewMultiButtonCell : UICollectionViewCell
@property (nonatomic, strong)NSMutableArray *settingNumButtonArr;
@property (nonatomic ,strong)UIStackView *settingStackView;

- (void)configureWithCalculateNums:(NSArray<NSDictionary *> *)calculateNums;
@end

NS_ASSUME_NONNULL_END
