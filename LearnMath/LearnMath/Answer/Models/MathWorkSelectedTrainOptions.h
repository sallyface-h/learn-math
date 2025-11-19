//
//  MathWorkSelectedTrainOptions.h
//  LearnMath
//
//  Created by 基 on 2025/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MathWorkSelectedTrainOptions : NSObject
@property (nonatomic, copy) NSString *trainDigitKey;
@property (nonatomic, copy) NSString *trainCountdownKey;
@property (nonatomic, copy) NSString *skillID;

- (NSDictionary *)toDictionary;
@end

NS_ASSUME_NONNULL_END
