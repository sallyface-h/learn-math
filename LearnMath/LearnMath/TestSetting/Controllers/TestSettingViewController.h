//
//  TestSettingViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import <UIKit/UIKit.h>
#import "BaseViewOCController.h"
#import "ArithmeticConstant.h"
#import "EachMathNavigationBarView.h"
#import "TestSettingModels.h"
#import "TestSettingViewMultiButtonCell.h"
#import "TestSettingViewSingleButtonCell.h"
#import "TestSettingHeaderView.h"
#import "TestSettingFooterView.h"
#import "HomeSingleButtonModel.h"
#import "MathCategoryModels.h"
#import "ModesSelectedViewController.h"
#import "TestSettingViewModel.h"
#import "MathAnswerSheetEntry.h"
#import "MathAnswerSheetMode.h"
#import "MathAnswerSheetViewController.h"
#import "MathWorkSelectedTestOptions.h"
@import Masonry;
@class TestSettingViewSingleButtonCell;
@class TestSettingViewMultiButtonCell;
NS_ASSUME_NONNULL_BEGIN


@interface TestSettingViewController : BaseViewOCController
@property (nonatomic, strong) NSArray <NSString *> *titleName;
@property (nonatomic, strong) NSString *categoryID;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
