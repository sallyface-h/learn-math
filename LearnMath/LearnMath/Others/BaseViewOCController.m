//
//  BaseViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/7.
//

#import "BaseViewOCController.h"
#import "ArithmeticConstant.h"
@interface BaseViewOCController ()

@end

@implementation BaseViewOCController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat backBtnHeight = LearnMathScale(64.0);
    
    if ((self.navigationController.viewControllers.count) > 1) {
        BaseBackButton *btn = [BaseBackButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 76.0, backBtnHeight);
        [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
}

- (instancetype)initWithParams:(NSDictionary *)params {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _params = params ?: @{};
        _isBackGestureEnable = YES;
        _navHide = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.navHide animated:animated];
    if (!self.isBackGestureEnable) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)setNavHide:(BOOL)navHide {
    _navHide = navHide;
    [self.navigationController setNavigationBarHidden:navHide animated:YES];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
