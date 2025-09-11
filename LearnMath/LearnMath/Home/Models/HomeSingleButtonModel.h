//
//  HomeSingleButtonModel.h
//  LearnMath
//
//  Created by 基 on 2025/9/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeSingleButtonModel : NSObject
@property (nonatomic, copy) NSArray <NSString *> *imgName;
@property (nonatomic, copy) NSArray <NSString *> *title;
@property (nonatomic, strong) NSArray <UIColor *> *color;
@property (nonatomic, copy) NSArray<NSNumber *> *category;

- (instancetype)initWithTitle:(NSArray <NSString *> *)title andImage:(NSArray <NSString *> *)imgName andColor:(NSArray <UIColor *> *)color andCategory:(NSArray <NSNumber *> *)category;
+ (instancetype)modelWithSingleButtonTitle:(NSArray <NSString *> *)title andImage:(NSArray <NSString *> *)imgName andColor:(NSArray <UIColor *> *)color andCategory:(NSArray <NSNumber *> *)category;


@end

NS_ASSUME_NONNULL_END
