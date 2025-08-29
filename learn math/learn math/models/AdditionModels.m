//
//  additionModels.m
//  learn math
//
//  Created by 基 on 2025/8/28.
//

#import "AdditionModels.h"

@implementation AdditionModels
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self==[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)additionWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
