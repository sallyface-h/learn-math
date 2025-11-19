//
//  TestSettingViewModel.h
//  LearnMath
//
//  Created by 基 on 2025/9/25.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"
#import "ExpandButtonModels.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestSettingViewModel : NSObject
- (NSArray<NSDictionary *> *)loadDigitsData;
- (NSArray<NSDictionary *> *)loadTestScopeData;
- (NSArray<NSDictionary *> *)loadTestMode;
- (NSArray<NSString *> *)loadImgName;
- (NSArray<NSString *> *)loadSkillName;
- (NSArray<NSString *> *)loadCategoryNames;
- (ExpandButtonModels *)loadExpandModelWithButtonID:(NSString *)buttonID;
+ (NSArray<NSString *> *)loadSkillIDWithDict:(NSArray<NSDictionary *> *)dict;
+ (NSString *)loadCategoryIDWithCategoryName:(NSString *)categoryName;
+ (NSArray<NSString *> *)loadCategoryIDsWithCategoryName:(NSArray<NSString *> *)categoryName;
+ (NSArray<NSString *> *)loadSkillIDsWithCategoryID:(NSArray<NSString *> *)categoryIDs;
@end

NS_ASSUME_NONNULL_END
