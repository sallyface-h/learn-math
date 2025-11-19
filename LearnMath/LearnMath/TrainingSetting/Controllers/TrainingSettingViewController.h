//
//  TrainingSettingViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import <UIKit/UIKit.h>
#import "BaseViewOCController.h"
#import "ArithmeticConstant.h"
#import "TrainingSettingModels.h"
#import "TrainingSettingViewMultiButtonCell.h"
#import "TrainingSettingViewSingleButtonCell.h"
#import "TrainingSettingHeaderView.h"
#import "TrainingSettingFooterView.h"
#import "TrainSettingViewModel.h"
#import "MathAnswerSheetViewController.h"
#import "MathWorkSelectedTrainOptions.h"
#import "MathAnswerSheetEntry.h"
#import "MathAnswerSheetMode.h"
#import "EachMathNavigationBarView.h"
@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface TrainingSettingViewController : BaseViewOCController
@property (nonatomic, strong) NSString *categoryID;
@property (nonatomic, strong) NSString *skillID;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIColor *navColor;

@end

NS_ASSUME_NONNULL_END
