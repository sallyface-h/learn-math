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
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) MathCategory category;

-(instancetype)initWithTitle:(NSString *)title andImage:(NSString *)imgName andColor:(UIColor *)color andCategory:(MathCategory)category;
+(NSArray<HomeSingleButtonModel *> *)singleButtonModel;

@end

NS_ASSUME_NONNULL_END
