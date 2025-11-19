//
//  MathCateGoryViewCell.h
//  LearnMath
//
//  Created by 基 on 2025/9/2.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "MathSkills.h"
@import Masonry;
@import AppearanceKit;
@class MathCateGoryViewCell;
NS_ASSUME_NONNULL_BEGIN
@protocol MathTrainsHomeCellDelegate <NSObject>
@optional

- (void)mathTrainsHomeCell:(MathCateGoryViewCell *)cell didClickedBgButton:(ScaleableButton *)bgButton;

- (void)mathTrainsHomeCell:(MathCateGoryViewCell *)cell didClickedTutorialButton:(ScaleableButton *)tutorialButton;

@end

@interface MathCateGoryViewCell : UICollectionViewCell
@property (nonatomic, strong) ScaleableButton *scaleButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIStackView *progressStackView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UIStackView *tutorStackView;
@property (nonatomic ,strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *tutorialLabel;
@property (nonatomic, strong) ScaleableButton *tutorialButton;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) NSString *skillID;
@property (nonatomic, weak) id<MathTrainsHomeCellDelegate> delegate;

- (void)configureWithSkill:(MathSkills *)skill maxTrainCount:(NSInteger)maxTrainCount;
@end

NS_ASSUME_NONNULL_END
