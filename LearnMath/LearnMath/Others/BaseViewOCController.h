//
//  BaseViewController.h
//  LearnMath
//
//  Created by 基 on 2025/9/7.
//

#import <UIKit/UIKit.h>
@import AppearanceKit;
@import ArithmeticKit;
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewOCController : UIViewController
@property (nonatomic, strong) NSDictionary<NSString *, id> *params;

/// 是否允许返回手势
@property (nonatomic, assign) BOOL isBackGestureEnable;

/// 导航栏隐藏
@property (nonatomic, assign) BOOL navHide;

- (instancetype)initWithParams:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
