//
//  MathAnswerSheetPreviewImages.h
//  LearnMath
//
//  Created by 基 on 2025/10/21.
//

#import <Foundation/Foundation.h>

#import "ArithmeticConstant.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathAnswerSheetPreviewImages : NSObject
@property (nonatomic, copy) NSArray<NSString *> *imgName;
@property (nonatomic, copy) NSArray<NSString *> *content;
@property (nonatomic, copy) NSArray<NSNumber *> *rangeLocation;
@property (nonatomic, copy) NSArray<NSNumber *> *rangeLength;

- (instancetype)initWithImgName:(NSArray<NSString *> *)imgName content:(NSArray<NSString *> *)content rangeLocation:(NSArray<NSNumber *> *)rangeLocation rangeLength:(NSArray<NSNumber *> *)rangeLength;
+ (instancetype)modelWithImgName:(NSArray<NSString *> *)imgName content:(NSArray<NSString *> *)content rangeLocation:(NSArray<NSNumber *> *)rangeLocation rangeLength:(NSArray<NSNumber *> *)rangeLength;
@end

NS_ASSUME_NONNULL_END
