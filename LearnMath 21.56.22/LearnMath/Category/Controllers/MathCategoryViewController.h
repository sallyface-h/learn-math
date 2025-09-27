//
//  MathCategoryViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/5.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ArithmeticConstant.h"
#import "MathCateGoryViewCell.h"
#import "EachMathNavigationBar.h"
#import "UIColor+UIColor_Appearance.h"
#import "MathCategoryModels.h"
#import "TrainingSettingViewController.h"
#import "MathCategoryViewModel.h"
@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface MathCategoryViewController : BaseViewController
@property (nonatomic, assign) NSString *categoryID;
@property (nonatomic, strong) UICollectionView *categoryCollectionView;

@end

NS_ASSUME_NONNULL_END
