//
//  SubscribeViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/28.
//

#import "BaseViewOCController.h"
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "SubscribeViewCell.h"
#import "SubscribeHeaderView.h"
#import "SubscribeModel.h"
#import "SubscribeBottomView.h"
#import "UIView+UIView_Appearance.h"
@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface SubscribeViewController : BaseViewOCController
@property (nonatomic, assign) NSString *categoryID;
@end

NS_ASSUME_NONNULL_END
