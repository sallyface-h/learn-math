//
//  ModesSelectedViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import "BaseViewController.h"
#import "ArithmeticConstant.h"
#import "TestSettingNavigationBar.h"
#import "ModesSelectedViewCell.h"
#import "ModesSelectedModels.h"
#import "TestSettingViewModel.h"
#import "ModesSelectedHeaderView.h"
#import "ModesSelectedFooterView.h"
@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface ModesSelectedViewController : BaseViewController
@property (nonatomic, strong)NSString *categoryID;
@end

NS_ASSUME_NONNULL_END
