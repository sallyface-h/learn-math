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
@property (nonatomic, copy) NSArray <NSString *> *imgName;
@property (nonatomic, copy) NSArray <NSString *> *title;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSArray <NSNumber *> *category;

- (instancetype)initWithImage:(NSArray <NSString *> *)imgName andTitle:(NSArray <NSString *> *)title andColor:(UIColor *)color andCategory:(NSArray <NSNumber *> *)category;
- (MathCategory)categoryAtIndex:(NSInteger)index;

+ (instancetype)modelWithMultiButtonImgName:(NSArray <NSString *> *)imgName andTitle:(NSArray <NSString *> *)title andColor:(UIColor *)color andCategory:(NSArray <NSNumber *> *)category;
@end

NS_ASSUME_NONNULL_END
