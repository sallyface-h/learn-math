//
//  SubscribeViewCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/28.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
@import Masonry;
@import AppearanceKit;
NS_ASSUME_NONNULL_BEGIN

@interface SubscribeViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) ScaleableButton *button;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *originalPriceLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@end
NS_ASSUME_NONNULL_END
