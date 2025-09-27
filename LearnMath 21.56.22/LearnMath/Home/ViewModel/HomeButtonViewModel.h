//
//  HomeButtonViewModel.h
//  LearnMath
//
//  Created by 基 on 2025/9/19.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"
#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "HomeSingleButtonModel.h"
#import "HomeMultiButtonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeButtonViewModel : NSObject
@property (nonatomic, strong)HomeButtonViewModel *HomeViewModel;
@property (nonatomic, strong, readonly) HomeSingleButtonModel *singleButtonModels;
@property (nonatomic, strong, readonly) NSArray<HomeMultiButtonModel *> *multiButtonModels;
- (void)loadCategoryDate;
@end

NS_ASSUME_NONNULL_END
