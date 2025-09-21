//
//  ModesSelectedModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import "ModesSelectedModels.h"

@implementation ModesSelectedModels
- (instancetype)initWithImgName:(NSArray<NSString *> *)imgName andTitleText:(NSArray<NSString *> *)titleText
{
    if (self == [super init]) {
        _imgName = imgName;
        _titleText = titleText;
    }
    return self;
}

+ (instancetype)modelWithImgName:(NSArray<NSString *> *)imgName andTitleText:(NSArray<NSString *> *)titleText
{
    return [[self alloc] initWithImgName:imgName andTitleText:titleText];
}
@end
