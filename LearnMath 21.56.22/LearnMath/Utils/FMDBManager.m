//
//  FMDBManager.m
//  LearnMath
//
//  Created by 基 on 2025/9/19.
//

#import "FMDBManager.h"

@implementation FMDBManager
- (instancetype)initPrivate
{
    if (self == [super init]) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"learnmath.sqlite"];
        [[NSFileManager defaultManager] removeItemAtPath:dbPath error:nil];
        _db = [FMDatabase databaseWithPath:dbPath];
        if (![_db open]) {
            NSLog(@"数据库打开失败");
        } else {
            NSLog(@"数据库打开成功：%@",dbPath);
            [_db executeUpdate:@"PRAGMA foreign_keys = ON"];
        }
    }
    return self;
}

+ (instancetype)sharedManager
{
    static FMDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] initPrivate];
    });
    return manager;
}

- (void)creatTableWithName:(NSString *)tableName andMembers:(NSDictionary<NSString *,NSString *> *)members andPrimaryKey:(NSString *)primaryKey andForeignKey:(nullable NSDictionary<NSString *,NSString *> *)foreignKeys
{
    NSMutableArray *memberArr = [NSMutableArray array];
    
    [members enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString * type, BOOL * stop) {
            NSString *memberString =[NSString stringWithFormat:@"%@ %@",key,type];
            if (primaryKey && [key isEqualToString:primaryKey]) {
                memberString = [memberString stringByAppendingString:@" PRIMARY KEY"];
            }
            [memberArr addObject:memberString];
    }];
    
    if (foreignKeys) {
            [foreignKeys enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *ref, BOOL *stop) {
                NSString *fkString = [NSString stringWithFormat:@"FOREIGN KEY (%@) REFERENCES %@", key, ref];
                [memberArr addObject:fkString];
            }];
        }
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@)",tableName,[memberArr componentsJoinedByString:@", "]];
    
    [_db executeUpdate:sql];

}

- (BOOL)insertIntoTable:(NSString *)tableName members:(NSArray<NSDictionary<NSString *, id> *> *)members
{
    BOOL allSuccess = YES;
    for (NSDictionary *dict in members) {
        NSArray *columns = dict.allKeys;
        NSMutableArray *placeHolders = [NSMutableArray array];
        NSMutableArray *args = [NSMutableArray array];
        for (NSString *key in columns) {
            [placeHolders addObject:@"?"];
            [args addObject:dict[key]];
        }
        
        NSString *sql = [NSString stringWithFormat:@"INSERT OR IGNORE INTO %@ (%@) VALUES (%@)",tableName,[columns componentsJoinedByString:@", "],[placeHolders componentsJoinedByString:@", "]];
        
        BOOL success = [_db executeUpdate:sql withArgumentsInArray:args];
        if (!success) {
            NSLog(@"插入失败 SQL: %@\n错误信息: %@", sql, _db.lastErrorMessage);
            allSuccess = NO;
        }
    }
    return allSuccess;
}

- (BOOL)deleteFromTable:(NSString *)tableName where:(NSString *)whereClause arguments:(NSArray *)args
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",tableName,whereClause];
    
    BOOL result = [_db executeUpdate:sql withArgumentsInArray:args];
    if (result) {
        NSLog(@"删除成功！");
    } else {
        NSLog(@"删除失败！");
    }
    return result;
}

- (BOOL)updateTable:(NSString *)tableName set:(NSDictionary<NSString *,id> *)values where:(NSString *)whereClause arguments:(NSArray *)args
{
    NSMutableArray *setArr = [NSMutableArray array];
    NSMutableArray *allArgs = [NSMutableArray array];
    
    for (NSString *key in values) {
        [setArr addObject:[NSString stringWithFormat:@"%@ = ?",key]];
        [allArgs addObject:values[key]];
    }
    [allArgs addObjectsFromArray:args];
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",tableName,[setArr componentsJoinedByString:@", "],whereClause];

    BOOL result = [_db executeUpdate:sql withArgumentsInArray:allArgs];
    if (result) {
        NSLog(@"更新成功！");
    } else {
        NSLog(@"更新失败！");
    }
    return result;
}

- (NSArray<NSDictionary *> *)queryTable:(NSString *)tableName columns:(nullable NSArray<NSString *> *)columns where:(nullable NSString *)whereClause argument:(nullable NSArray *)args orderBy:(nullable NSString *)orderBy
{
    if (!columns) {
            columns = @[];
        }
    
    NSMutableArray *result = [NSMutableArray array];
    NSString *columnStr = columns.count > 0 ? [columns componentsJoinedByString:@", "] : @"*";

    NSMutableString *sql = nil;
    if (whereClause && whereClause.length > 0) {
        sql = [NSMutableString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", columnStr, tableName, whereClause];
    } else {
        sql = [NSMutableString stringWithFormat:@"SELECT %@ FROM %@", columnStr, tableName];
    }

    if (orderBy.length > 0) {
            [sql appendFormat:@" ORDER BY %@",orderBy];
        }
    
    FMResultSet *rs = args ? rs = [_db executeQuery:sql withArgumentsInArray:args] : [_db executeQuery:sql];
        
    while ([rs next]) {
        NSMutableDictionary *row = [NSMutableDictionary dictionary];
        for (int i = 0; i < rs.columnCount; i++) {
            NSString *colName = [rs columnNameForIndex:i];
            id value = [rs objectForColumnIndex:i] ?: [NSNull null];
            [row setObject:value forKey:colName];
        }
        [result addObject:row];
    }
    [rs close];
    return result;
}

@end
