//
//  TestSettingViewModel.h
//  LearnMath
//
//  Created by 基 on 2025/9/25.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestSettingViewModel : NSObject
- (NSArray<NSDictionary *> *)loadDigitsDate;
- (NSArray<NSDictionary *> *)loadTestScopeDate;
- (NSArray<NSDictionary *> *)loadTestMode;
- (NSArray<NSString *> *)loadImgName;
- (NSArray<NSString *> *)loadSkillName;
- (NSArray<NSString *> *)loadCategoryNames;
@end

NS_ASSUME_NONNULL_END
