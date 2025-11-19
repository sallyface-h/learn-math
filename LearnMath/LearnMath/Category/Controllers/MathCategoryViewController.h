//
//  MathCategoryViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/5.
//

#import <UIKit/UIKit.h>
#import "BaseViewOCController.h"
#import "ArithmeticConstant.h"
#import "MathCateGoryViewCell.h"
#import "UIColor+UIColor_Appearance.h"
#import "MathCategoryModels.h"
#import "TrainingSettingViewController.h"
#import "MathCategoryViewModel.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "EachMathNavigationBarView.h"
#import "ArithmeticDbService.h"
@import Masonry;
@import ArithmeticKit;
@import AppearanceKit;
@import ArithmeticPlayer;
@import AppToolKit;
@import AppStoreKit;
NS_ASSUME_NONNULL_BEGIN

@interface MathCategoryViewController : BaseViewOCController
@property (nonatomic, assign) NSString *categoryID;
@property (nonatomic, assign) NSString *skillID;
@property (nonatomic, strong) UICollectionView *categoryCollectionView;

@end

NS_ASSUME_NONNULL_END
