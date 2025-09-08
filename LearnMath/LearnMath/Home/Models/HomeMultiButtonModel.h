//
//  HomeMultiButtonModel.h
//  LearnMath
//
//  Created by 基 on 2025/9/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeMultiButtonModel : NSObject
@property (nonatomic, copy)NSArray *imgName;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSArray<NSNumber *> *category;

-(instancetype)initWithImage:(NSArray <NSString *> *)imgName andColor:(UIColor *)color andCategory:(NSArray<NSNumber *> *)category;
-(MathCategory)categoryAtIndex:(NSInteger)index;
+(NSArray<HomeMultiButtonModel *> *)multiButtonModelMake;
@end

NS_ASSUME_NONNULL_END
