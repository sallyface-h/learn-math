//
//  MathCateGoryCollectionViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "MathCateGoryViewCell.h"
#import "MathNavigationBarManager.h"
#import "UIColor+UIColor_Appearance.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathCateGoryCollectionViewController : UICollectionViewController
@property (nonatomic,strong)NSArray *skills;
@property (nonatomic, assign) mathCategory category;

@end

NS_ASSUME_NONNULL_END
