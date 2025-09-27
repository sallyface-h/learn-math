//
//  FMDBManager.h
//  LearnMath
//
//  Created by 基 on 2025/9/19.
//

#import <Foundation/Foundation.h>
@import FMDB;
NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager : NSObject
@property (nonatomic, strong)FMDatabase *db;
+ (instancetype)sharedManager;

- (void)creatTableWithName:(NSString *)tableName andMembers:(NSDictionary<NSString *,NSString *> *)members andPrimaryKey:(NSString *)primaryKey andForeignKey:(nullable NSDictionary<NSString *,NSString *> * )foreignKeys;
- (BOOL)insertIntoTable:(NSString *)tableName members:(NSArray<NSDictionary<NSString *, id> *> *)members;
- (BOOL)deleteFromTable:(NSString *)tableName where:(NSString *)whereClause arguments:(NSArray *)args;
- (BOOL)updateTable:(NSString *)tableName set:(NSDictionary<NSString * , id> *)values where:(NSString *)whereClause arguments:(NSArray *)args;
- (NSArray<NSDictionary *> *)queryTable:(NSString *)tableName columns:(nullable NSArray<NSString *> *)columns where:(nullable NSString *)whereClause argument:(nullable NSArray *)args orderBy:(nullable NSString *)orderBy;
@end

NS_ASSUME_NONNULL_END
