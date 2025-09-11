//
//  TestSettingModels.h
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestSettingModels : NSObject
@property (nonatomic ,strong) NSArray <NSString *> *calculateNum;
@property (nonatomic, strong) NSArray <NSString *> *testScope;

- (instancetype)initWithCalculateNum:(NSArray <NSString *> *)calculateNum andTestScope:(NSArray <NSString *> *)testScope;
+ (instancetype)modelWithCalculateNum:(NSArray<NSString *> *)calculateNum andTestScope:(NSArray<NSString *> *)testScope;
@end

NS_ASSUME_NONNULL_END
