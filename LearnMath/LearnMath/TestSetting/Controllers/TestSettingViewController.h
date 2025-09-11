//
//  TestSettingViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ArithmeticConstant.h"
#import "TestSettingNavigationBar.h"
#import "TestSettingModels.h"
#import "TestSettingViewMultiButtonCell.h"
#import "TestSettingViewSingleButtonCell.h"
#import "TestSettingHeaderView.h"
#import "TestSettingFooterView.h"

@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface TestSettingViewController : BaseViewController
@property (nonatomic, assign) MathCategory category;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIColor *navColor;

@end

NS_ASSUME_NONNULL_END
