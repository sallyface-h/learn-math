//
//  HomeSingleButtonModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/6.
//

#import "HomeSingleButtonModel.h"

@implementation HomeSingleButtonModel
- (instancetype)initWithTitle:(NSArray <NSString *> *)title andImage:(NSArray <NSString *> *)imgName andColor:(NSArray <UIColor *> *)color andCategory:(NSArray <NSNumber *> *)category
{
    if (self == [super init]) {
        _title = title;
        _imgName = imgName;
        _color = color;
        _category = category;
    }
    return self;
}

+ (instancetype)modelWithSingleButtonTitle:(NSArray <NSString *> *)title andImage:(NSArray <NSString *> *)imgName andColor:(NSArray <UIColor *> *)color andCategory:(NSArray <NSNumber *> *)category
{
    return [[self alloc]initWithTitle:title andImage:imgName andColor:color andCategory:category];
}

@end
