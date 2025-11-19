//
//  MathAnswerSheetPreviewImages.m
//  LearnMath
//
//  Created by 基 on 2025/10/21.
//

#import "MathAnswerSheetPreviewImages.h"

@implementation MathAnswerSheetPreviewImages
- (instancetype)initWithImgName:(NSArray<NSString *> *)imgName content:(NSArray<NSString *> *)content rangeLocation:(NSArray<NSNumber *> *)rangeLocation rangeLength:(NSArray<NSNumber *> *)rangeLength
{
    if (self == [super init]) {
        _imgName = imgName;
        _content = content;
        _rangeLocation = rangeLocation;
        _rangeLength = rangeLength;
    }
    return self;
}

+ (instancetype)modelWithImgName:(NSArray<NSString *> *)imgName content:(NSArray<NSString *> *)content rangeLocation:(NSArray<NSNumber*> *)rangeLocation rangeLength:(NSArray<NSNumber *> *)rangeLength
{
    return [[self alloc] initWithImgName:imgName content:content rangeLocation:rangeLocation rangeLength:rangeLength];
}
@end
