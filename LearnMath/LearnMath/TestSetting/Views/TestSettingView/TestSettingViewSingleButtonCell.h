//
//  TestSettingViewSingleButtonCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "TrainingSettingModels.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "ExpandButtonModels.h"
#import "ExpandButtonViewCell.h"
#import "ExpandButtonHeaderView.h"
#import "TestSettingViewModel.h"
@import Masonry;
@import AppearanceKit;
@class TestSettingViewSingleButtonCell;
NS_ASSUME_NONNULL_BEGIN
@protocol TestSettingSingleCellDelegate <NSObject>
- (void)testSettingCell:(TestSettingViewSingleButtonCell *)cell didUpdateSelectedCategoriesNames:(NSArray<NSString *> *)selectedCategoriesNames  skillCategoryPairs:(NSArray<NSDictionary *> *)skillCategoryPairs identifier:(NSString *)identifier;;

@end
@interface TestSettingViewSingleButtonCell : UICollectionViewCell
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) ScaleableButton *settingScopeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectedImageView;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSMutableSet<NSIndexPath *> *selectedIndexPaths;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) id <TestSettingSingleCellDelegate> delegate;
- (void)configureWithExpandModel:(ExpandButtonModels *)model identifier:(NSString *)identifier expanded:(BOOL)expanded;

@end

NS_ASSUME_NONNULL_END
