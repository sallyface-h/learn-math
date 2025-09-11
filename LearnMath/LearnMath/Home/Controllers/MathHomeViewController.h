//
//  MathHomeViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/4.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MathHomeViewController.h"
#import "ArithmeticConstant.h"
#import "MathCateGoryViewCell.h"
#import "MathCategoryViewController.h"
#import "MathHomeViewMultiButtonCell.h"
#import "MathHomeViewSingleButtonCell.h"
#import "MathHomeHeaderView.h"
#import "HomeSingleButtonModel.h"
#import "HomeMultiButtonModel.h"
#import "TestSettingViewController.h"
@import Masonry;

NS_ASSUME_NONNULL_BEGIN

@interface MathHomeViewController : BaseViewController
@property (nonatomic, strong) UICollectionView *collectionView;
@end


NS_ASSUME_NONNULL_END
