//
//  ModesSelectedViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import "BaseViewOCController.h"
#import "ArithmeticConstant.h"
#import "EachMathNavigationBarView.h"
#import "ModesSelectedViewCell.h"
#import "ModesSelectedModels.h"
#import "TestSettingViewModel.h"
#import "ModesSelectedHeaderView.h"
#import "ModesSelectedFooterView.h"
#import "MathAnswerSheetEntry.h"
#import "MathAnswerSheetMode.h"
#import "MathAnswerSheetViewController.h"
#import "MathWorkSelectedTestOptions.h"
@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface ModesSelectedViewController : BaseViewOCController
@property (nonatomic, strong) NSString *categoryID;
@property (nonatomic, strong) MathWorkSelectedTestOptions *testOptions;
@end

NS_ASSUME_NONNULL_END
