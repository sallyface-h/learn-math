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

- (NSArray<NSDictionary *> *)queryHomeSingeleBtnData;
- (NSArray<NSDictionary *> *)queryHomeFirMultiBtnData;
- (NSArray<NSDictionary *> *)queryHomeSecMultiBtnData;
- (NSArray<NSDictionary *> *)querySkillsForCategoryID:(NSString *)categoryID;
- (NSArray<NSDictionary *> *)queryTestDigitsData;
- (NSArray<NSDictionary *> *)queryTestDigitsButtonDataForButtonID:(NSString *)buttonID;
- (NSArray<NSDictionary *> *)queryTestScopeData;
- (NSArray<NSDictionary *> *)queryTestScopeButtonDataForButtonID:(NSString *)buttonID;
- (NSArray<NSDictionary *> *)queryTestModeData;
- (NSArray<NSDictionary *> *)queryTestModeButtonDataForButtonID:(NSString *)buttonID;
- (NSArray<NSDictionary *> *)queryTestSkillData;
- (NSArray<NSDictionary *> *)queryTrainDigitsData;
- (NSArray<NSDictionary *> *)queryTrainDigitsButtonDataForButtonID:(NSString *)buttonID;
- (NSArray<NSDictionary *> *)queryTrainCountDownData;
- (NSArray<NSDictionary *> *)queryTrainCountDownDataButtonDataForButtonID:(NSString *)buttonID;
- (NSArray<NSDictionary *> *)queryTrainTip:(NSString *)skillID;
- (NSArray<NSDictionary *> *)queryTrainPreviewImage:(NSString *)skillID;
- (NSArray<NSDictionary *> *)queryBookWithBookID:(NSString *)bookID;
- (NSArray<NSDictionary *> *)queryBankWithSkillID:(NSString *)skillID;
- (NSArray<NSDictionary *> *)queryCategoryIDWithSkillID:(NSString *)skillID;
- (NSArray<NSDictionary *> *)querySkillIDWithSkillName:(NSString *)skillName categoryID:(NSString *)categoryID;
- (NSArray<NSDictionary *> *)queryCategoryIDWithCategoryName:(NSString *)categoryName;
- (NSArray<NSDictionary *> *)querySkillIDsWithCategoryID:(NSString *)categoryID;
@end

NS_ASSUME_NONNULL_END
