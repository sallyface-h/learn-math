//
//  HelpViewCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIFont+UIFont_Appearance.h"
#import "UIColor+UIColor_Appearance.h"
@import Masonry;
NS_ASSUME_NONNULL_BEGIN

@interface HelpViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *numImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end

NS_ASSUME_NONNULL_END
