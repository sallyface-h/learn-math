//
//  SettingViewController.h
//  LearnMath
//
//  Created by 基 on 2025/10/14.
//

#import "BaseViewOCController.h"
#import "SettingItem.h"
#import "SettingViewCell.h"
#import "ArithmeticConstant.h"
#import "AppStoreKit.h"
@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface SettingViewController : BaseViewOCController
@property (nonatomic, strong) NSString *categoryID;

@end

NS_ASSUME_NONNULL_END
