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
NS_ASSUME_NONNULL_BEGIN

@interface TestSettingViewMultiButtonCell : UICollectionViewCell
@property (nonatomic, strong)NSMutableArray *settingNumButtonArr;
@property (nonatomic ,strong)UIStackView *settingStackView;

- (void)configureWithCalculateNums:(NSArray<NSString *> *)calculateNums andSelectedIndex:(NSInteger)selectedIndex;
@end

NS_ASSUME_NONNULL_END
