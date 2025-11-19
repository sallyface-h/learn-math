//
//  MathQuestionAnswer.h
//  LearnMath
//
//  Created by 基 on 2025/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MathQuestionAnswer : NSObject
/// 生成的数字
@property (nonatomic, strong) NSArray<NSNumber *> *numbers;

/// 答案
@property (nonatomic, strong) NSArray<NSNumber *> *answers;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
