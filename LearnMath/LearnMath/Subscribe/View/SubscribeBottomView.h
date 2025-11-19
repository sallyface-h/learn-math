//
//  SubscribeBottomView.h
//  LearnMath
//
//  Created by 基 on 2025/9/28.
//

#import <UIKit/UIKit.h>
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "UIFont+UIFont_Appearance.h"
#import "UIView+UIView_Appearance.h"
@import Masonry;
@import AppearanceKit;
@class SubscribeBottomView;
NS_ASSUME_NONNULL_BEGIN

@protocol SubscribeBottomViewDelegate <NSObject>
@optional
- (void)subscriptionBottomView:(SubscribeBottomView *)subscriptionBottomView privacyButtonAction:(UIButton *)sender;
- (void)subscriptionBottomView:(SubscribeBottomView *)subscriptionBottomView serviceButtonAction:(UIButton *)sender;
- (void)subscriptionBottomView:(SubscribeBottomView *)subscriptionBottomView restoreButtonAction:(UIButton *)sender;
- (void)subscriptionBottomView:(SubscribeBottomView *)subscriptionBottomView subscribeButtonAction:(UIButton *)sender;
@end

@interface SubscribeBottomView : UIView
@property (nonatomic, strong) ScaleableButton *subscribeButton;
@property (nonatomic, strong) UILabel *expireLabel;
@property (nonatomic, strong) ScaleableButton *restoreButton;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) ScaleableButton *privacyButton;
@property (nonatomic, strong) ScaleableButton *serviceButton;
@property (nonatomic, strong) UIStackView *stackView1;
@property (nonatomic, strong) UIStackView *stackView2;

@property (nonatomic, weak) id<SubscribeBottomViewDelegate> delegate;
- (void)updateExpiredDate:(nullable NSDate *)date;
@end

NS_ASSUME_NONNULL_END
