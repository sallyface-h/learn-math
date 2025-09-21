//
//  HelpModels.h
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpModels : NSObject
@property (nonatomic, strong) NSArray<NSString *> *titleText;
@property (nonatomic, strong) NSArray<NSString *> *detailText;
@property (nonatomic, strong) NSArray<NSString *> *numImage;

- (instancetype)initWithTitleText:(NSArray<NSString *> *)titleText andDetailText:(NSArray<NSString *> *)detailText andNumImage:(NSArray<NSString *> *)numImage;
+ (instancetype)modelWithTitleText:(NSArray<NSString *> *)titleText andDetailText:(NSArray<NSString *> *)detailText andNumImage:(NSArray<NSString *> *)numImage;
@end

NS_ASSUME_NONNULL_END
