//
//  MathCategoryModels.h
//  LearnMath
//
//  Created by 基 on 2025/9/7.
//

#import <Foundation/Foundation.h>
#import "ArithmeticConstant.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathCategoryModels : NSObject
@property (nonatomic, copy)NSArray *skill;

- (instancetype)initWithSkill:(NSArray <NSString *> *)skill;
+ (instancetype)modelWithCategory:(MathCategory)categor andSkillDict:(NSDictionary <NSNumber * , NSArray <NSString *> *> *)skillDict;
@end

NS_ASSUME_NONNULL_END
