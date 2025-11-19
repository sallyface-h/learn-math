//
//  MathWorkBooksViewModel.h
//  LearnMath
//
//  Created by 基 on 2025/10/30.
//

#import <Foundation/Foundation.h>
#import "MathWorkBooks.h"
#import "FMDBManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface MathWorkBooksViewModel : NSObject
- (MathWorkBooks *)loadBookWithBookID:(NSString *)bookID;
@end

NS_ASSUME_NONNULL_END
