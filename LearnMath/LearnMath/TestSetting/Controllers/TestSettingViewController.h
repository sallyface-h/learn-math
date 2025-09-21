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
#import "HomeSingleButtonModel.h"
#import "MathCategoryModels.h"
#import "ModesSelectedViewController.h"
@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface TestSettingViewController : BaseViewController
@property (nonatomic, strong) NSArray <NSString *> *titleName;
@property (nonatomic, strong) NSString *categoryID;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) ExpandButtonType buttonType;
@end

NS_ASSUME_NONNULL_END
