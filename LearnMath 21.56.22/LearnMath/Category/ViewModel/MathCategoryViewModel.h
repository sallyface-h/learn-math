//
//  MathCategoryViewModel.h
//  LearnMath
//
//  Created by 基 on 2025/9/21.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"
#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "MathCategoryModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathCategoryViewModel : NSObject
@property (nonatomic, strong, readonly) MathCategoryModels *model;
- (void)loadDate:(NSString *)CategoryID;
@end

NS_ASSUME_NONNULL_END
