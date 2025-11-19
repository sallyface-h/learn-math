//
//  MathWorkBooks.h
//  LearnMath
//
//  Created by 基 on 2025/10/24.
//

#import <Foundation/Foundation.h>
@class MathWorkSelectedTestOptions;
@class MathWorkSelectedTrainOptions;
NS_ASSUME_NONNULL_BEGIN

@interface MathWorkBooks : NSObject

@property (nonatomic, copy) NSString *bookID;
@property (nonatomic, copy, nullable) NSString *questionID;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, strong, nullable) MathWorkSelectedTrainOptions *selectedTrainOptions;
@property (nonatomic, strong, nullable) MathWorkSelectedTestOptions *selectedTestOptions;
@property (nonatomic, assign) long long time;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@property (nonatomic, assign, readonly) BOOL isTrain;
@property (nonatomic, assign, readonly) BOOL isTest;
@end


NS_ASSUME_NONNULL_END
