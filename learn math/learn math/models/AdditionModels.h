//
//  additionModels.h
//  learn math
//
//  Created by 基 on 2025/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdditionModels : NSObject
@property (nonatomic,copy) NSString *title;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)additionWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
