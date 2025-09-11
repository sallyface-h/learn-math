//
//  TrainingSettingViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ArithmeticConstant.h"
#import "TrainingSettingNavigationBar.h"
#import "TrainingSettingModels.h"
#import "TrainingSettingViewMultiButtonCell.h"
#import "TrainingSettingViewSingleButtonCell.h"
#import "TrainingSettingHeaderView.h"
#import "TrainingSettingFooterView.h"

@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface TrainingSettingViewController : BaseViewController
@property (nonatomic, assign) MathCategory category;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIColor *navColor;

@end

NS_ASSUME_NONNULL_END
