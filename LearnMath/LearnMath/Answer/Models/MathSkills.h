//
//  MathSkills.h
//  LearnMath
//
//  Created by 基 on 2025/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MathSkills : NSObject
@property (nonatomic, copy) NSString *skillID;
@property (nonatomic, copy) NSString *tutorialPath;
@property (nonatomic, copy) NSString *categoryID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *priority;
@property (nonatomic, assign) NSInteger trainCount;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
