//
//  HomeMultiButtonModel.m
//  LearnMath
//
//  Created by 基 on 2025/9/6.
//

#import "HomeMultiButtonModel.h"

@implementation HomeMultiButtonModel
- (instancetype)initWithImage:(NSArray <NSString *> *)imgName andTitle:(NSArray <NSString *> *)title andColor:(UIColor *)color andCategoryID:(NSArray <NSString *> *)categoryID
{
    if (self == [super init]) {
        _imgName = imgName;
        _title = title;
        _color = color;
        _categoryID =categoryID;
    }
    return self;
}

- (MathCategory)categoryAtIndex:(NSInteger)index {
    return (MathCategory)[self.categoryID[index] integerValue];
}

+ (instancetype)modelWithMultiButtonImgName:(NSArray <NSString *> *)imgName andTitle:(NSArray <NSString *> *)title andColor:(UIColor *)color andCategoryID:(NSArray <NSString *> *)categoryID
{
    return [[self alloc] initWithImage:imgName andTitle:title andColor:color andCategoryID:categoryID];
}

@end
