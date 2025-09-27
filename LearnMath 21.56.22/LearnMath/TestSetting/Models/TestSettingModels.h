//
//  TestSettingModels.h
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestSettingModels : NSObject
@property (nonatomic ,strong) NSArray <NSDictionary *> *calculateNum;
@property (nonatomic, strong) NSArray <NSDictionary *> *testScope;

- (instancetype)initWithCalculateNum:(NSArray <NSDictionary *> *)calculateNum andTestScope:(NSArray <NSDictionary *> *)testScope;
+ (instancetype)modelWithCalculateNum:(NSArray<NSDictionary *> *)calculateNum andTestScope:(NSArray<NSDictionary *> *)testScope;
@end

NS_ASSUME_NONNULL_END
