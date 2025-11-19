//
//  DBInitializer.h
//  LearnMath
//
//  Created by 基 on 2025/9/27.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface DBInitializer : NSObject
+ (void)creatTable;
+ (void)insertDateToTable;
@end

NS_ASSUME_NONNULL_END
