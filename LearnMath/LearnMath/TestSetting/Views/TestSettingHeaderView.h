//
//  TestSettingHeaderView.h
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

@interface TestSettingHeaderView : UICollectionReusableView
@property (nonatomic, strong)UILabel *titleLabel;

- (void)configureWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
