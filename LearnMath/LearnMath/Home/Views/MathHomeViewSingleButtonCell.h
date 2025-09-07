//
//  MathHomeViewSingleButtonCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/3.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@import Masonry;
@class MathHomeViewSingleButtonCell;
NS_ASSUME_NONNULL_BEGIN

@protocol MathHomeViewSingleButtonCellDelegate <NSObject>

- (void)mathHomeViewSingleButtonCellDidTapButton:(MathHomeViewSingleButtonCell *)cell;

@end

@interface MathHomeViewSingleButtonCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *categoryTitle;
@property (nonatomic, strong) UIImageView *categoryImage;
@property (nonatomic, strong) UIButton *categoryButton;
@property (nonatomic, weak) id<MathHomeViewSingleButtonCellDelegate> delegate;

-(void)configureWithColor:(UIColor *)color andTitle:(NSString *)title andImage:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
