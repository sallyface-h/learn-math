//
//  MathHomeViewMultiButtonCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/3.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"

@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface MathHomeViewMultiButtonCell : UICollectionViewCell
@property (nonatomic, strong) UIStackView *StackView;

-(void)configureWithColor:(UIColor *)color andButtons:(NSArray<NSString *> *)imgName;
@end

NS_ASSUME_NONNULL_END
