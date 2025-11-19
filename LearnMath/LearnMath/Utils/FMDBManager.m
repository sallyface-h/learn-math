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
            id value = dict[key];
            if (value == nil || [value isKindOfClass:[NSNull class]]) {
                [args addObject:[NSNull null]];
            } else {
                [args addObject:value];
            }
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

#pragma mark - 具体业务查询
- (NSArray<NSDictionary *> *)queryHomeSingeleBtnData
{
    return [self queryTable:@"Category" columns:@[@"CategoryName",@"CategoryID"] where:@"Priority IN (?, ?, ?, ?)" argument:@[@0,@1,@2,@3] orderBy:@"Priority ASC"];
}

- (NSArray<NSDictionary *> *)queryHomeFirMultiBtnData
{
    return [self queryTable:@"Category" columns:@[@"CategoryName",@"CategoryID"] where:@"Priority IN (?, ?)" argument:@[@4,@5] orderBy:@"Priority ASC"];
}

- (NSArray<NSDictionary *> *)queryHomeSecMultiBtnData
{
    return [self queryTable:@"Category" columns:@[@"CategoryName",@"CategoryID"] where:@"Priority IN (?,?,?,?)" argument:@[@6,@7,@8,@9] orderBy:@"Priority ASC"];
}

- (NSArray<NSDictionary *> *)querySkillsForCategoryID:(NSString *)categoryID
{
    return [self queryTable:@"Skill"
                    columns:@[@"SkillName", @"SkillID",@"TutorialPath"]
                      where:@"CategoryID = ?"
                   argument:@[categoryID]
                    orderBy:@"Priority ASC"];
}

- (NSArray<NSDictionary *> *)queryTestDigitsData
{
   return [self queryTable:@"TestDigits" columns:@[@"ButtonID"] where:@"TestID = ?" argument:@[@"9f13a949-d547-4445-9f60-345d6bda11f4"] orderBy:@"Position ASC"];
}

- (NSArray<NSDictionary *> *)queryTestDigitsButtonDataForButtonID:(NSString *)buttonID
{
    return [self queryTable:@"DigitsButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
}

- (NSArray<NSDictionary *> *)queryTestScopeData
{
    return [self queryTable:@"TestScope" columns:@[@"ButtonID"] where:@"TestID = ?" argument:@[@"9f13a949-d547-4445-9f60-345d6bda11f4"] orderBy:@"Position ASC"];
}

- (NSArray<NSDictionary *> *)queryTestScopeButtonDataForButtonID:(NSString *)buttonID
{
    return [self queryTable:@"TestScopeButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
}

- (NSArray<NSDictionary *> *)queryTestModeData
{
    return [self queryTable:@"TestMode" columns:@[@"ButtonID"] where:@"TestID = ?" argument:@[@"9f13a949-d547-4445-9f60-345d6bda11f4"] orderBy:@"Position ASC"];
}

- (NSArray<NSDictionary *> *)queryTestModeButtonDataForButtonID:(NSString *)buttonID
{
    return [self queryTable:@"TestModeButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
}

- (NSArray<NSDictionary *> *)queryTestSkillData
{
    return [self queryTable:@"Skill" columns:@[@"SkillName",@"CategoryID"] where:@"" argument:nil orderBy:@"Priority ASC"];
}

- (NSArray<NSDictionary *> *)queryTrainDigitsData
{
    return [self queryTable:@"TrainDigits" columns:@[@"ButtonID"] where:@"TrainID = ?" argument:@[@"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9"] orderBy:@"Position ASC"];
}

- (NSArray<NSDictionary *> *)queryTrainDigitsButtonDataForButtonID:(NSString *)buttonID
{
    return [self queryTable:@"DigitsButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
}

- (NSArray<NSDictionary *> *)queryTrainCountDownData
{
    return [self queryTable:@"TrainCountDown" columns:@[@"ButtonID"] where:@"TrainID = ?" argument:@[@"eba3a823-32f0-4fba-bbfc-812c5b4ea5a9"] orderBy:@"Position ASC"];
}

- (NSArray<NSDictionary *> *)queryTrainCountDownDataButtonDataForButtonID:(NSString *)buttonID
{
    return [self queryTable:@"CountDownButton" columns:@[@"Text"] where:@"ButtonID = ?" argument:@[buttonID] orderBy:nil];
}

- (NSArray<NSDictionary *> *)queryTrainPreviewImage:(NSString *)skillID
{
    return [self queryTable:@"SkillPreviewImage" columns:@[@"ImageName"] where:@"SkillID = ?" argument:@[skillID] orderBy:@"Position ASC"];
}

- (NSArray<NSDictionary *> *)queryTrainTip:(NSString *)skillID
{
    return [self queryTable:@"SkillTip" columns:@[@"Content",@"RangeLocation",@"RangeLength"] where:@"SkillID = ?" argument:@[skillID] orderBy:@"Position ASC"];
}

- (NSArray<NSDictionary *> *)queryBookWithBookID:(NSString *)bookID
{
    return [self queryTable:@"MathWorkBooks" columns:@[@"Style",@"SelectedTestOptions",@"SelectedTrainOptions",@"Time",@"Total",@"QuestionID"] where:@"BookID = ?" argument:@[bookID] orderBy:nil];
}

- (NSArray<NSDictionary *> *)queryBankWithSkillID:(NSString *)skillID
{
    return [self queryTable:@"Bank" columns:@[@"BankID"] where:@"SkillID = ?" argument:@[skillID] orderBy:nil];
}

- (NSArray<NSDictionary *> *)queryCategoryIDWithSkillID:(NSString *)skillID
{
    return [self queryTable:@"SKill" columns:@[@"CategoryID"] where:@"SkillID = ?" argument:@[skillID] orderBy:nil];
}

- (NSArray<NSDictionary *> *)querySkillIDWithSkillName:(NSString *)skillName categoryID:(NSString *)categoryID
{
    return [self queryTable:@"Skill" columns:@[@"SkillID"] where:@"SkillName = ? AND CategoryID = ?" argument:@[skillName, categoryID] orderBy:nil];
}

- (NSArray<NSDictionary *> *)queryCategoryIDWithCategoryName:(NSString *)categoryName
{
    return [self queryTable:@"Category" columns:@[@"CategoryID"] where:@"CategoryName = ?" argument:@[categoryName] orderBy:nil];
}

- (NSArray<NSDictionary *> *)querySkillIDsWithCategoryID:(NSString *)categoryID
{
    return [self queryTable:@"Skill" columns:@[@"SkillID"] where:@"CategoryID = ?" argument:@[categoryID] orderBy:nil];;
}
@end
