//
//  HelpModels.m
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import "HelpModels.h"

@implementation HelpModels
- (instancetype)initWithTitleText:(NSArray<NSString *> *)titleText andDetailText:(NSArray<NSString *> *)detailText andNumImage:(NSArray<NSString *> *)numImage
{
    if (self == [super init]) {
        _titleText = titleText;
        _detailText = detailText;
        _numImage = numImage;
    }
    return self;
}

+ (instancetype)modelWithTitleText:(NSArray<NSString *> *)titleText andDetailText:(NSArray<NSString *> *)detailText andNumImage:(NSArray<NSString *> *)numImage
{
    return [[self alloc] initWithTitleText:titleText andDetailText:detailText andNumImage:numImage];
}
@end
