//
//  MathWorkBooks.m
//  LearnMath
//
//  Created by 基 on 2025/10/24.
//

#import "MathWorkBooks.h"

@implementation MathWorkBooks
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self == [super init]) {
        _bookID = dict[@"BookID"];
        _questionID = dict[@"QuestionID"];
        _style = dict[@"Style"];
        _total = [dict[@"Total"] integerValue];
        _time = [dict[@"Time"] integerValue];
        _selectedTrainOptions = dict[@"SelectedTrainOptions"];
        _selectedTestOptions = dict[@"SelectedTestOptions"];
        
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDictionary:dict];
}


- (BOOL)isTrain {
    return [self.style isEqualToString:@"train"];
}

- (BOOL)isTest {
    return [self.style isEqualToString:@"test"];
}
@end
