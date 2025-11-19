//
//  MathWorkBooksViewModel.m
//  LearnMath
//
//  Created by 基 on 2025/10/30.
//

#import "MathWorkBooksViewModel.h"

@implementation MathWorkBooksViewModel
- (MathWorkBooks *)loadBookWithBookID:(NSString *)bookID
{
    NSArray<NSDictionary *> *array = [[FMDBManager sharedManager] queryBookWithBookID:bookID];
    NSDictionary *dict = array.firstObject;
    
    if (dict) {
        return [MathWorkBooks modelWithDictionary:dict];
    }
    return nil;
}

@end
