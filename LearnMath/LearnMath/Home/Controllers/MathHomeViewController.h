//
//  MathHomeViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/4.
//

#import <UIKit/UIKit.h>
#import "MathHomeViewController.h"
#import "ArithmeticConstant.h"
#import "MathCateGoryViewCell.h"
#import "MathCateGoryCollectionViewController.h"
#import "MathHomeViewMultiButtonCell.h"
#import "MathHomeViewSingleButtonCell.h"
#import "MathHomeHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathHomeViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *multiButtonImgNameArr;
@end

NS_ASSUME_NONNULL_END
