//
//  MathWorkSelectedTestOptions.h
//  LearnMath
//
//  Created by 基 on 2025/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MathWorkSelectedTestOptions : NSObject
/// 测试范围
@property (nonatomic, copy) NSString *testRangeKey;

/// 测试类型（多个 categoryId）
@property (nonatomic, strong) NSArray<NSString *> *testCategoires;

/// 测试技能（多个 skillId）
@property (nonatomic, strong) NSArray<NSString *> *testSkills;
@property (nonatomic, copy) NSString *testDigitKey;
@property (nonatomic, copy) NSString *testModeKey;
- (NSDictionary *)toDictionary;
@end

NS_ASSUME_NONNULL_END
