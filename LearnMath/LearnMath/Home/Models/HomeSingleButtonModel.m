//
//  HomeSingleButtonModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/6.
//

#import "HomeSingleButtonModel.h"

@implementation HomeSingleButtonModel
- (instancetype)initWithTitle:(NSArray <NSString *> *)title andImage:(NSArray <NSString *> *)imgName andColor:(NSArray <UIColor *> *)color andCategoryID:(NSArray <NSString *> *)categoryID
{
    if (self == [super init]) {
        _title = title;
        _imgName = imgName;
        _color = color;
        _categoryID = categoryID;
    }
    return self;
}

+ (instancetype)modelWithSingleButtonTitle:(NSArray <NSString *> *)title andImage:(NSArray <NSString *> *)imgName andColor:(NSArray <UIColor *> *)color andCategoryID:(NSArray <NSString *> *)categoryID
{
    return [[self alloc]initWithTitle:title andImage:imgName andColor:color andCategoryID:categoryID];
}

@end
