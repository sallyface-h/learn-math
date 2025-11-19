//
//  EachMathNavigationBarView.h
//  LearnMath
//
//  Created by 基 on 2025/11/12.
//

#import <UIKit/UIKit.h>
@class EachMathNavigationBarView;
@import ArithmeticKit;
@import Masonry;
@import AppearanceKit;
NS_ASSUME_NONNULL_BEGIN


@protocol EachMathNavigationBarViewDelegate <NSObject>
@optional
- (void)eachMathNavigationBarViewDidClickBack:(EachMathNavigationBarView *)navBar;
@end

@interface EachMathNavigationBarView : UIView

@property (nonatomic, weak) id<EachMathNavigationBarViewDelegate> delegate;
@property (nonatomic, strong, readonly) UILabel *titleLabel;

- (instancetype)initWithCategoryID:(NSString *)categoryID;
+ (UIColor *)colorForCategoryID:(NSString *)categoryID;
@end

NS_ASSUME_NONNULL_END
