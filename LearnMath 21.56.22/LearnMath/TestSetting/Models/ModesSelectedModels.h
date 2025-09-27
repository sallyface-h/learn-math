//
//  ModesSelectedModels.h
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import <Foundation/Foundation.h>
#import "ArithmeticConstant.h"
NS_ASSUME_NONNULL_BEGIN

@interface ModesSelectedModels : NSObject
@property (nonatomic, strong) NSArray<NSString *> *imgName;
@property (nonatomic, strong) NSArray<NSDictionary *> *titleText;

- (instancetype)initWithImgName:(NSArray<NSString *> *)imgName andTitleText:(NSArray<NSDictionary *> *)titleText;
+ (instancetype)modelWithImgName:(NSArray<NSString *> *)imgName andTitleText:(NSArray<NSDictionary *> *)titleText;
@end

NS_ASSUME_NONNULL_END
