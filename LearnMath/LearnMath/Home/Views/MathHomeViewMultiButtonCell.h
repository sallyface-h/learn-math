//
//  MathHomeViewMultiButtonCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/3.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@import Masonry;
@class MathHomeViewMultiButtonCell;
NS_ASSUME_NONNULL_BEGIN

@protocol MathHomeViewMultiButtonCellDelegate <NSObject>

- (void)mathHomeViewMultiButtonCell:(MathHomeViewMultiButtonCell *)cell andDidTapButtonAtIndex:(NSInteger)index;

@end

@interface MathHomeViewMultiButtonCell : UICollectionViewCell
@property (nonatomic, strong) UIStackView *StackView;
@property (nonatomic, weak)id<MathHomeViewMultiButtonCellDelegate>delegate;

-(void)configureWithColor:(UIColor *)color andButtonsImgName:(NSArray<NSString *> *)imgName;

@end

NS_ASSUME_NONNULL_END
