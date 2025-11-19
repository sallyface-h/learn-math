//
//  MathCategoryModels.h
//  LearnMath
//
//  Created by 基 on 2025/9/7.
//

#import <Foundation/Foundation.h>
#import "ArithmeticConstant.h"
#import "ArithmeticDbService.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathCategoryModels : NSObject
@property (nonatomic, copy) NSArray<NSString *> *skill;
@property (nonatomic, strong) NSArray<NSString *> *tutorialVideoURLs;
@property (nonatomic, strong) NSArray<NSString *> *skillID;
@property (nonatomic, assign) NSInteger trainCount;
- (instancetype)initWithSkill:(NSArray<NSString *> *)skill andtutorialVideoURLs:(NSArray<NSString *> *)tutorialVideoURLs skillID:(NSArray<NSString *> *)skillID;
+ (instancetype)modelWithSkill:(NSArray<NSString *> *)skill andtutorialVideoURLs:(NSArray<NSString *> *)tutorialVideoURLs skillID:(NSArray<NSString *> *)skillID;

@end

NS_ASSUME_NONNULL_END
