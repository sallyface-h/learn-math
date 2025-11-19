//
//  MathQuestions.h
//  LearnMath
//
//  Created by 基 on 2025/10/24.
//

#import <Foundation/Foundation.h>
@class MathQuestionAnswer;
NS_ASSUME_NONNULL_BEGIN

@interface MathQuestions : NSObject

@property (nonatomic, copy) NSString *questionID;
@property (nonatomic, copy) NSString *categoryID;
@property (nonatomic, copy) NSString *skillID;
@property (nonatomic, copy) NSString *bankID;
@property (nonatomic, assign) NSInteger digits;
@property (nonatomic, strong, nullable) MathQuestionAnswer *answer;
@property (nonatomic, assign) long long time;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
NS_ASSUME_NONNULL_END
