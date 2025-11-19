//
//  MathAnswerSheetInputCell.h
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import <UIKit/UIKit.h>
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@import AppearanceKit;
@import Masonry;

@class MathAnswerSheetInputCell, ScaleableButton, MathAnswerSheetInputItem;
NS_ASSUME_NONNULL_BEGIN

@protocol MathAnswerSheetInputCellDelegate <NSObject>
- (void)mathAnswerSheetInputCell:(MathAnswerSheetInputCell *)cell didClickedOperationButton:(ScaleableButton *)button item:(MathAnswerSheetInputItem *)item;
@end

@interface MathAnswerSheetInputCell : UICollectionViewCell
@property (nonatomic, weak) id<MathAnswerSheetInputCellDelegate> delegate;

- (void)configureWithItem:(MathAnswerSheetInputItem *)item;
@end

NS_ASSUME_NONNULL_END
